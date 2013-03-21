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

@interface MovementSystem : System {
    
}

@property (nonatomic, unsafe_unretained) CCTMXTiledMap *tileMap;

- (id)initWithEntityManager:(EntityManager *)entityManager
              entityFactory:(EntityFactory *)entityFactory
                    tileMap:(CCTMXTiledMap *)tileMap;

- (void)walkWithDirection:(CGPoint)direction;

@end
