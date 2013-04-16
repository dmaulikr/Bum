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
{
    if ((self = [super init])) {
        self.entityManager = entityManager;
        self.entityFactory = entityFactory;
    }
    return self;
}

- (void)update:(float)dt {}

@end