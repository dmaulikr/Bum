//
//  ProjectileComponent.m
//  Bum
//
//  Created by Grant Davis on 4/5/13.
//
//

#import "ProjectileComponent.h"

@implementation ProjectileComponent

- (id)initWithFireSpeed:(CGPoint)fireSpeed maxDistance:(float)maxDistance maxDuration:(float)maxDuration
{
    if (self = [super init]) {
        _fireSpeed = fireSpeed;
        _maxDistance = maxDistance;
        _maxDuration = maxDuration;
        _isActive = YES;
    }
    return self;
}

@end
