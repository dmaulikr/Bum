//
//  GameLayer.h
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameLayer : CCLayer {
    CCLayer *_charactersLayer;
    CCLayer *_uiLayer;
    CCSprite *_bum;
}

- (void)didLoadFromCCB;

@end
