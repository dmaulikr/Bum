//
//  ProjectileComponent.h
//  Bum
//
//  Created by Grant Davis on 4/5/13.
//
//

#import "Component.h"

@interface ProjectileComponent : Component

- (id)initWithFireSpeed:(CGPoint)fireSpeed maxDistance:(float)maxDistance maxDuration:(float)maxDuration;

@property (nonatomic) CGPoint fireSpeed;
@property (nonatomic) CGPoint position; // tracks the last location of the projectile
@property (nonatomic) float travelledDistance; // tracks how far this projectile can travel before it is removed
@property (nonatomic) float maxDistance;
@property (nonatomic) float elapsedTime;
@property (nonatomic) float maxDuration;
@property (nonatomic) BOOL isActive;

@end
