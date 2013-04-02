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
#import "LevelHelperLoader.h"

@interface RenderComponent : Component {
    
}

@property (strong, nonatomic, readonly) LHSprite *node;
@property (nonatomic, assign) float centerToSides;
@property (nonatomic, assign) float centerToBottom;
@property (strong, nonatomic) NSString *currentAnimation;

- (id)initWithNode:(LHSprite *)node centerToSides:(float)centerToSides centerToBottom:(float)centerToBottom;

@end
