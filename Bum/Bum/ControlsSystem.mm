//
//  ControlsSystem.m
//  Bum
//
//  Created by Grant Davis on 3/22/13.
//
//

#import "ControlsSystem.h"
#import "Box2D.h"
#import "RenderComponent.h"
#import "PlayerComponent.h"
#import "ActionComponent.h"

@implementation ControlsSystem


#pragma mark - Character Movement

- (void)walkWithDirection:(CGPoint)direction
{
    float acceleration = 10.f;
    
    b2Body *body = _playerEntity.render.node.body;
    b2Vec2 velocity = _playerEntity.render.node.body->GetLinearVelocity();
    
    float maxVelocityDelta = _playerEntity.player.walkSpeed - velocity.x;
    float force = maxVelocityDelta > acceleration ? acceleration : maxVelocityDelta;
    b2Vec2 forceVec = b2Vec2(force * direction.x, 0.f);
    
    NSLog(@"velocity x: %.2f, force: %.2f", velocity.x, force);
    if (fabsf(velocity.x) < _playerEntity.player.walkSpeed) {
        body->ApplyLinearImpulse(forceVec, _playerEntity.render.node.body->GetPosition());
    }
    
    //    player.movement.velocity = velocity;
    
    //    NSLog(@"player velocity: %@", NSStringFromCGPoint(velocity));
    
    // change the direction the sprite is facing 
    if (direction.x >= 0) _playerEntity.render.node.scaleX = 1.0;
    else _playerEntity.render.node.scaleX = -1.0;
}


- (void)jump
{
    b2Body *body = _playerEntity.render.node.body;
//    body->ApplyForceToCenter(b2Vec2(0, 100.f));
    body->ApplyLinearImpulse(b2Vec2(0,50.f), body->GetLocalCenter());
}



#pragma mark - SimpleDPadDelegate

- (void)simpleDPadTouchesBegan:(SimpleDPad *)dPad
{
    _playerEntity.action.actionState = ActionStateWalk;
}

- (void)simpleDPadTouchesEnded:(SimpleDPad *)dPad
{
    _playerEntity.action.actionState = ActionStateIdle;
}

- (void)simpleDPad:(SimpleDPad *)dPad didChangeDirectionTo:(CGPoint)direction
{
    [self walkWithDirection:direction];
}

- (void)simpleDPad:(SimpleDPad *)dPad isHoldingDirection:(CGPoint)direction
{
    [self walkWithDirection:direction];
}


#pragma mark - GameButtonDelegate

- (void)gameButtonTouchesBegan:(GameButton *)gameButton
{
    [self jump];
}

- (void)gameButtonTouchesEnded:(GameButton *)gameButton
{
    
}

- (void)gameButtonTouchesDidLeave:(GameButton *)gameButton
{
    
}

- (void)gameButtonIsBeingHeld:(GameButton *)gameButton
{
    
}

@end
