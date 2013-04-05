//
//  System.m
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//
//

#import "System.h"

@implementation System


- (id)initWithEntityManager:(EntityManager *)entityManager
              entityFactory:(EntityFactory *)entityFactory
                     loader:(LevelHelperLoader*)loader
{
    if ((self = [super init])) {
        self.entityManager = entityManager;
        self.entityFactory = entityFactory;
        self.loader = loader;
    }
    return self;
}

- (void)update:(float)dt {}

@end