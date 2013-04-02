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
    LHSprite *sprite = [_loader spriteWithUniqueName:@"idle"];
    
    Entity * entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite centerToSides:127.f centerToBottom:149.f] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurrentHP:200 maxHP:200] toEntity:entity];
    [_entityManager addComponent:[[PlayerComponent alloc] init] toEntity:entity];
    
    // Animation
    ActionComponent *actionComp = [[ActionComponent alloc] initWithMovementState:MovementStateIdle];
    actionComp.runAnimation = @"run";
    actionComp.walkAnimation = @"walk";
    actionComp.idleAnimation = @"idle";
    actionComp.spriteSheet = @"sprites";
    
    // finally add the action component to the manager
    [_entityManager addComponent:actionComp toEntity:entity];
    
    
    // Movement
    MovementComponent *movement = [[MovementComponent alloc] initWithMaxVelocity:100.f];
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
