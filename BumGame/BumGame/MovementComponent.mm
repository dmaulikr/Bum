//
//  MovementComponent.m
//  Bum
//
//  Created by Grant Davis on 3/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MovementComponent.h"
#import "Box2D.h"

@implementation MovementComponent

- (id)initWithDirection:(CGPoint)direction target:(CGPoint)target speed:(CGPoint)speed acceleration:(CGPoint)accel
{
    if (self = [super init]) {
        _direction = direction;
        _target = target;
        _speed = speed;
        _acceleration = accel;
    }
    return self;
}

@end
