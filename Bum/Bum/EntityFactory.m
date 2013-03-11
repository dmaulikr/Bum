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
    CCSprite * sprite = [[CCSprite alloc] initWithSpriteFrameName:@""];
    [_batchNode addChild:sprite];
    
    Entity * entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurrentHP:200 maxHP:200] toEntity:entity];
    return entity;
}


- (Entity *)createAIPlayer
{
    CCSprite * sprite = [[CCSprite alloc] initWithSpriteFrameName:@"Enemy Bug.png"];
    [_batchNode addChild:sprite];
    
    Entity * entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurrentHP:200 maxHP:200] toEntity:entity];
    return entity;
}


- (Entity *)createQuirkMonster
{
    CCSprite * sprite = [[CCSprite alloc] initWithSpriteFrameName:@"quirk1.png"];
    [_batchNode addChild:sprite];
    
    Entity * entity = [_entityManager createEntity];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurrentHP:5 maxHP:5] toEntity:entity];
    return entity;
}

@end
