//
//  GameButton.h
//  Bum
//
//  Created by Grant Davis on 3/22/13.
//
//

#import "CCSprite.h"
#import "cocos2d.h"

@protocol GameButtonDelegate;
@interface GameButton : CCSprite <CCTargetedTouchDelegate>

@property (nonatomic, unsafe_unretained) NSObject <GameButtonDelegate> *delegate;
@property (nonatomic) BOOL isHeld;

- (id)initWithFile:(NSString *)file delegate:(NSObject <GameButtonDelegate> *)delegate;

@end


@protocol GameButtonDelegate <NSObject>

- (void)gameButtonTouchesBegan:(GameButton *)gameButton;
- (void)gameButtonTouchesEnded:(GameButton *)gameButton;
- (void)gameButtonTouchesDidEnter:(GameButton *)gameButton;
- (void)gameButtonTouchesDidLeave:(GameButton *)gameButton;
- (void)gameButtonIsBeingHeld:(GameButton *)gameButton;

@end
