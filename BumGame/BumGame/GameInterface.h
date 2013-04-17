//
//  GameInterface.h
//  BumGame
//
//  Created by Grant Davis on 4/16/13.
//
//

#import "CCNode.h"
#import "GameControls.h"

@interface GameInterface : CCLayer {
    GameControls *_controls;
}

@property (strong, nonatomic) GameControls *controls;

@end
