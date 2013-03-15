//
//  EntityFactory.m
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//
//

#import "EntityFactory.h"
#import "cocos2d.h"
#import "EntityManager.h"
#import "RenderComponent.h"
#import "HealthComponent.h"
#import "MovementComponent.h"
#import "ActionComponent.h"

@implementation EntityFactory {
    EntityManager * _entityManager;
    CCSpriteBatchNode * _batchNode;
}

- (id)initWithEntityManager:(EntityManager *)entityManager batchNode:(CCSpriteBatchNode *)batchNode
{
    if ((self = [super init])) {
        _entityManager = entityManager;
        _batchNode = batchNode;
    }
    return self;
}

- (Entity *)createHumanPlayer
{
    CCSprite * sprite = [[CCSprite alloc] initWithSpriteFrameName:@"bum_run.png"];
    [_batchNode addChild:sprite];
    
    Entity * entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite centerToSides:127.f centerToBottom:149.f] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurrentHP:200 maxHP:200] toEntity:entity];
    
    
    // Animation
    ActionComponent *actionComp = [[ActionComponent alloc] initWithActionState:ActionStateIdle];
 
    // idle
    CCArray *idleFrames = [CCArray arrayWithCapacity:1];
    
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bum_throw.png"];
    [idleFrames addObject:frame];
    
    CCAnimation *idleAnimation = [CCAnimation animationWithSpriteFrames:[idleFrames getNSArray] delay:1.0/12.0];
    actionComp.idleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idleAnimation]];
    
    
    // run
    CCArray *runFrames = [CCArray arrayWithCapacity:1];
    
    frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bum_run.png"];
    [runFrames addObject:frame];
    
    CCAnimation *runAnimation = [CCAnimation animationWithSpriteFrames:[runFrames getNSArray] delay:1.0/12.0];
    actionComp.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:runAnimation]];
    
    
    // attack
    CCArray *attackFrames = [CCArray arrayWithCapacity:1];
    
    frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bum_throw.png"];
    [attackFrames addObject:frame];
    
    CCAnimation *attackAnimation = [CCAnimation animationWithSpriteFrames:[attackFrames getNSArray] delay:1.0/12.0];
    actionComp.attackAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:attackAnimation]];
    
    
    // finally add the action component to the manager
    [_entityManager addComponent:actionComp toEntity:entity];
    
    
    // Movement
    [_entityManager addComponent:[[MovementComponent alloc] initWithMaxVelocity:100.f maxAcceleration:100.f] toEntity:entity];
    return entity;
}


- (Entity *)createAIPlayer
{
    CCSprite * sprite = [[CCSprite alloc] initWithSpriteFrameName:@"interim_badguy.png"];
    [_batchNode addChild:sprite];
    
    Entity * entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite centerToSides:80.f centerToBottom:151.f] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurrentHP:200 maxHP:200] toEntity:entity];
    return entity;
}

@end
