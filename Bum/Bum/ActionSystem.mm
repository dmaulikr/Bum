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
            [renderer.node stopAllActions];
            
            switch (action.actionState) {
                    
                case ActionStateAttack:
                    [renderer.node runAction:action.attackAction];
                    break;
                    
                case ActionStateHurt:
                    [renderer.node runAction:action.hurtAction];
                    break;
                    
                case ActionStateKnockedOut:
                    [renderer.node runAction:action.knockedOutAction];
                    break;
                    
                case ActionStateWalk:
                    [renderer.node runAction:action.walkAction];
                    break;
                    
                case ActionStateIdle:
                case ActionStateNone:
                default:
                    [renderer.node runAction:action.idleAction];
                    break;
            }
        }
    }
}

@end
