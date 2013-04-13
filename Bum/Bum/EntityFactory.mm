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
#import "WeaponComponent.h"
#import "ProjectileComponent.h"

@implementation EntityFactory {
    EntityManager * _entityManager;
    LevelHelperLoader *_loader;
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
    Entity * entity = [_entityManager createEntity];
    
    // bum
    LHSprite *sprite = [_loader spriteWithUniqueName:@"bum"];
    [_entityManager addComponent:[[RenderComponent alloc] initWithNode:sprite] toEntity:entity];
    
    
    // create the player with a default weapon
    PlayerComponent *player = [[PlayerComponent alloc] init];
    [_entityManager addComponent:player toEntity:entity];
    
    // weapon
    LHSprite *weaponSprite = [_loader createBatchSpriteWithUniqueName:@"cat"];
    WeaponComponent *catWeapon = [[WeaponComponent alloc] initWithSprite:weaponSprite
                                                                   range:100.f
                                                                  damage:10.f
                                                            areaOfEffect:NO];
    catWeapon.animationDuration = .25f;
    catWeapon.fireRate = .25;
    catWeapon.projectileName = @"cat";
    weaponSprite.position = ccp(sprite.boundingBox.size.width * catWeapon.weaponPosition.x,
                                sprite.boundingBox.size.height * catWeapon.weaponPosition.y);
    [_entityManager addComponent:catWeapon toEntity:entity];
    
    
    // Animation Actions
    ActionComponent *actionComp = [[ActionComponent alloc] initWithMovementState:MovementStateIdle];
    actionComp.runAnimation = @"run";
    actionComp.walkAnimation = @"walk";
    actionComp.idleAnimation = @"idle";
    actionComp.attackAnimation = @"throw";
    actionComp.spriteSheet = @"sprites";
    [_entityManager addComponent:actionComp toEntity:entity];
    
    // Movement
    MovementComponent *movement = [[MovementComponent alloc] init];
    [_entityManager addComponent:movement toEntity:entity];
    
    // resources
    [_entityManager addComponent:[[HealthComponent alloc] initWithCurrentHP:200 maxHP:200] toEntity:entity];
    
    return entity;
}


- (Entity *)createBulletWithName:(NSString *)name
{
    Entity *entity = [_entityManager createEntity];
    
    // projectile
    [_entityManager addComponent:[[ProjectileComponent alloc] initWithFireSpeed:CGPointMake(1.5f, .5f)
                                                                    maxDistance:2000.f
                                                                    maxDuration:3.f]
                        toEntity:entity];
    
    // renderer
    LHSprite *sprite = [_loader createSpriteWithName:name fromSheet:@"Bum" fromSHFile:@"sprites"];
    RenderComponent *renderer = [[RenderComponent alloc] initWithNode:sprite];
    [_entityManager addComponent:renderer toEntity:entity];
    
    // movement
    MovementComponent *movement = [[MovementComponent alloc] init];
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
