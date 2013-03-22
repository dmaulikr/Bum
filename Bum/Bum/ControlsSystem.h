//
//  ControlsSystem.h
//  Bum
//
//  Created by Grant Davis on 3/22/13.
//
//

#import "System.h"
#import "SimpleDPad.h"
#import "GameButton.h"

@interface ControlsSystem : System <SimpleDPadDelegate, GameButtonDelegate>

@property (nonatomic, unsafe_unretained) Entity *playerEntity;

@end
