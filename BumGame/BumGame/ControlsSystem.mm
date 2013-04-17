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

#define WALK_ACCELERATION 4.f
#define RUN_ACCELERATION 8.f
#define JUMP_ACCELERATION_REDUCTION .666
#define JUMP_MAX_HOLD_TIME 1.f
#define STOP_SPEED_FRICTION .1f
#define TURN_SPEED_FRICTION .1f

#define HOLD_DURATION_BEFORE_RUNNING .33f

typedef enum CharacterDirection {
    CharacterDirectionNone = 0,
    CharacterDirectionLeft,
    CharacterDirectionRight
} CharacterDirection;

typedef enum CharacterMoveState {
    CharacterMoveStateIdle = 0,
    CharacterMoveStateWalking,
    CharacterMoveStateRunning
} CharacterMoveState;

@interface ControlsSystem () {
    CGPoint _direction;
    CharacterDirection _characterDirection;
    CharacterMoveState _moveState;
    float _bButtonHoldDuration;
    BOOL _isTouchingFloor;
    BOOL _isJumping;
}

@end

@implementation ControlsSystem

- (id)init
{
    if (self = [super init]) {
        _characterDirection = CharacterDirectionRight;
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


#pragma mark - Character Movement

- (void)walkWithDirection:(CGPoint)direction
{
    _moveState = CharacterMoveStateWalking;
    _playerEntity.action.movementState = MovementStateWalk;
    [self setDirection:direction];
}


- (void)runWithDirection:(CGPoint)direction
{
    _moveState = CharacterMoveStateRunning;
    _playerEntity.action.movementState = MovementStateRun;
    [self setDirection:direction];
}

- (void)setDirection:(CGPoint)direction
{
    _direction = direction;
    
    if (CGPointEqualToPoint(direction, CGPointZero)) {
        _characterDirection = CharacterDirectionNone;
    }
    else if (direction.x >= 0) {
        _characterDirection = CharacterDirectionRight;
        if (_playerEntity.render.node.scaleX < 0.0) {
            _playerEntity.render.node.scaleX *= -1.0;
        }
    }
    else {
        _characterDirection = CharacterDirectionLeft;
        if (_playerEntity.render.node.scaleX > 0.0) {
            _playerEntity.render.node.scaleX *= -1.0;
        }
    }
}


#pragma mark - GameButtonDelegate

- (void)gameButtonTouchesBegan:(GameButton *)gameButton
{
    NSLog(@"began");
    if (gameButton == self.interface.controls.jumpButton) {
        
    }
}


- (void)gameButtonTouchesEnded:(GameButton *)gameButton
{
    NSLog(@"ended");

}

- (void)gameButtonTouchesDidEnter:(GameButton *)gameButton
{
    NSLog(@"enter");
}

- (void)gameButtonTouchesDidLeave:(GameButton *)gameButton
{
    NSLog(@"leave");

}


- (void)gameButtonIsBeingHeld:(GameButton *)gameButton
{
}

@end
