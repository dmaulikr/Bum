 //
//  MovementComponent.h
//  Bum
//
//  Created by Grant Davis on 3/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Component.h"

@interface MovementComponent : Component {
    
}

@property (nonatomic) CGPoint velocity;
@property (nonatomic) CGFloat rotationVelocity;
@property (nonatomic) CGFloat friction;

@end
