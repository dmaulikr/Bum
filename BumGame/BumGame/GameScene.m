//
//  GameScene.m
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//
//

#import "GameScene.h"
#import "CCBReader.h"

@interface GameScene () {
    CCNode *_level;
    CCLayer *_levelLayer;
}

@end

static GameScene* sharedScene;

@implementation GameScene

+ (GameScene*) sharedScene
{
    return sharedScene;
}

- (void) didLoadFromCCB
{
    sharedScene = self;
    
    // Load the level
    _level = [CCBReader nodeGraphFromFile:@"Level0.ccbi"];
    
    // And add it to the game scene
    [_levelLayer addChild:_level];
}


@end
