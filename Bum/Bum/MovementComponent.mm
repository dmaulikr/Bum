//
//  MovementComponent.m
//  Bum
//
//  Created by Grant Davis on 3/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MovementComponent.h"


@implementation MovementComponent

- (id)initWithBody:(b2Body *)body target:(CGPoint)position maxVelocity:(float)velocity maxAcceleration:(float)accel
{
    if (self = [super init]) {
        self.body = body;
        self.target = position;
        self.maxVelocity = velocity;
        self.maxAcceleration = accel;
        self.velocity = CGPointZero;
        self.acceleration = CGPointZero;
    }
    return self;
}

@end
