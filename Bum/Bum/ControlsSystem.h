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
#import "HUDLayer.h"

@class ProjectileSystem;
@class ActionSystem;
@interface ControlsSystem : System <SimpleDPadDelegate, GameButtonDelegate>

@property (nonatomic, unsafe_unretained) Entity *playerEntity;
@property (nonatomic, unsafe_unretained) HUDLayer *hud;
@property (nonatomic, unsafe_unretained) ProjectileSystem *projectileSystem;

@end
