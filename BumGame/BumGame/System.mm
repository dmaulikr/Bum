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
{
    if ((self = [super init])) {
        self.entityManager = entityManager;
    }
    return self;
}

- (void)update:(float)dt {}

@end