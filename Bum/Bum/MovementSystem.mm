//
//  MovementSystem.m
//  Bum
//
//  Created by Grant Davis on 3/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MovementSystem.h"
#import "MovementComponent.h"
#import "RenderComponent.h"

@implementation MovementSystem

- (void)update:(float)dt
{
    NSArray *moveEntities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[MovementComponent class]];
    
    for (Entity *entity in moveEntities) {
        
        MovementComponent *move = (MovementComponent*)[self.entityManager getComponentOfClass:[MovementComponent class] forEntity:entity];
        RenderComponent *render = (RenderComponent*)[self.entityManager getComponentOfClass:[RenderComponent class] forEntity:entity];
        
        if (!move || !render) return;
        
        CGPoint vector = ccpSub(move.target, render.node.position);
        float distance = ccpLength(vector);
        
        // stop moving after small distances
        if (distance < 0.1) {
            render.node.position = move.target;
            return;
        }
        
        
    }
}

@end
