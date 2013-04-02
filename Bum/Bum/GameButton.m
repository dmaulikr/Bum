//
//  GameButton.m
//  Bum
//
//  Created by Grant Davis on 3/22/13.
//
//
#import "GameButton.h"

@interface GameButton () {
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
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
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
    
    if (CGRectContainsPoint([self boundingBox], loc)) {
        _isHeld = YES;
        if ([_delegate respondsToSelector:@selector(gameButtonTouchesBegan:)]) {
            [_delegate gameButtonTouchesBegan:self];
        }
        return YES;
    }
    return NO;
}
 


-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint loc = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    loc = [self.parent convertToNodeSpace:loc];
    
    if (!CGRectContainsPoint([self boundingBox], loc)) {
        _isHeld = NO;
        if ([_delegate respondsToSelector:@selector(gameButtonTouchesDidLeave:)]) {
            [_delegate gameButtonTouchesDidLeave:self];
        }
    }
    else {
        // this captures the condition of the user rolling off the button then back on
        _isHeld = YES;
        if ([_delegate respondsToSelector:@selector(gameButtonTouchesDidEnter:)]) {
            [_delegate gameButtonTouchesDidEnter:self];
        }
    }
}


-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    _isHeld = NO;
    
    if ([_delegate respondsToSelector:@selector(gameButtonTouchesEnded:)]) {
        [_delegate gameButtonTouchesEnded:self];
    }
}


@end
