//
//  PlayerComponent.m
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PlayerComponent.h"


@implementation PlayerComponent

- (float)walkSpeed
{
    return PLAYER_WALK_SPEED;
}

- (float)runSpeed
{
    return PLAYER_RUN_SPEED;
}

- (float)jumpSpeed
{
    return PLAYER_JUMP_SPEED;
}

@end
