 //
//  MovementComponent.h
//  Bum
//
//  Created by Grant Davis on 3/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Component.h"
#import "Box2D.h"

@interface MovementComponent : Component {
    
}

@property (nonatomic) b2Body *body;

@property (nonatomic) CGPoint target;

@property (nonatomic) CGPoint velocity;
@property (nonatomic) CGPoint acceleration;

@property (nonatomic) float maxVelocity;
@property (nonatomic) float maxAcceleration;

- (id)initWithBody:(b2Body *)body target:(CGPoint)position maxVelocity:(float)velocity maxAcceleration:(float)accel;

@end
