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
    
    CCLayer *rightControlsGroup = [CCLayer node];
    rightControlsGroup.isTouchEnabled = YES;
    [self addChild:rightControlsGroup];
    
    _dPad = [[SimpleDPad alloc] init];
    _dPad.position = ccp(128.f, 128.f);
    [self addChild:_dPad];
    
    _runButton = [[GameButton alloc] initWithFile:@"button-b.png"];
    [rightControlsGroup addChild:_runButton];
    
    _jumpButton = [[GameButton alloc] initWithFile:@"button-a.png"];
    _jumpButton.position = ccp(_runButton.contentSize.width * 1.5, 0);
    [rightControlsGroup addChild:_jumpButton];

    rightControlsGroup.position = ccp(winSize.height - (_jumpButton.position.x + _jumpButton.contentSize.width),
                                      _jumpButton.contentSize.height);
}

@end
