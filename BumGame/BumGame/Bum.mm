//
//  Bum.m
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//
//

#import "Bum.h"
#import "Box2D.h"
#import "GB2ShapeCache.h"
#import "PlayerComponent.h"
#import "RenderComponent.h"
#import "ActionComponent.h"
#import "HealthComponent.h"
#import "MovementComponent.h"

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

@interface Bum () {
    CharacterDirection _characterDirection;
    CharacterMoveState _moveState;
    BOOL _isJumping;
}

@end

@implementation Bum

- (void)didLoadFromCCB
{
    [super didLoadFromCCB];
    
    _moveState = CharacterMoveStateWalking;
    _characterDirection = CharacterDirectionRight;
    self.tag = GameObjectTypePlayer;
    self.entity = [self createPlayerEntityWithNode:self];
    
    [self scheduleUpdate];
}

- (Entity *)createPlayerEntityWithNode:(CCNode *)node
{
    Entity * entity = [self.manager createEntity];
    NSLog(@"bum size: %@", NSStringFromCGSize(node.contentSize));
    
    [self.manager addComponent:[[RenderComponent alloc] initWithNode:node] toEntity:entity];
    [self.manager addComponent:[[PlayerComponent alloc] init] toEntity:entity];
    [self.manager addComponent:[[MovementComponent alloc] initWithDirection:CGPointMake(1.f, 0.f)
                                                                     target:CGPointZero
                                                                      speed:CGPointMake(1.f, 0.f)
                                                               acceleration:CGPointMake(.7f, .7f)]
                      toEntity:entity];
    
//    [GameObject createBodyNamed:@"bum"];
    
    // weapon
//    LHSprite *weaponSprite = [CCBReader nodeGraphFromFile:@"cat"];
//    WeaponComponent *catWeapon = [[WeaponComponent alloc] initWithSprite:weaponSprite
//                                                                   range:100.f
//                                                                  damage:10.f
//                                                            areaOfEffect:NO];
//    catWeapon.animationDuration = .25f;
//    catWeapon.fireRate = .25;
//    catWeapon.projectileName = @"cat";
//    weaponSprite.position = ccp(sprite.boundingBox.size.width * catWeapon.weaponPosition.x,
//                                sprite.boundingBox.size.height * catWeapon.weaponPosition.y);
//    [_entityManager addComponent:catWeapon toEntity:entity];
    
    // Animation Actions
    ActionComponent *actionComp = [[ActionComponent alloc] initWithMovementState:MovementStateIdle];
    actionComp.runAnimation = @"run";
    actionComp.walkAnimation = @"walk";
    actionComp.idleAnimation = @"idle";
    actionComp.attackAnimation = @"throw";
    actionComp.spriteSheet = @"sprites";
    [self.manager addComponent:actionComp toEntity:entity];
    
    // resources
    [self.manager addComponent:[[HealthComponent alloc] initWithCurrentHP:200 maxHP:200] toEntity:entity];
    
    return entity;
}


- (void)update:(ccTime)dt
{
    
}

#pragma mark - Character Movement

- (void)walkWithDirection:(CGPoint)direction
{
    _moveState = CharacterMoveStateWalking;
    self.entity.action.movementState = MovementStateWalk;
    [self setDirection:direction];
}


- (void)runWithDirection:(CGPoint)direction
{
    _moveState = CharacterMoveStateRunning;
    self.entity.action.movementState = MovementStateRun;
    [self setDirection:direction];
}

- (void)setDirection:(CGPoint)direction
{
    self.entity.movement.direction = direction;
    
    if (CGPointEqualToPoint(direction, CGPointZero)) {
        _characterDirection = CharacterDirectionNone;
    }
    else if (direction.x >= 0) {
        _characterDirection = CharacterDirectionRight;
        if (self.entity.render.node.scaleX < 0.0) {
            self.entity.render.node.scaleX *= -1.0;
        }
    }
    else {
        _characterDirection = CharacterDirectionLeft;
        if (self.entity.render.node.scaleX > 0.0) {
            self.entity.render.node.scaleX *= -1.0;
        }
    }
}

#pragma mark - Character Actions

- (void)action
{
    NSLog(@"performing amazing bum action!");
}

- (void)jump
{
    if (_isTouchingFloor && !_isJumping) {
        NSLog(@"jumping");
        _isJumping = YES;
        self.body->ApplyLinearImpulse( b2Vec2(0,PLAYER_JUMP_SPEED), self.body->GetWorldCenter() );
    }
}


#pragma mark - Character Actions

- (void)didBeginContactWithObject:(CCNode *)object
{
    NSLog(@"Bum collided with: %@", object);
    
    // floor contact
    if (object.tag == GameObjectTypeFloor) {
        _isTouchingFloor = YES;
        _isJumping = NO;
    }
}


- (void)didEndContactWithObject:(CCNode *)object
{
    
    // floor contact
    if (object.tag == GameObjectTypeFloor) {
        _isTouchingFloor = NO;
    }
}



@end
