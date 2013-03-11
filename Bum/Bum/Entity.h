//
//  Entity.h
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Component;
@class EntityManager;
@class RenderComponent;
@interface Entity : NSObject {
    EntityManager *_entityManager;
}

@property (readonly, nonatomic) uint32_t entityID;

- (id)initWithID:(uint32_t)entityID entityManager:(EntityManager *)entityManager;

- (RenderComponent *)render;

@end
