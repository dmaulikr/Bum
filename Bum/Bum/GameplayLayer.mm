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
#import "MovementComponent.h"
#import "MovementSystem.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "ActionSystem.h"
#import "ActionComponent.h"
#import "PlayerComponent.h"
#import "LevelHelperLoader.h"
#import "CameraSystem.h"
#import "ControlsSystem.h"
#import "ProjectileSystem.h"

typedef enum {
    DepthLevelBackground = 0,
    DepthLevelMainMap,
    DepthLevelCharacters
} DepthLevel;

@interface GameplayLayer () {
    
    // box2d
    b2World* _world;
    GLESDebugDraw *m_debugDraw;
    
    // level helper
    LevelHelperLoader *_loader;
    LHParallaxNode *_parallax;
    
    // entity system
    EntityManager *_entityManager;
    EntityFactory *_entityFactory;
    
    HealthSystem *_healthSystem;
    MovementSystem *_movementSystem;
    ActionSystem *_actionSystem;
    CameraSystem *_cameraSystem;
    ControlsSystem *_controlsSystem;
    ProjectileSystem *_projectileSystem;
    
    Entity * _player;
    Entity * _enemy;
}

@end

@implementation GameplayLayer


- (id)init
{
    if (self = [super init]) {
        [self setup];
        [self createGameObjects];
    }
    return self;
}


- (void)dealloc
{
    delete _world;
	_world = NULL;
	
	delete m_debugDraw;
	m_debugDraw = NULL;
    
    _loader = nil;
}

- (void)setHud:(HUDLayer *)hud
{
    if (_hud) {
        _hud.dPad.delegate = nil;
        _hud.jumpButton.delegate = nil;
    }
    _hud = hud;
    _controlsSystem.hud = hud;
}


- (void)setup
{
    [self initPhysics];
    [self initLevel];
    [self scheduleUpdate];
}

- (void)initLevel
{
    _loader = [[LevelHelperLoader alloc] initWithContentOfFile:@"level0"];
    [_loader addObjectsToWorld:_world cocos2dLayer:self];
    [_loader createPhysicBoundaries:_world];
    [_loader createGravity:_world];
    [_loader useLevelHelperCollisionHandling];
    [LevelHelperLoader dontStretchArt];
    NSLog(@"Game screen size: %@", NSStringFromCGSize(_loader.gameScreenSize));
    NSLog(@"Game world size: %@", NSStringFromCGRect(_loader.gameWorldSize));
}


-(void) initPhysics
{
//    CGSize s = [[CCDirector sharedDirector] winSize];
    
	b2Vec2 gravity;
	gravity.Set(0.0f, -100.0f);
	_world = new b2World(gravity);
	
	// Do we want to let bodies sleep?
	_world->SetAllowSleeping(true);
	_world->SetContinuousPhysics(true);
}


- (void)createGameObjects
{
    _entityManager = [[EntityManager alloc] init];
    _entityFactory = [[EntityFactory alloc] initWithEntityManager:_entityManager layer:self levelHelperLoader:_loader];
    
    [self createGameSystems];
    [self addHero];
}

- (void)createGameSystems
{
    _healthSystem = [[HealthSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory loader:_loader];
    _movementSystem = [[MovementSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory loader:_loader];
    _actionSystem = [[ActionSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory loader:_loader];
    _cameraSystem = [[CameraSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory levelLoader:_loader layer:self];
    _controlsSystem = [[ControlsSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory loader:_loader];
    _projectileSystem = [[ProjectileSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory loader:_loader];
    
    // TODO: refactor system into a singleton manager and retrieve by class
    _controlsSystem.projectileSystem = _projectileSystem;
    _projectileSystem.actionSystem = _actionSystem;
}


- (void)addHero
{
    _player = [_entityFactory createHumanPlayer];
    _controlsSystem.playerEntity = _player;
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

- (void)draw
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



@end
