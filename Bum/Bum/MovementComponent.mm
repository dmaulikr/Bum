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

- (id)initWithMaxVelocity:(float)velocity maxAcceleration:(float)accel
{
    if (self = [super init]) {
        self.maxVelocity = velocity;
        self.maxAcceleration = accel;
        self.target = CGPointZero;
        self.velocity = CGPointZero;
        self.acceleration = CGPointMake(1.f, 1.f);
    }
    return self;
}

@end
