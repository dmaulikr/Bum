//
//  HUDLayer.h
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class SimpleDPad;
@class GameButton;
@interface HUDLayer : CCLayer {
    
}
@property (nonatomic, readonly) SimpleDPad *dPad;
@property (nonatomic, readonly) GameButton *jumpButton;
@property (nonatomic, readonly) GameButton *runButton;

@end
