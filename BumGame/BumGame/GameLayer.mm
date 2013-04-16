//
//  GameLayer.m
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "CCBReader.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "EntityManager.h"
#import "EntityFactory.h"
#import "HealthSystem.h"
#import "RenderComponent.h"
#import "MovementComponent.h"
#import "MovementSystem.h"
#import "ActionSystem.h"
#import "ActionComponent.h"
#import "PlayerComponent.h"
#import "CameraSystem.h"
#import "ControlsSystem.h"
#import "ProjectileSystem.h"
#import "Bum.h"

@interface GameLayer () {
    b2World* world;					// strong ref
	GLESDebugDraw *m_debugDraw;		// strong ref
    
    // set from CCB
    Bum *player;
    
    // entity framework
    EntityManager *_entityManager;
    EntityFactory *_entityFactory;
    
    // game systems
    HealthSystem *_healthSystem;
    MovementSystem *_movementSystem;
    ActionSystem *_actionSystem;
    CameraSystem *_cameraSystem;
    ControlsSystem *_controlsSystem;
    ProjectileSystem *_projectileSystem;
}

@end


@implementation GameLayer

-(void) dealloc
{
	delete world;
	world = NULL;
	
	delete m_debugDraw;
	m_debugDraw = NULL;
}


- (void)didLoadFromCCB
{
    NSLog(@"GameLayer loaded with player: %@", player);
    
    // initialize world
    [self createEntitySystem];
    [self createGameSystems];
    
    [self initPhysics];
    [self initPlayer];
    
    [self scheduleUpdate];
}


- (void)createEntitySystem
{
    _entityManager = [[EntityManager alloc] init];
    _entityFactory = [[EntityFactory alloc] initWithEntityManager:_entityManager layer:self];
}


- (void)initPhysics
{
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	b2Vec2 gravity;
	gravity.Set(0.0f, -10.0f);
	world = new b2World(gravity);
	
	// Do we want to let bodies sleep?
	world->SetAllowSleeping(true);
	world->SetContinuousPhysics(true);
	
	m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	world->SetDebugDraw(m_debugDraw);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
	//		flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
	//		flags += b2Draw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);
	
	
	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	
	// Call the body factory which allocates memory for the ground body
	// from a pool and creates the ground box shape (also from a pool).
	// The body is also added to the world.
	b2Body* groundBody = world->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.
	b2EdgeShape groundBox;
	
	// bottom
	
	groundBox.Set(b2Vec2(0,0), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// top
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO));
	groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
}


- (void)initPlayer
{
    [_entityFactory createPlayerWithSprite:player.sprite];
}


- (void)createGameSystems
{
    _healthSystem = [[HealthSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
    _movementSystem = [[MovementSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
    _actionSystem = [[ActionSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
    _cameraSystem = [[CameraSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory layer:self];
    _controlsSystem = [[ControlsSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
    _projectileSystem = [[ProjectileSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
    
    // TODO: refactor system into a singleton manager and retrieve by class
    _controlsSystem.projectileSystem = _projectileSystem;
    _projectileSystem.actionSystem = _actionSystem;
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
	
	world->DrawDebugData();
	
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
	world->Step(dt, velocityIterations, positionIterations);
    
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
