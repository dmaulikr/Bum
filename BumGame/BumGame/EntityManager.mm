//
//  EntityManager.m
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//
//

#import "EntityManager.h"
#import "Entity.h"
#import "Component.h"

@implementation EntityManager {
    NSMutableArray * _entities;
    NSMutableDictionary * _componentsByClass;
    uint32_t _lowestUnassignedEid;
}


static EntityManager *manager;
+ (EntityManager *)sharedManager
{
    return manager;
}

- (id)initWithWorld:(b2World *)world
{
    if (self = [self init]) {
        _world = world;
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        _entities = [NSMutableArray array];
        _componentsByClass = [NSMutableDictionary dictionary];
        _lowestUnassignedEid = 1;
        
        manager = self;
    }
    return self;
}


- (uint32_t) generateNewEid
{
    if (_lowestUnassignedEid < UINT32_MAX) {
        return _lowestUnassignedEid++;
    } else {
        for (uint32_t i = 1; i < UINT32_MAX; ++i) {
            if (![_entities containsObject:@(i)]) {
                return i;
            }
        }
        NSLog(@"ERROR: No available EIDs!");
        return 0;
    }
}


- (Entity *)createEntity
{
    uint32_t eid = [self generateNewEid];
    [_entities addObject:@(eid)];
    return [[Entity alloc] initWithID:eid entityManager:self];
}


- (void)addComponent:(Component *)component toEntity:(Entity *)entity
{
    NSMutableDictionary * components = _componentsByClass[NSStringFromClass([component class])];
    if (!components) {
        components = [NSMutableDictionary dictionary];
        _componentsByClass[NSStringFromClass([component class])] = components;
    }
    components[@(entity.entityID)] = component;
}


- (void)removeComponent:(Component *)component fromEntity:(Entity *)entity
{
    NSMutableDictionary *components = _componentsByClass[NSStringFromClass([component class])];
    if (!components) {
        return;
    }
    [components removeObjectForKey:@(entity.entityID)];
}



- (Component *)getComponentOfClass:(Class)klass forEntity:(Entity *)entity
{
    return _componentsByClass[NSStringFromClass(klass)][@(entity.entityID)];
}


- (void)removeEntity:(Entity *)entity {
    for (NSMutableDictionary * components in _componentsByClass.allValues)
    {
        if (components[@(entity.entityID)]) {
            [components removeObjectForKey:@(entity.entityID)];
        }
    }
    [_entities removeObject:@(entity.entityID)];
}


- (NSArray *)getAllEntitiesPosessingComponentOfClass:(Class)klass
{
    NSMutableDictionary * components = _componentsByClass[NSStringFromClass(klass)];
    if (components) {
        NSMutableArray * retval = [NSMutableArray arrayWithCapacity:components.allKeys.count];
        for (NSNumber * eid in components.allKeys) {
            [retval addObject:[[Entity alloc] initWithID:eid.integerValue entityManager:self]];
        }
        return retval;
    } else {
        return [NSArray array];
    }
}

@end