//
//  EntityManager.h
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "Component.h"

@interface EntityManager : NSObject

- (uint32_t) generateNewEid;
- (Entity *)createEntity;

- (void)addComponent:(Component *)component toEntity:(Entity *)entity;
- (void)removeEntity:(Entity *)entity;

- (Component *)getComponentOfClass:(Class)class forEntity:(Entity *)entity;
- (NSArray *)getAllEntitiesPosessingComponentOfClass:(Class)class;

@end
