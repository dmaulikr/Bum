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
#import "WeaponComponent.h"
#import "ProjectileComponent.h"
#import "GB2ShapeCache.h"
#import "Bum.h"

@implementation EntityFactory {
    EntityManager * _entityManager;
    b2World *_world;
}


- (id)initWithEntityManager:(EntityManager *)entityManager
                      layer:(CCLayer *)layer
                      world:(b2World *)world
{
    if ((self = [super init])) {
        _entityManager = entityManager;
        _layer = layer;
        _world = world;
        
        factory = self;
    }
    return self;
}

- (Entity *)entityForObjectNode:(CCNode *)node
{
    Entity *entity;
    if ([node isKindOfClass:[Bum class]]) {
        entity = [self createPlayerEntityWithNode:node];
    }
    return entity;
}


//- (Entity *)createBulletWithName:(NSString *)name
//{
//    Entity *entity = [_entityManager createEntity];
//    
//    // projectile
//    [_entityManager addComponent:[[ProjectileComponent alloc] initWithFireSpeed:CGPointMake(1.5f, .5f)
//                                                                    maxDistance:2000.f
//                                                                    maxDuration:3.f]
//                        toEntity:entity];
//    
//    // renderer
//    LHSprite *sprite = [_loader createSpriteWithName:name fromSheet:@"Bum" fromSHFile:@"sprites"];
//    RenderComponent *renderer = [[RenderComponent alloc] initWithNode:sprite];
//    [_entityManager addComponent:renderer toEntity:entity];
//    
//    // movement
//    MovementComponent *movement = [[MovementComponent alloc] init];
//    [_entityManager addComponent:movement toEntity:entity];
//    
//    return entity;
//}
//
//
//- (Entity *)createAIPlayer
//{
////    CCSprite * sprite = [[CCSprite alloc] initWithSpriteFrameName:@"interim_badguy.png"];
////    [_batchNode addChild:sprite];
//    
//    Entity * entity = [_entityManager createEntity];
////    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite centerToSides:80.f centerToBottom:151.f] toEntity:entity];
//    [_entityManager addComponent:[[HealthComponent alloc] initWithCurrentHP:200 maxHP:200] toEntity:entity];
//    return entity;
//}

static EntityFactory *factory;

+ (EntityFactory *)sharedFactory
{
    return factory;
}

@end
