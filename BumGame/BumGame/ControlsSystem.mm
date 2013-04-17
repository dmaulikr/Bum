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
#import "WeaponComponent.h"
#import "ProjectileComponent.h"
#import "ProjectileSystem.h"
#import "ActionSystem.h"
#import "Bum.h"

#define WALK_ACCELERATION 4.f
#define RUN_ACCELERATION 8.f
#define JUMP_ACCELERATION_REDUCTION .666
#define JUMP_MAX_HOLD_TIME 1.f
#define STOP_SPEED_FRICTION .1f
#define TURN_SPEED_FRICTION .1f

#define HOLD_DURATION_BEFORE_RUNNING .33f


@interface ControlsSystem () {
    CGPoint _direction;
    float _bButtonHoldDuration;
    BOOL _isTouchingFloor;
    BOOL _isJumping;
}

@end

@implementation ControlsSystem

- (id)initWithEntityManager:(EntityManager *)entityManager player:(Bum *)player
{
    if (self = [super initWithEntityManager:entityManager]) {
        _player = player;
        _isTouchingFloor = YES;
    }
    return self;
}


- (void)setInterface:(GameInterface *)interface
{
    _interface = interface;
    _interface.controls.jumpButton.delegate = self;
    _interface.controls.actionButton.delegate = self;
}



- (void)update:(float)dt
{
//    b2Body *body = _playerEntity.render.node.body;
//    b2Vec2 vel = body->GetLinearVelocity();
//    
//    // MOVEMENT ---------------------------------------------------------------------
//    
//    if (_hud.runButton.isHeld) {
//        _bButtonHoldDuration += dt;
//        if (_bButtonHoldDuration < HOLD_DURATION_BEFORE_RUNNING) {
//            return;
//        }
//    }
//    
//    // find the characters speed
//    float maxVelocity;
//    float acceleration;
//    
//    switch (_moveState) {
//        case CharacterMoveStateRunning: {
//            maxVelocity = _playerEntity.player.runSpeed;
//            acceleration = RUN_ACCELERATION;
//            break;
//        }
//        case CharacterMoveStateWalking:
//        default: {
//            maxVelocity = _playerEntity.player.walkSpeed;
//            acceleration = WALK_ACCELERATION;
//            break;
//        }
//    }
//    
//    float targetVelocity;
//    switch (_characterDirection) {
//        case CharacterDirectionNone:
//            targetVelocity = vel.x * STOP_SPEED_FRICTION;
//            break;
//            
//        case CharacterDirectionLeft:
//            targetVelocity = b2Max( vel.x - acceleration, -maxVelocity );;
//            break;
//            
//        case CharacterDirectionRight:
//            targetVelocity = b2Min( vel.x + acceleration, maxVelocity );;
//            break;
//            
//        default:
//            break;
//    }
//    
//    float velChange = (targetVelocity - vel.x) * TURN_SPEED_FRICTION;    
//    float impulse = body->GetMass() * velChange;
//    body->ApplyLinearImpulse( b2Vec2(impulse,0), body->GetWorldCenter() );
}


#pragma mark - GameButtonDelegate

- (void)gameButtonTouchesBegan:(GameButton *)gameButton
{
//    NSLog(@"began");
    if (gameButton == self.interface.controls.jumpButton) {
        [_player jump];
    }
    if (gameButton == self.interface.controls.actionButton) {
        [_player action];
    }
}


- (void)gameButtonTouchesEnded:(GameButton *)gameButton
{
//    NSLog(@"ended");

}

- (void)gameButtonTouchesDidEnter:(GameButton *)gameButton
{
//    NSLog(@"enter");
}

- (void)gameButtonTouchesDidLeave:(GameButton *)gameButton
{
//    NSLog(@"leave");

}


- (void)gameButtonIsBeingHeld:(GameButton *)gameButton
{
}

@end
