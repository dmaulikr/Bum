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
    CCSprite *_stick;
    CGPoint _center;
}

@end


@implementation SimpleDPad

- (id)init
{
    if (self = [super initWithFile:@"movement-area-circle.png"]) {
        _radius = self.contentSize.width * .5;
        _center = CGPointMake(_radius, _radius);
        _direction = CGPointZero;
        _isHeld = NO;
        
        // create the joystick that moves with touches
        _stick = [CCSprite spriteWithFile:@"movement-stick.png"];
        _stick.position = ccp(_radius, _radius);
        [self addChild:_stick];
        
        [self scheduleUpdate];
    }
    return self;
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
        [self updateStickPositionForTouchLocation:loc];
        
        if ([_delegate respondsToSelector:@selector(simpleDPadTouchesBegan:)]) {
            [_delegate simpleDPadTouchesBegan:self];
        }
        
        return YES;
    }
    return NO;
}


-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint loc = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    [self updateDirectionForTouchLocation:loc];
    [self updateStickPositionForTouchLocation:loc];
}


-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    _direction = CGPointZero;
    _isHeld = NO;
    _stick.position = ccp(self.contentSize.width * .5, self.contentSize.height * .5);
    
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


- (void)updateStickPositionForTouchLocation:(CGPoint)location
{
    CGPoint localLoc = [self convertToNodeSpace:location];
    
    CGPoint center = ccp(self.contentSize.width * .5, self.contentSize.height * .5);
    float radians = ccpToAngle(ccpSub(localLoc, center));
    CGFloat distance = ccpDistance(localLoc, center);
    CGFloat maxDistance = _radius;
    
    CGPoint position;
    if (fabsf(distance) > maxDistance) {
        // limit the distance of the touch point
        position = ccpAdd(cartesianCoordinateFromPolar(_radius, radians), center);
    }
    else position = localLoc;
    
    _stick.position = position;
}


CGPoint cartesianCoordinateFromPolar(float radius, float radians)
{
    float x,y;
    x = radius * cosf(radians);
    y = radius * sinf(radians);
    return CGPointMake(x, y);
}


@end
