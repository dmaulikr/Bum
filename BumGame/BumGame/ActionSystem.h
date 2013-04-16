//
//  ActionSystem.h
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//
//

#import "System.h"

@interface ActionSystem : System {
@protected
    ActionState _currentAction;
    float _actionTimeElapsed;
    float _actionDuration;
}

- (void)playAction:(ActionState)state forDuration:(float)duration entity:(Entity *)entity;

@end
