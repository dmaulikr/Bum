//
//  HUDLayer.m
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"
#import "SimpleDPad.h"


@interface HUDLayer () {
    SimpleDPad *_dPad;
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
    _dPad = [[SimpleDPad alloc] initWithFile:@"pd_dpad.png" radius:64.f];
    _dPad.position = ccp(128.f, 128.f);
    [self addChild:_dPad];
}

@end
