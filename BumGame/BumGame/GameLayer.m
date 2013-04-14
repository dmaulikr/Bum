//
//  GameLayer.m
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@implementation GameLayer


- (void)didLoadFromCCB
{
    // initialize world
    [self addPlayer];
}

- (void)addPlayer
{
    _bum = (CCSprite *)[CCBReader nodeGraphFromFile:@"Bum.ccbi"];
    _bum.position = ccp(_bum.contentSize.width * .5, _bum.contentSize.height * .5);
    _bum.scale = .66f;
    [self addChild:_bum];
}

@end
