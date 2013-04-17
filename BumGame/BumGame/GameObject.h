//
//  GameObject.h
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//
//

#import <Foundation/Foundation.h>
#import "Component.h"
#import "Entity.h"
#import "EntityManager.h"
#import "GB2ShapeCache.h"


// This is the base class for all dynamic objects in the game. Its responsible
// for creating the physics body and stub methods for responding to collisions.
@interface GameObject : CCSprite {
}

@property (unsafe_unretained, nonatomic) b2Body *body;
@property (unsafe_unretained, nonatomic) Entity *entity;
@property (unsafe_unretained, nonatomic) EntityManager *manager;

- (void)didLoadFromCCB;

// collision detection. called by the CollisionSystem.
- (void)didBeginContactWithObject:(CCNode *)object;
- (void)didEndContactWithObject:(CCNode *)object;

@end