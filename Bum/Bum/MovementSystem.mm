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

- (id)initWithEntityManager:(EntityManager *)entityManager
              entityFactory:(EntityFactory *)entityFactory
                      world:(b2World *)world
{
    if (self = [super initWithEntityManager:entityManager entityFactory:entityFactory]) {
        _world = world;
    }
    return self;
}

- (void)update:(float)dt
{
    NSArray *moveEntities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[MovementComponent class]];
    
    for (Entity *entity in moveEntities) {
        
        MovementComponent *move = [entity movement];
        RenderComponent *render = [entity render];
        
        if (!move || !render) continue;
        
        b2Body *body = render.node.body;
        
        // make sure a body is defined for an object with movement
        assert(body != nil);
        
        // get the position from box2d to cocos2d and update the sprite
        render.node.position = [LevelHelperLoader metersToPoints:body->GetPosition()];
        render.node.rotation = -1 * CC_RADIANS_TO_DEGREES(body->GetAngle());
    }
}

@end
