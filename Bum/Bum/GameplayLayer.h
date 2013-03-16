//
//  GameplayLayer.h
//  Bum
//
//  Created by Grant Davis on 3/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HUDLayer.h"

@interface GameplayLayer : CCLayer {
    
}

@property (nonatomic,unsafe_unretained) HUDLayer *hud;

@end
