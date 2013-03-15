//
//  ActionComponent.m
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ActionComponent.h"


@implementation ActionComponent

- (id)initWithActionState:(ActionState)state
{
    if (self = [super init]) {
        _actionState = state;
    }
    return self;
}

@end
