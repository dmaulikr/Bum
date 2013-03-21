//
//  MovementSystem.h
//  Bum
//
//  Created by Grant Davis on 3/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "System.h"
#import "Box2D.h"

@interface MovementSystem : System {
    
}

@property (nonatomic, unsafe_unretained) b2World *world;
@property (nonatomic, unsafe_unretained) LevelHelperLoader *loader;

- (id)initWithEntityManager:(EntityManager *)entityManager
              entityFactory:(EntityFactory *)entityFactory
                      world:(b2World *)world;

- (void)walkWithDirection:(CGPoint)direction;

@end
