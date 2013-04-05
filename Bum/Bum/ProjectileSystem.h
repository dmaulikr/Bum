//
//  ProjectileSystem.h
//  Bum
//
//  Created by Grant Davis on 4/5/13.
//
//

#import "System.h"

@class WeaponComponent;
@class ActionSystem;
@interface ProjectileSystem : System {
@protected
    float _elapsedTime;
}

@property (nonatomic, unsafe_unretained) ActionSystem *actionSystem;

- (BOOL)throwProjectileWithWeapon:(WeaponComponent *)weapon direction:(CGPoint)direction;

@end
