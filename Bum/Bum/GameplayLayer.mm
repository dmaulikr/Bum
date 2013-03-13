//
//  GameplayLayer.m
//  Bum
//
//  Created by Grant Davis on 3/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"
#import "EntityManager.h"
#import "EntityFactory.h"
#import "HealthSystem.h"
#import "RenderComponent.h"
#import "MovementSystem.h"
#import "Box2D.h"
#import "GLES-Render.h"

typedef enum {
    DepthLevelBackground = 0,
    DepthLevelCharacters
} DepthLevel;

@interface GameplayLayer () {
    
    // cocos2d
    CCSpriteBatchNode *_batchNode;
    
    // box2d
    b2World* world;
    GLESDebugDraw *m_debugDraw;
    
    // entity system
    EntityManager *_entityManager;
    EntityFactory *_entityFactory;
    
    HealthSystem *_healthSystem;
    MovementSystem *_movementSystem;
    
    Entity * _player;
    Entity * _enemy;
}

@end

@implementation GameplayLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameplayLayer *layer = [GameplayLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}



- (id)init
{
    if (self = [super init]) {
        [self setup];
        [self addPlayers];
    }
    return self;
}


- (void)setup
{
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"bum.plist"];
    
//    CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"background.png"];
//    background.position = ccp(background.contentSize.width * .5, background.contentSize.height * .5);
//    [self addChild:background z:DepthLevelBackground];
    
    _batchNode = [CCSpriteBatchNode batchNodeWithFile:@"bum.pvr.ccz"];
    [self addChild:_batchNode z:DepthLevelCharacters];
    
    [self initPhysics];
    [self scheduleUpdate];
}


-(void) initPhysics
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


- (void)addPlayers
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGFloat inset = winSize.width * .1;
    
    _entityManager = [[EntityManager alloc] init];
    _entityFactory = [[EntityFactory alloc] initWithEntityManager:_entityManager batchNode:_batchNode];
    
    _healthSystem = [[HealthSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
    _movementSystem = [[MovementSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
    
    _player = [_entityFactory createHumanPlayer];
    
    RenderComponent * humanRender = _player.render;
    CGPoint humanStartPoint = ccp(humanRender.node.contentSize.width/2 + inset, winSize.height/4);
    humanRender.node.position = humanStartPoint;
    
    _enemy = [_entityFactory createAIPlayer];
    RenderComponent *aiRenderer = _enemy.render;
    if (aiRenderer) {
        aiRenderer.node.position = ccp(winSize.width - aiRenderer.node.contentSize.width/2 - inset, winSize.height/4);
    }
}


- (void)update:(ccTime)dt
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
    
    
    [_movementSystem update:dt];
    [_healthSystem update:dt];
}

- (void)draw
{
    [_healthSystem draw];
}


@end
