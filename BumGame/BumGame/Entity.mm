//
//  Entity.m
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Entity.h"
#import "Component.h"
#import "EntityManager.h"

@implementation Entity

#pragma mark - NSObject

- (id)initWithID:(uint32_t)entityID entityManager:(EntityManager *)entityManager
{
    if (self = [super init]) {
        _entityID = entityID;
        _entityManager = entityManager;
    }
    return self;
}

@end
