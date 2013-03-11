//
//  Component.m
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Component.h"
#import "Entity.h"

@implementation Component

- (id)initWithNode:(CCNode *)node
{
    if (self = [super init]) {
        _isEnabled = YES;
        _type = -1;
    }
    return self;
}


- (void)didAddToEntity:(Entity *)entity
{
    
}


- (void)didRemoveFromEntity:(Entity *)entity
{
    
}

- (void)update:(ccTime)time
{
    
}


+ (id)componentWithNode:(CCNode *)node
{
    return [[Component alloc] initWithNode:node];
}

@end
