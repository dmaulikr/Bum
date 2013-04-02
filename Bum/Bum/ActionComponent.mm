//
//  ActionComponent.m
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ActionComponent.h"


@implementation ActionComponent

- (id)initWithMovementState:(MovementState)state
{
    if (self = [super init]) {
        _movementState = state;
        _actionState = ActionStateNone;
    }
    return self;
}

@end
