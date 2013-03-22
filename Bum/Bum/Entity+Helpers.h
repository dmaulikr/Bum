//
//  Entity+Helpers.h
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//
//

#import "Entity.h"

@class ActionComponent;
@class RenderComponent;
@class MovementComponent;
@class PlayerComponent;
@interface Entity (Helpers)

- (ActionComponent *)action;
- (RenderComponent *)render;
- (MovementComponent *)movement;
- (PlayerComponent *)player;

@end
