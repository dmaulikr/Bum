//
//  GameButton.m
//  Bum
//
//  Created by Grant Davis on 3/22/13.
//
//
#import "GameButton.h"

@interface GameButton () {
    BOOL _isLastTouchWithinBounds;
}

@end

@implementation GameButton

- (id)initWithFile:(NSString *)file delegate:(NSObject <GameButtonDelegate> *)delegate
{
    if (self = [super initWithFile:file]) {
        _delegate = delegate;
        [self scheduleUpdate];
    }
    return self;
}

#pragma mark - CCNode

- (void)onEnterTransitionDidFinish
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:NO];
}

- (void)onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (void)update:(ccTime)dt
{
    if (_isHeld && [_delegate respondsToSelector:@selector(gameButtonIsBeingHeld:)]) {
        [_delegate gameButtonIsBeingHeld:self];
    }
}

#pragma mark - CCTargetedTouchDelegate

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint loc = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    loc = [self.parent convertToNodeSpace:loc];
    _isLastTouchWithinBounds = CGRectContainsPoint([self boundingBox], loc);
    
    if (_isLastTouchWithinBounds) {
        _isHeld = YES;
        if ([_delegate respondsToSelector:@selector(gameButtonTouchesBegan:)]) {
            [_delegate gameButtonTouchesBegan:self];
        }
    }
    return YES;
}
 


-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint loc = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    loc = [self.parent convertToNodeSpace:loc];
    
    BOOL isTouchWithinBounds = CGRectContainsPoint([self boundingBox], loc);
    
    if (!_isHeld && isTouchWithinBounds) {
        if ([_delegate respondsToSelector:@selector(gameButtonTouchesBegan:)]) {
            [_delegate gameButtonTouchesBegan:self];
        }
    }
    else if (isTouchWithinBounds && !_isLastTouchWithinBounds) {
        if ([_delegate respondsToSelector:@selector(gameButtonTouchesDidEnter:)]) {
            [_delegate gameButtonTouchesDidEnter:self];
        }
    }
    else if (!isTouchWithinBounds && _isLastTouchWithinBounds) {
        if ([_delegate respondsToSelector:@selector(gameButtonTouchesDidLeave:)]) {
            [_delegate gameButtonTouchesDidLeave:self];
        }
    }
    
    _isHeld = isTouchWithinBounds;
    _isLastTouchWithinBounds = CGRectContainsPoint([self boundingBox], loc);
}


-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    _isHeld = NO;
    _isLastTouchWithinBounds = NO;
    
    if ([_delegate respondsToSelector:@selector(gameButtonTouchesEnded:)]) {
        [_delegate gameButtonTouchesEnded:self];
    }
}


@end
