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

#define BUTTON_PADDING_IPHONE 15.f
#define BUTTON_PADDING_IPAD 25.f

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
    [self addChild:_dPad];
    
    _runButton = [[GameButton alloc] initWithFile:@"button-b.png"];
    [rightControlsGroup addChild:_runButton];
    
    _jumpButton = [[GameButton alloc] initWithFile:@"button-a.png"];
    [rightControlsGroup addChild:_jumpButton];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        _jumpButton.scale =
        _runButton.scale =
        _dPad.scale = 480.f/1024.f;
        
        _dPad.position = ccp(_dPad.boundingBox.size.width + BUTTON_PADDING_IPHONE, _jumpButton.boundingBox.size.height + BUTTON_PADDING_IPHONE);
        _jumpButton.position = ccp(_runButton.boundingBox.size.width + BUTTON_PADDING_IPHONE, 0);
        rightControlsGroup.position = ccp(winSize.height - (_jumpButton.position.x + _jumpButton.boundingBox.size.width * .5 + BUTTON_PADDING_IPHONE),
                                          _jumpButton.boundingBox.size.height + BUTTON_PADDING_IPHONE);
        
    }
    else {
        _dPad.position = ccp(128.f, 128.f);
        _jumpButton.position = ccp(_runButton.contentSize.width + BUTTON_PADDING_IPAD, 0);
        rightControlsGroup.position = ccp(winSize.height - (_jumpButton.position.x + _jumpButton.contentSize.width * .5 + BUTTON_PADDING_IPAD),
                                          128.f);
    }
}

@end
