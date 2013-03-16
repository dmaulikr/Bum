//
//  ResourceSystem.m
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//
//

#import "HealthSystem.h"
#import "HealthComponent.h"
#import "RenderComponent.h"

@implementation HealthSystem

- (void)update:(float)dt {
    
    // 1
    NSArray * entities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[HealthComponent class]];
    for (Entity * entity in entities) {
        
        // 2
        HealthComponent * health = (HealthComponent *) [self.entityManager getComponentOfClass:[HealthComponent class] forEntity:entity];
        RenderComponent * render = (RenderComponent *) [self.entityManager getComponentOfClass:[RenderComponent class] forEntity:entity];
        
        // 3
        if (!health.isAlive) return;
        if (health.max == 0) return;
        if (health.current <= 0) {
            
            // play sound
            
            // mark dead
            health.isAlive = FALSE;
            render.actionState = ActionStateKnockedOut;
            
            // 4
            if (render) {
                [render.node runAction:
                 [CCSequence actions:
                  [CCFadeOut actionWithDuration:0.5],
                  [CCCallBlock actionWithBlock:^{
                     [render.node removeFromParentAndCleanup:YES];
                     [self.entityManager removeEntity:entity];
                 }], nil]];
            } else {
                [self.entityManager removeEntity:entity];
            }
        }
    }    
}


- (void)draw {
    NSArray * entities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[HealthComponent class]];
    for (Entity * entity in entities) {
        
        HealthComponent * health = (HealthComponent *) [self.entityManager getComponentOfClass:[HealthComponent class] forEntity:entity];
        RenderComponent * render = (RenderComponent *) [self.entityManager getComponentOfClass:[RenderComponent class] forEntity:entity];
        if (!health || !render) continue;
        
        int sX = render.node.position.x - render.node.contentSize.width/2;
        int eX = render.node.position.x + render.node.contentSize.width/2;
        int actualY = render.node.position.y + render.node.contentSize.height/3;
        
        static int maxColor = 200;
        static int colorBuffer = 55;
        float percentage = ((float) health.current) / ((float) health.max);
        int actualX = ((eX-sX) * percentage) + sX;
        int amtRed = ((1.0f-percentage)*maxColor)+colorBuffer;
        int amtGreen = (percentage*maxColor)+colorBuffer;
        
        glLineWidth(7);
        ccDrawColor4B(amtRed,amtGreen,0,255);
        ccDrawLine(ccp(sX, actualY), ccp(actualX, actualY));
    }    
}


@end
