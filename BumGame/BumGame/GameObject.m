//
//  GameObject.m
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//
//

#import "GameObject.h"

@interface GameObject() {
    NSMutableArray *_components;
}

@end

@implementation GameObject

- (id)init
{
    if (self = [super init]) {
        _components = [NSMutableArray array];
    }
    return self;
}

- (void)addComponent:(Component *)component
{
    [_components addObject:component];
}

- (void)removeComponent:(Component *)component
{
    if ([_components containsObject:component]) {
        [_components removeObject:component];
    }
}
         
- (BOOL)hasComponentOfClass:(Class)klass
{
    for (Component *comp in _components) {
        if ([comp isKindOfClass:klass]) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)componentsWithClass:(Class)klass
{
    NSMutableArray *matches = [NSMutableArray array];
    for (Component *comp in _components) {
        if ([comp isKindOfClass:klass]) {
            [matches addObject:comp];
        }
    }
    return matches;
}

- (NSArray *)components
{
    return [NSArray arrayWithArray:_components];
}

@end
