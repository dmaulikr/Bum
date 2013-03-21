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
#import "PlayerComponent.h"
#import "LevelHelperLoader.h"

@implementation EntityFactory {
    EntityManager * _entityManager;
    LevelHelperLoader *_loader;
    CCLayer *_layer;
}

- (id)initWithEntityManager:(EntityManager *)entityManager
                      layer:(CCLayer *)layer
          levelHelperLoader:(LevelHelperLoader *)loader
{
    if ((self = [super init])) {
        _entityManager = entityManager;
        _layer = layer;
        _loader = loader;
    }
    return self;
}

- (Entity *)createHumanPlayer
{
    LHSprite *sprite = [_loader spriteWithUniqueName:@"bum-run-01"];
    
    Entity * entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite centerToSides:127.f centerToBottom:149.f] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurrentHP:200 maxHP:200] toEntity:entity];
    [_entityManager addComponent:[[PlayerComponent alloc] init] toEntity:entity];
    
    // Animation
    ActionComponent *actionComp = [[ActionComponent alloc] initWithActionState:ActionStateIdle];
    NSUInteger animationFrames = 1;
 
    // idle
    CCArray *idleFrames = [CCArray arrayWithCapacity:animationFrames];
    for (int i=1; i < animationFrames; i++) {
        NSString *spriteName = [NSString stringWithFormat:@"bum-throw-%02d", i];
        LHSprite *frame = [_loader createBatchSpriteWithName:spriteName fromSheet:@"Bum" fromSHFile:@"sprites"];
        [idleFrames addObject:frame];
    }
    CCAnimation *idleAnimation = [CCAnimation animationWithSpriteFrames:[idleFrames getNSArray] delay:1.0/12.0];
    actionComp.idleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idleAnimation]];
    
    
    // run
    CCArray *runFrames = [CCArray arrayWithCapacity:animationFrames];
    for (int i=1; i < animationFrames; i++) {
        NSString *spriteName = [NSString stringWithFormat:@"bum-run-%2d", i];
        LHSprite *frame = [_loader createBatchSpriteWithName:spriteName fromSheet:@"Bum" fromSHFile:@"sprites"];
        [runFrames addObject:frame];
    }
    CCAnimation *runAnimation = [CCAnimation animationWithSpriteFrames:[runFrames getNSArray] delay:1.0/12.0];
    actionComp.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:runAnimation]];
    
    
    // attack
    CCArray *attackFrames = [CCArray arrayWithCapacity:animationFrames];
    for (int i=1; i < animationFrames; i++) {
        NSString *spriteName = [NSString stringWithFormat:@"bum-kick-%2d", i];
        LHSprite *frame = [_loader createBatchSpriteWithName:spriteName fromSheet:@"Bum" fromSHFile:@"sprites"];
        [runFrames addObject:frame];
    }
    CCAnimation *attackAnimation = [CCAnimation animationWithSpriteFrames:[attackFrames getNSArray] delay:1.0/12.0];
    actionComp.attackAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:attackAnimation]];
    
    // finally add the action component to the manager
    [_entityManager addComponent:actionComp toEntity:entity];
    
    
    // Movement
    MovementComponent *movement = [[MovementComponent alloc] initWithMaxVelocity:50.f maxAcceleration:1.f];
    movement.acceleration = CGPointMake(.333f, 1.f);
    [_entityManager addComponent:movement toEntity:entity];
    return entity;
}


- (Entity *)createAIPlayer
{
//    CCSprite * sprite = [[CCSprite alloc] initWithSpriteFrameName:@"interim_badguy.png"];
//    [_batchNode addChild:sprite];
    
    Entity * entity = [_entityManager createEntity];
//    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite centerToSides:80.f centerToBottom:151.f] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurrentHP:200 maxHP:200] toEntity:entity];
    return entity;
}

@end
