//
//  Floor.m
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "StaticBody.h"
#import "GB2ShapeCache+Helpers.h"

@implementation StaticBody

- (void)didLoadFromCCB
{
    self.manager = [EntityManager sharedManager];
    NSString *className = NSStringFromClass([self class]);
    if ([[GB2ShapeCache sharedShapeCache] hasBodyNamed:className]) {
        self.body = [[GB2ShapeCache sharedShapeCache] createStaticBodyWithName:className
                                                                    gameObject:self];
    }
}

@end
