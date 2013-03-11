//
//  Component.h
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Entity;
@interface Component : NSObject {
    
}

@property (nonatomic) BOOL isEnabled;
@property (nonatomic) int type;
@property (strong, nonatomic) Entity *parentEntity;

- (void)didAddToEntity:(Entity *)entity;
- (void)didRemoveFromEntity:(Entity *)entity;
- (void)update:(ccTime)time;

@end