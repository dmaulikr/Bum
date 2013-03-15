//
//  GameplayScene.h
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameplayLayer;
@class HUDLayer;
@interface GameplayScene : CCScene {
    
}

@property (nonatomic, strong) GameplayLayer *gameLayer;
@property (nonatomic, strong) HUDLayer *hudLayer;

@end
