//
//  ActionSystem.m
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//
//

#import "ActionSystem.h"
#import "Entity.h"
#import "ActionComponent.h"
#import "RenderComponent.h"

@implementation ActionSystem

- (void)update:(float)dt
{
    NSArray *actionEntities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[ActionComponent class]];
 
    for (Entity *entity in actionEntities)
    {
        ActionComponent *action = (ActionComponent *)[self.entityManager getComponentOfClass:[ActionComponent class] forEntity:entity];
        RenderComponent *renderer = (RenderComponent *)[self.entityManager getComponentOfClass:[RenderComponent class] forEntity:entity];
        
        if (!action || !renderer) return;
        
        
        NSString *animationName;
    
        // first determine animation name based on movement.
        switch (action.movementState) {
                
            case MovementStateWalk:
                animationName = action.walkAnimation;
                break;
                
            case MovementStateRun:
                animationName = action.runAnimation;
                break;
                
            case MovementStateIdle:
            default:
                animationName = action.idleAnimation;
                break;
        }
        
        // if we have an action state, use that animation
        switch (action.actionState) {
                
            case ActionStateAttack:
                animationName = action.attackAnimation;
                break;
                
            case ActionStateBlock:
                animationName = action.blockAnimation;
                break;
                
            case ActionStateHurt:
                animationName = action.hurtAnimation;
                break;
                
            case ActionStateKnockedOut:
                animationName = action.knockedOutAnimation;
                break;
                
            case ActionStateNone:
                break;
        }
        
        // play the animation if its not already playing
        if (![renderer.currentAnimation isEqualToString:animationName]) {
            [renderer.node prepareAnimationNamed:animationName fromSHScene:action.spriteSheet];
            [renderer.node playAnimation];
        }
    }
}

@end
