//
//  PlayerComponent.h
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Component.h"
#import "WeaponComponent.h"

@interface PlayerComponent : Component {
    
}

- (float)walkSpeed;
- (float)runSpeed;
- (float)jumpSpeed;

@end
