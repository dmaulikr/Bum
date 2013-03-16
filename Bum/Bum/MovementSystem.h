//
//  MovementSystem.h
//  Bum
//
//  Created by Grant Davis on 3/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "System.h"
#import "SimpleDPad.h"

@interface MovementSystem : System <SimpleDPadDelegate> {
    
}

@property (nonatomic, unsafe_unretained) CCTMXTiledMap *tileMap;

@end
