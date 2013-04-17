//
//  RenderComponent.h
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Component.h"
#import "GameObject.h"

@interface RenderComponent : Component {
    
}

@property (strong, nonatomic, readonly) GameObject *node;
@property (strong, nonatomic) NSString *currentAnimation;

- (id)initWithNode:(CCNode *)node;

@end
