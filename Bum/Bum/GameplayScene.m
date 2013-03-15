//
//  GameplayScene.m
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameplayScene.h"
#import "GameplayLayer.h"
#import "HUDLayer.h"

@implementation GameplayScene

- (id)init
{
    if (self = [super init]) {
        
        _gameLayer = [GameplayLayer node];
        [self addChild:_gameLayer z:0];
        
        _hudLayer = [HUDLayer node];
        [self addChild:_hudLayer z:1];
    }
    return self;
}

@end
