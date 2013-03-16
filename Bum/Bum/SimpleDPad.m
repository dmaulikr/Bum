//
//  SimpleDPad.m
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SimpleDPad.h"

#define DISTANCE_THRESHOLD 10.f


@interface SimpleDPad () {
    CGPoint _center;
}

@end


@implementation SimpleDPad

- (id)initWithFile:(NSString *)filename radius:(float)radius
{
    if (self = [super initWithFile:filename]) {
        _radius = radius;
        _center = CGPointMake(_radius, _radius);
        _direction = CGPointZero;
        _isHeld = NO;
        [self scheduleUpdate];
    }
    return self;
}

+ (id)dPadWithFile:(NSString *)filename radius:(float)radius
{
    return [[SimpleDPad alloc] initWithFile:filename radius:radius];
}


#pragma mark - CCNode

- (void)onEnterTransitionDidFinish
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
}

- (void)onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (void)update:(ccTime)dt
{
    if (_isHeld && [_delegate respondsToSelector:@selector(simpleDPad:isHoldingDirection:)]) {
        [_delegate simpleDPad:self isHoldingDirection:_direction];
    }
}


#pragma mark - CCTargetedTouchDelegate

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint loc = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    float distanceSQ = ccpDistanceSQ(loc, position_);
    if (distanceSQ <= _radius * _radius) {
        
        _isHeld = YES;
        [self updateDirectionForTouchLocation:loc];
        
        if ([_delegate respondsToSelector:@selector(simpleDPadTouchesBegan:)]) {
            [_delegate simpleDPadTouchesBegan:self];
        }
        
        return YES;
    }
    return NO;
}


-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    [self updateDirectionForTouchLocation:location];
}


-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    _direction = CGPointZero;
    _isHeld = NO;
    
    if ([_delegate respondsToSelector:@selector(simpleDPadTouchesEnded:)]) {
        [_delegate simpleDPadTouchesEnded:self];
    }
}


-(void)updateDirectionForTouchLocation:(CGPoint)location {
    float radians = ccpToAngle(ccpSub(location, position_));
    float degrees = -1 * CC_RADIANS_TO_DEGREES(radians);
    CGPoint newDirection;
    
    if (degrees <= 22.5 && degrees >= -22.5) {
        //right
        newDirection = ccp(1.0, 0.0);
    } else if (degrees > 22.5 && degrees < 67.5) {
        //bottomright
        newDirection = ccp(1.0, -1.0);
    } else if (degrees >= 67.5 && degrees <= 112.5) {
        //bottom
        newDirection = ccp(0.0, -1.0);
    } else if (degrees > 112.5 && degrees < 157.5) {
        //bottomleft
        newDirection = ccp(-1.0, -1.0);
    } else if (degrees >= 157.5 || degrees <= -157.5) {
        //left
        newDirection = ccp(-1.0, 0.0);
    } else if (degrees < -22.5 && degrees > -67.5) {
        //topright
        newDirection = ccp(1.0, 1.0);
    } else if (degrees <= -67.5 && degrees >= -112.5) {
        //top
        newDirection = ccp(0.0, 1.0);
    } else if (degrees < -112.5 && degrees > -157.5) {
        //topleft
        newDirection = ccp(-1.0, 1.0);
    }
    
    if (!CGPointEqualToPoint(newDirection, _direction)) {
        
        _direction = newDirection;
        NSLog(@"direction changed: %@", NSStringFromCGPoint(_direction));
        if ([_delegate respondsToSelector:@selector(simpleDPad:didChangeDirectionTo:)]) {
            [_delegate simpleDPad:self didChangeDirectionTo:_direction];
        }
    }
}


@end
