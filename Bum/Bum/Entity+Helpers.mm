//
//  Entity+Helpers.m
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//
//

#import "Entity+Helpers.h"
#import "RenderComponent.h"
#import "MovementComponent.h"
#import "PlayerComponent.h"
#import "EntityManager.h"
#import "ActionComponent.h"
#import "WeaponComponent.h"
#import "ProjectileComponent.h"

@implementation Entity (Helpers)

- (ActionComponent *)action
{
    return (ActionComponent *) [_entityManager getComponentOfClass:[ActionComponent class] forEntity:self];
}

- (RenderComponent *)render
{
    return (RenderComponent *) [_entityManager getComponentOfClass:[RenderComponent class] forEntity:self];
}

- (MovementComponent *)movement
{
    return (MovementComponent *) [_entityManager getComponentOfClass:[MovementComponent class] forEntity:self];
}

- (PlayerComponent *)player
{
    return (PlayerComponent *) [_entityManager getComponentOfClass:[PlayerComponent class] forEntity:self];
}

- (WeaponComponent *)weapon
{
    return (WeaponComponent *) [_entityManager getComponentOfClass:[WeaponComponent class] forEntity:self];
}

- (ProjectileComponent *)projectile
{
    return (ProjectileComponent *) [_entityManager getComponentOfClass:[ProjectileComponent class] forEntity:self];
}

@end
