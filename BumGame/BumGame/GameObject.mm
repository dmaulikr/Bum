
//  GameObject.m
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//
//

#import "GameObject.h"
#import "GB2ShapeCache+Helpers.h"

#pragma mark - GameObject

@implementation GameObject

- (void)didBeginContactWithObject:(CCNode *)object {}
- (void)didEndContactWithObject:(CCNode *)object {}

- (void)didLoadFromCCB
{
    self.manager = [EntityManager sharedManager];
    
    // this code automatically looks for shapes that have the same class as this game object.
    // if a shape is found, we'll create a dynamic body and store a reference.
    NSString *className = NSStringFromClass([self class]);
    if ([[GB2ShapeCache sharedShapeCache] hasBodyNamed:className]) {
        self.body = [[GB2ShapeCache sharedShapeCache] createDynamicBodyWithName:className gameObject:self];
    }
}

@end

