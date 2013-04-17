//
//  GameControls.h
//  BumGame
//
//  Created by Grant Davis on 4/16/13.
//
//

#import "CCLayer.h"
#import "GameButton.h"

@interface GameControls : CCLayer {
    GameButton *_leftArrow;
    GameButton *_rightArrow;
    GameButton *_jumpButton;
    GameButton *_actionButton;
}

@property (strong, nonatomic) GameButton *leftArrow;
@property (strong, nonatomic) GameButton *rightArrow;
@property (strong, nonatomic) GameButton *jumpButton;
@property (strong, nonatomic) GameButton *actionButton;

@end
