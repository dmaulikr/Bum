//
//  Bum.m
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//
//

#import "Bum.h"

@implementation Bum

- (id)init
{
    if (self = [super init]) {
        [self addComponent:[Component new]];
    }
    return self;
}

@end
