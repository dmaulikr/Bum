//
//  MovementSystem.m
//  Bum
//
//  Created by Grant Davis on 3/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MovementSystem.h"
#import "MovementComponent.h"
#import "RenderComponent.h"
#import "PlayerComponent.h"
#import "ActionComponent.h"

@implementation MovementSystem


- (id)initWithEntityManager:(EntityManager *)entityManager
              entityFactory:(EntityFactory *)entityFactory
                    tileMap:(CCTMXTiledMap *)tileMap
{
    if (self = [super initWithEntityManager:entityManager entityFactory:entityFactory]) {
        _tileMap = tileMap;
    }
    return self;
}

- (void)update:(float)dt
{
    NSArray *moveEntities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[MovementComponent class]];
    
    for (Entity *entity in moveEntities) {
        
        MovementComponent *move = (MovementComponent*)[self.entityManager getComponentOfClass:[MovementComponent class] forEntity:entity];
        RenderComponent *render = (RenderComponent*)[self.entityManager getComponentOfClass:[RenderComponent class] forEntity:entity];
        
        if (!move || !render) return;
        
        // determine the new position target by adding velocity
        move.target = ccpAdd(render.node.position, ccpMult(move.velocity, dt));
        
        // stop moving after small distances
        CGPoint vector = ccpSub(move.target, render.node.position);
        float distance = ccpLength(vector);
        if (distance < fabsf(1.f)) {
            render.node.position = move.target;
            return;
        }
        
        float posX = MIN(_tileMap.mapSize.width * _tileMap.tileSize.width - render.centerToSides, MAX(render.centerToSides, move.target.x));
        float posY = MIN(FLOOR_ROWS * _tileMap.tileSize.height + render.centerToBottom, MAX(render.centerToBottom, move.target.y));
        render.node.position = ccp(posX, posY);
        
//        NSLog(@"velocity: %@, target: %@, node position: %@",
//              NSStringFromCGPoint(move.velocity),
//              NSStringFromCGPoint(move.target),
//              NSStringFromCGPoint(render.node.position));
    }
}


#pragma mark - Character Movement

- (void)walkWithDirection:(CGPoint)direction
{
    Entity *player = [[self.entityManager getAllEntitiesPosessingComponentOfClass:[PlayerComponent class]] lastObject];
    
    float walkSpeed = 300.f;
    
    CGPoint velocity = player.movement.velocity = ccp(direction.x * walkSpeed, direction.y * walkSpeed);
    NSLog(@"player velocity: %@", NSStringFromCGPoint(velocity));
    
    if (velocity.x >= 0) player.render.node.scaleX = 1.0;
    else player.render.node.scaleX = -1.0;
}


#pragma mark - SimpleDPadDelegate

- (void)simpleDPadTouchesBegan:(SimpleDPad *)dPad
{
    Entity *player = [[self.entityManager getAllEntitiesPosessingComponentOfClass:[PlayerComponent class]] lastObject];
    player.action.actionState = ActionStateWalk;
}

- (void)simpleDPadTouchesEnded:(SimpleDPad *)dPad
{
    Entity *player = [[self.entityManager getAllEntitiesPosessingComponentOfClass:[PlayerComponent class]] lastObject];
    player.movement.velocity = CGPointZero;
    
    if (player.action.actionState == ActionStateWalk) {
        player.action.actionState = ActionStateIdle;
    }
}

- (void)simpleDPad:(SimpleDPad *)dPad didChangeDirectionTo:(CGPoint)direction
{
    [self walkWithDirection:direction];
}

- (void)simpleDPad:(SimpleDPad *)dPad isHoldingDirection:(CGPoint)direction
{
    [self walkWithDirection:direction];
}

@end
