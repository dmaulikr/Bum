//
//  GameLayer.m
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "CCBReader.h"
#import "RenderComponent.h"
#import "MovementComponent.h"
#import "ActionComponent.h"
#import "PlayerComponent.h"
#import "GB2ShapeCache.h"
#import "GB2ShapeCache+Helpers.h"

@interface GameLayer () {
    
}

@end


@implementation GameLayer

-(void) dealloc
{
	delete _world;
	_world = NULL;
	
	delete m_debugDraw;
	m_debugDraw = NULL;
}


- (void)didLoadFromCCB
{
    assert(player != nil);
    
    [self initPhysics];
    
    [self createEntitySystem];
    [self createGameSystems];
    [self createInterface];
    [self createLevelBoundaries];
    
    [self scheduleUpdate];
}


- (void)initPhysics
{
    // add shapes from PhysicsEditor
    [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"gameobjects-physics.plist"];
    
    // create world
    CGSize s = _level.contentSize;
    
    // here we adjust the size of the world to compensate for the scaling
    // automatically done by CocosBuilder. because all levels are designed to
    // ipad size in mind (because its the largest image size) we need to maintain
    // a common size for the physics simulation no matter the resolution. since
    // CocosBuilder will automatically scale down our level size to match the resolution,
    // we need to double the world size to match the scaling down of content.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        s.width  *= 2;
        s.height  *= 2;
    }
    NSLog(@"Level dimensions: %@", NSStringFromCGSize(s));
	
	b2Vec2 gravity;
	gravity.Set(0.0f, -30.0f);
	_world = new b2World(gravity);
	
	// Do we want to let bodies sleep?
	_world->SetAllowSleeping(true);
	_world->SetContinuousPhysics(true);
	
	m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	_world->SetDebugDraw(m_debugDraw);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
    flags += b2Draw::e_jointBit;
    flags += b2Draw::e_aabbBit;
    flags += b2Draw::e_pairBit;
    flags += b2Draw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);
	
	
	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	
	// Call the body factory which allocates memory for the ground body
	// from a pool and creates the ground box shape (also from a pool).
	// The body is also added to the world.
	b2Body* groundBody = _world->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.
	b2EdgeShape groundBox;
	
	// bottom
	groundBox.Set(b2Vec2(0,0), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// top
//	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO));
//	groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
}


- (void)createEntitySystem
{
    _entityManager = [[EntityManager alloc] initWithWorld:_world];
}


- (void)createGameSystems
{
    _healthSystem = [[HealthSystem alloc] initWithEntityManager:_entityManager];
    _movementSystem = [[MovementSystem alloc] initWithEntityManager:_entityManager world:_world];
    _actionSystem = [[ActionSystem alloc] initWithEntityManager:_entityManager];
    _cameraSystem = [[CameraSystem alloc] initWithEntityManager:_entityManager layer:_level];
    _controlsSystem = [[ControlsSystem alloc] initWithEntityManager:_entityManager player:player];
    _projectileSystem = [[ProjectileSystem alloc] initWithEntityManager:_entityManager];
    _collisionSystem = [[CollisionSystem alloc] initWithWorld:_world];
    
    // TODO: refactor system into a singleton manager and retrieve by class
    _controlsSystem.projectileSystem = _projectileSystem;
    _projectileSystem.actionSystem = _actionSystem;
}


- (void)createInterface
{
    CGSize s = [[CCDirector sharedDirector] winSize];
    GameInterface *interface = (GameInterface *)[CCBReader nodeGraphFromFile:@"Interface.ccbi"
                                                                      owner:nil
                                                                 parentSize:CGSizeMake(s.height, s.width)];
    assert([interface isKindOfClass:[GameInterface class]]);
    [self addChild:interface];
    
    // allow controls to manage the interface
    _controlsSystem.interface = interface;
}


- (void)createLevelBoundaries
{
    // make sure the boundaries name has been defined in CCB
    assert(self.boundaryName != nil);
    
    NSString *shapeName = self.boundaryName;
    if ([[GB2ShapeCache sharedShapeCache] hasBodyNamed:shapeName]) {
        
        boundaries = [CCNode node];
        boundaries.tag = GameObjectTypeFloor;
        [self addChild:boundaries];
        
        // create a body for physics interactions
        b2BodyDef bodyDef;
        bodyDef.type = b2_staticBody;
        b2Body *body = _world->CreateBody(&bodyDef);
        body->SetUserData((__bridge void *)boundaries);
        body->SetFixedRotation(YES);
        
        // add the fixture definitions to the body
        [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:shapeName];
    }
}


-(void) draw
{
	//
	// IMPORTANT:
	// This is only for debug purposes
	// It is recommend to disable it
	//
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	kmGLPushMatrix();
	
	_world->DrawDebugData();
	
	kmGLPopMatrix();
}



-(void) update: (ccTime) dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	_world->Step(dt, velocityIterations, positionIterations);
    
    // update movement first so all CCNodes have the correct position set from the box2D world
    [_movementSystem update:dt];
    
    // update projectile statuses
    [_projectileSystem update:dt];
    
    // update resources
    [_healthSystem update:dt];
    
    // add player controls
    [_controlsSystem update:dt];
    
    [_actionSystem update:dt];
    
    [_cameraSystem update:dt];
}


@end
