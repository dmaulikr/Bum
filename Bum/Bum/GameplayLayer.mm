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

typedef enum {
    DepthLevelBackground = 0,
    DepthLevelCharacters
} DepthLevel;

@interface GameplayLayer () {
    CCSpriteBatchNode *_batchNode;
    
    EntityManager *_entityManager;
    EntityFactory *_entityFactory;
    
    HealthSystem *_healthSystem;
    
    Entity * _player;
    Entity * _enemy;
}

@end

@implementation GameplayLayer


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
//    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"characters.plist"];
//    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"backgrounds.plist"];
//    
//    CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"background.png"];
//    background.position = ccp(background.contentSize.width * .5, background.contentSize.height * .5);
//    [self addChild:background z:DepthLevelBackground];
//    
//    _batchNode = [CCSpriteBatchNode batchNodeWithFile:@"characters.png"];
//    [self addChild:_batchNode z:DepthLevelCharacters];
    
    [self scheduleUpdate];
}


- (void)addPlayers
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGFloat inset = winSize.width * .1;
    
    _entityManager = [[EntityManager alloc] init];
    _entityFactory = [[EntityFactory alloc] initWithEntityManager:_entityManager batchNode:_batchNode];
    
    _healthSystem = [[HealthSystem alloc] initWithEntityManager:_entityManager entityFactory:_entityFactory];
    
    _player = [_entityFactory createHumanPlayer];
    RenderComponent * humanRender = _player.render;
    if (humanRender) {
        humanRender.node.position = ccp(humanRender.node.contentSize.width/2 + inset, winSize.height/4);
    }
    
    _enemy = [_entityFactory createAIPlayer];
    RenderComponent *aiRenderer = _enemy.render;
    if (aiRenderer) {
        aiRenderer.node.position = ccp(winSize.width - aiRenderer.node.contentSize.width/2 - inset, winSize.height/4);
    }
}


- (void)update:(ccTime)dt
{
    [_healthSystem update:dt];
}

- (void)draw
{
    [_healthSystem draw];
}


@end
