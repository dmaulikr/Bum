//
//  HealthComponent.h
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Component.h"

@interface HealthComponent : Component {
    
}

@property (nonatomic) CGFloat current;
@property (nonatomic) CGFloat max;
@property (nonatomic) BOOL isAlive;

- (id)initWithCurrentHP:(float)curHp maxHP:(float)maxHp;

@end
