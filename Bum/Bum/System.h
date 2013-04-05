//
//  System.h
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "EntityManager.h"
#import "EntityFactory.h"
#import "LevelHelperLoader.h"

@interface System : NSObject

@property (strong) EntityManager * entityManager;
@property (strong) EntityFactory * entityFactory;
@property (strong) LevelHelperLoader * loader;

- (id)initWithEntityManager:(EntityManager *)entityManager
              entityFactory:(EntityFactory *)entityFactory
                     loader:(LevelHelperLoader*)loader;


- (void)update:(float)dt;

@end
