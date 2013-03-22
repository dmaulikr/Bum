//
//  HUDLayer.m
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"
#import "SimpleDPad.h"
#import "GameButton.h"

@interface HUDLayer () {
}

@end


@implementation HUDLayer

- (id)init
{
    if (self = [super init]) {
        self.isTouchEnabled = YES;
        [self setupControls];
    }
    return self;
}

- (void)setupControls
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    NSLog(@"winSize: %@", NSStringFromCGSize(winSize));
    
    _dPad = [[SimpleDPad alloc] initWithFile:@"pd_dpad.png" radius:64.f];
    _dPad.position = ccp(128.f, 128.f);
    [self addChild:_dPad];
    
    _jumpButton = [[GameButton alloc] initWithFile:@"pd_dpad.png"];
    _jumpButton.position = ccp( winSize.height - _jumpButton.contentSize.width, _jumpButton.contentSize.height);
    [self addChild:_jumpButton];
}

@end
