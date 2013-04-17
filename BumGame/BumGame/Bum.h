//
//  Bum.h
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//
//

#import "GameObject.h"

@interface Bum : GameObject {
    
    BOOL _isTouchingFloor;
    
    // assigned from CCB
    CCSprite *_sprite;
}

@property (nonatomic,readonly) CCSprite *sprite;

- (void)turnLeft;
- (void)turnRight;
- (void)action;
- (void)jump;

@end
