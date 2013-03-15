//
//  SimpleDPad.h
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol SimpleDPadDelegate;
@interface SimpleDPad : CCSprite <CCTargetedTouchDelegate> {
    float _radius;
}

@property (nonatomic, assign) NSObject <SimpleDPadDelegate> *delegate;
@property (nonatomic, readonly) CGPoint direction;
@property (nonatomic) BOOL isHeld;

- (id)initWithFile:(NSString *)filename radius:(float)radius;
+ (id)dPadWithFile:(NSString *)filename radius:(float)radius;

@end

@protocol SimpleDPadDelegate <NSObject>

- (void)simpleDPadTouchesBegan:(SimpleDPad *)dPad;
- (void)simpleDPadTouchesEnded:(SimpleDPad *)dPad;
- (void)simpleDPad:(SimpleDPad *)dPad isHoldingDirection:(CGPoint)direction;
- (void)simpleDPad:(SimpleDPad *)dPad didChangeDirectionTo:(CGPoint)direction;

@end