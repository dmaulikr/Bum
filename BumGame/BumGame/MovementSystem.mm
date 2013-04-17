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

- (id)initWithEntityManager:(EntityManager *)entityManager
                      world:(b2World *)world
{
    if (self = [super initWithEntityManager:entityManager]) {
        _world = world;
    }
    return self;
}

- (void)update:(float)dt
{
    // here we find all objects that have movement components and adjust their position
//    NSArray *moveComps = [self.entityManager getAllEntitiesPosessingComponentOfClass:[MovementComponent class]];
//    for (Entity *entity in moveComps) {
//        
//        b2Body *body = entity.render.node.body;
//        b2Vec2 vel = body->GetLinearVelocity();
//        
//        float targetXVelocity = entity.movement.speed.x;
//        float targetYVelocity = entity.movement.speed.y;
//        
//        float deltaX = (targetXVelocity - vel.x) * entity.movement.acceleration.x;
//        float deltaY = (targetYVelocity - vel.y) * entity.movement.acceleration.y;
//
//        float impulseX = body->GetMass() * deltaX;
//        float impulseY = body->GetMass() * deltaY;
//        body->ApplyLinearImpulse( b2Vec2(impulseX,impulseY), body->GetWorldCenter() );
//    }
    
    
    
    // update physics sprites in the simulation
    for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {
        if (b->GetUserData() != NULL) {
            CCSprite *ballData = (__bridge CCSprite *)b->GetUserData();
            ballData.position = ccp(b->GetPosition().x * PTM_RATIO,
                                    b->GetPosition().y * PTM_RATIO);
            ballData.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
        }
    }
}

@end
