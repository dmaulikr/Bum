//
//  ActionComponent.h
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Component.h"

@interface ActionComponent : Component {
    
}

// state
@property(nonatomic, assign) ActionState actionState;

// CCActions
@property(nonatomic, strong) id idleAction;
@property(nonatomic, strong) id attackAction;
@property(nonatomic, strong) id walkAction;
@property(nonatomic, strong) id hurtAction;
@property(nonatomic, strong) id knockedOutAction;

- (id)initWithActionState:(ActionState)state;

@end
