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

// Animation Names
@property(nonatomic, strong) NSString *idleAnimation;
@property(nonatomic, strong) NSString *attackAnimation;
@property(nonatomic, strong) NSString *blockAnimation;
@property(nonatomic, strong) NSString *walkAnimation;
@property(nonatomic, strong) NSString *runAnimation;
@property(nonatomic, strong) NSString *hurtAnimation;
@property(nonatomic, strong) NSString *knockedOutAnimation;

@property(nonatomic, strong) NSString *spriteSheet;


- (id)initWithActionState:(ActionState)state;

@end
