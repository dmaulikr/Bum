//
//  RenderComponent.m
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "RenderComponent.h"

@implementation RenderComponent

- (id)initWithNode:(LHSprite *)node
{
    if (self = [super init]) {
        _node = node;
    }
    return self;
}

// this class has no implementation for the update method.
// instead, it is up to the rendering sytem to implement drawing.

@end
