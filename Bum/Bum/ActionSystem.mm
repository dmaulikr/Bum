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
        
        if (renderer.actionState != action.actionState) {
            
            renderer.actionState = action.actionState;
            
            switch (action.actionState) {
                    
                case ActionStateAttack:
                    [renderer.node prepareAnimationNamed:action.attackAnimation fromSHScene:action.spriteSheet];
                    break;
                
                case ActionStateBlock:
                    [renderer.node prepareAnimationNamed:action.blockAnimation fromSHScene:action.spriteSheet];
                    break;
                    
                case ActionStateHurt:
                    [renderer.node prepareAnimationNamed:action.hurtAnimation fromSHScene:action.spriteSheet];
                    break;
                    
                case ActionStateKnockedOut:
                    [renderer.node prepareAnimationNamed:action.knockedOutAnimation fromSHScene:action.spriteSheet];
                    break;
                    
                case ActionStateWalk:
                    [renderer.node prepareAnimationNamed:action.walkAnimation fromSHScene:action.spriteSheet];
                    break;
                    
                case ActionStateRun:
                    [renderer.node prepareAnimationNamed:action.runAnimation fromSHScene:action.spriteSheet];
                    break;
                    
                case ActionStateIdle:
                case ActionStateNone:
                default:
                    [renderer.node prepareAnimationNamed:action.idleAnimation fromSHScene:action.spriteSheet];
                    break;
            }
            
            [renderer.node playAnimation];
        }
    }
}

@end
