//
//  Bum.m
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//
//

#import "Bum.h"
#import "Box2D.h"
#import "GB2ShapeCache.h"
#import "MovementComponent.h"
#import "PlayerComponent.h"
#import "RenderComponent.h"
#import "ActionComponent.h"
#import "HealthComponent.h"

@implementation Bum

- (void)didLoadFromCCB
{
    [super didLoadFromCCB];
    self.entity = [self createPlayerEntityWithNode:self];
}


- (Entity *)createPlayerEntityWithNode:(CCNode *)node
{
    Entity * entity = [self.manager createEntity];
    NSLog(@"bum size: %@", NSStringFromCGSize(node.contentSize));
    // create a body for the sprite
    CGPoint p = node.position;
    
    // bum
    [self.manager addComponent:[[RenderComponent alloc] initWithNode:node] toEntity:entity];
    
    // create the player with a default weapon
    PlayerComponent *player = [[PlayerComponent alloc] init];
    [self.manager addComponent:player toEntity:entity];
    
    // create a body for physics interactions
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    bodyDef.userData = (__bridge void *)node;
    b2Body *body = self.manager.world->CreateBody(&bodyDef);
    body->SetFixedRotation(YES);
    
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:@"bum"];
    [node setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"bum"]];
    
    // weapon
//    LHSprite *weaponSprite = [CCBReader nodeGraphFromFile:@"cat"];
//    WeaponComponent *catWeapon = [[WeaponComponent alloc] initWithSprite:weaponSprite
//                                                                   range:100.f
//                                                                  damage:10.f
//                                                            areaOfEffect:NO];
//    catWeapon.animationDuration = .25f;
//    catWeapon.fireRate = .25;
//    catWeapon.projectileName = @"cat";
//    weaponSprite.position = ccp(sprite.boundingBox.size.width * catWeapon.weaponPosition.x,
//                                sprite.boundingBox.size.height * catWeapon.weaponPosition.y);
//    [_entityManager addComponent:catWeapon toEntity:entity];
    
    // Animation Actions
    ActionComponent *actionComp = [[ActionComponent alloc] initWithMovementState:MovementStateIdle];
    actionComp.runAnimation = @"run";
    actionComp.walkAnimation = @"walk";
    actionComp.idleAnimation = @"idle";
    actionComp.attackAnimation = @"throw";
    actionComp.spriteSheet = @"sprites";
    [self.manager addComponent:actionComp toEntity:entity];
    
    // Movement
    MovementComponent *movement = [[MovementComponent alloc] init];
    [self.manager addComponent:movement toEntity:entity];
    
    // resources
    [self.manager addComponent:[[HealthComponent alloc] initWithCurrentHP:200 maxHP:200] toEntity:entity];
    
    return entity;
}


@end
