//
//  HealthComponent.m
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HealthComponent.h"


@implementation HealthComponent

- (id)initWithCurrentHP:(float)curHp maxHP:(float)maxHp
{
    if (self = [super init]) {
        _current = curHp;
        _max = maxHp;
        self.isAlive = YES;
    }
    return self;
}

@end
