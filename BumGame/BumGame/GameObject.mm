//
//  GameObject.m
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//
//

#import "GameObject.h"
#import "EntityFactory.h"

@implementation GameObject

- (void)didLoadFromCCB
{
    self.manager = [EntityManager sharedManager];
}

@end
