//
//  GameLayer.m
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "CCBReader.h"

@implementation GameLayer


- (void)didLoadFromCCB
{
    // initialize world
    
    // create layers
//    _charactersLayer = [CCLayer node];
//    _uiLayer = [CCLayer node];
//    [self addChild:_charactersLayer];
//    [self addChild:_uiLayer];
//    
////    [self createUI];
//    [self addPlayer];
}


- (void)createUI
{
    CCLayer *dpadLayer = (CCLayer *)[CCBReader nodeGraphFromFile:@"DPadUI.ccbi" owner:nil parentSize:self.contentSize];
    [self addChild:dpadLayer];
}


- (void)addPlayer
{
    _bum = (CCSprite *)[CCBReader nodeGraphFromFile:@"Bum.ccbi"];
    _bum.position = ccp(_bum.contentSize.width * .5, _bum.contentSize.height * .5);
    _bum.scale = .66f;
    [_charactersLayer addChild:_bum];
}

@end
