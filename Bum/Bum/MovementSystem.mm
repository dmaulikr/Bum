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
#import "Box2D.h"

@implementation MovementSystem

- (void)update:(float)dt
{
//    NSArray *moveEntities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[MovementComponent class]];
//    
//    for (Entity *entity in moveEntities) {
//        
//        MovementComponent *move = [entity movement];
//        RenderComponent *render = [entity render];
//        
//        if (!move || !render) continue;
//        
//        b2Body *body = render.node.body;
//        
//        // make sure a body is defined for an object with movement
//        assert(body != nil);
//        
//        // get the position from box2d to cocos2d and update the sprite
//        render.node.position = [LevelHelperLoader metersToPoints:body->GetPosition()];
//        render.node.rotation = -1 * CC_RADIANS_TO_DEGREES(body->GetAngle());
//    }
    
    NSArray *allSprites = [self.loader allSprites];
    for (LHSprite *sprite in allSprites) {
        b2Body *body = sprite.body;
        if (body == nil) continue;
        sprite.position = [LevelHelperLoader metersToPoints:body->GetPosition()];
        sprite.rotation = -1 * CC_RADIANS_TO_DEGREES(body->GetAngle());
    }
}

@end
