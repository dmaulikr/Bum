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
#import "PlayerComponent.h"
#import "ActionComponent.h"

@implementation MovementSystem

- (void)update:(float)dt
{
    NSArray *moveEntities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[MovementComponent class]];
    
    for (Entity *entity in moveEntities) {
        
        MovementComponent *move = [entity movement];
        RenderComponent *render = [entity render];
        
        if (!move || !render) continue;
        
        move.velocity = ccpMult(move.velocity, move.friction);
        move.rotationVelocity *= move.friction;
        
        // get the position from box2d to cocos2d and update the sprite
        render.node.position = ccpAdd(render.node.position, move.velocity);
        render.node.rotation += move.rotationVelocity;
    }
    
//    for (Entity *entity in moveEntities) {
//        RenderComponent *render = [entity render];
//        CCSprite *sprite = render.node;
//        b2Body *body = sprite.body;
//        if (body == nil) continue;
//        sprite.position = ccp( body->GetPosition().x * PTM_RATIO, body->GetPosition().y * PTM_RATIO);
//        sprite.rotation = -1 * CC_RADIANS_TO_DEGREES(body->GetAngle());
//    }
}

@end
