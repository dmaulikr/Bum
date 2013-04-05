//
//  Entity+Helpers.h
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//
//

#import "Entity.h"

@class ActionComponent;
@class RenderComponent;
@class MovementComponent;
@class PlayerComponent;
@class WeaponComponent;
@class ProjectileComponent;
@interface Entity (Helpers)

- (ActionComponent *)action;
- (RenderComponent *)render;
- (MovementComponent *)movement;
- (PlayerComponent *)player;
- (WeaponComponent *)weapon;
- (ProjectileComponent *)projectile;

@end
