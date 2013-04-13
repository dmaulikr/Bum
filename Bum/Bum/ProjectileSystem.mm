//
//  ProjectileSystem.m
//  Bum
//
//  Created by Grant Davis on 4/5/13.
//
//

#import "ProjectileSystem.h"
#import "ProjectileComponent.h"
#import "RenderComponent.h"
#import "WeaponComponent.h"
#import "PlayerComponent.h"
#import "ActionSystem.h"

@implementation ProjectileSystem

- (void)update:(float)dt
{
    _elapsedTime += dt;
    
    NSArray *projectileEntities = [self.entityManager getAllEntitiesPosessingComponentOfClass:[ProjectileComponent class]];
    
    for (Entity *entity in projectileEntities) {
     
        RenderComponent *render = (RenderComponent *)[self.entityManager getComponentOfClass:[RenderComponent class] forEntity:entity];
        ProjectileComponent *projectile = (ProjectileComponent *)[self.entityManager getComponentOfClass:[ProjectileComponent class] forEntity:entity];
        
        if (!render || !projectile) return;
        
        // track how far the projectile has travelled
        projectile.elapsedTime += dt;
        projectile.travelledDistance += ccpDistance(projectile.position, render.node.position);
        
        // and remove the projectile if its beyond its max distance
        if (projectile.travelledDistance > projectile.maxDistance || projectile.elapsedTime > projectile.maxDuration) {

            // mark as inactive.
            projectile.isActive = NO;
            
            // remove from scene
            [render.node removeSelf];
            
            // remove from game
            [self.entityManager removeEntity:entity];
        }
        
        // store last position
        projectile.position = render.node.position;
    }
}


- (BOOL)throwProjectileWithWeapon:(WeaponComponent *)weapon direction:(CGPoint)direction
{
    // first determine the last time this weapon fired and and see if we can fire at all.
    CGFloat elapsed = _elapsedTime - weapon.lastFireTime;
    if (elapsed < weapon.fireRate) {
        return NO;
    }
    
    // store weapon firing time
    weapon.lastFireTime = _elapsedTime;
    
    // create a bullet and shoot it
    Entity *playerEntity = [[self.entityManager getAllEntitiesPosessingComponentOfClass:[PlayerComponent class]] lastObject];
    Entity *bullet = [self.entityFactory createBulletWithName:weapon.projectileName];
    float angle = bullet.render.node.body->GetAngle();
    
    b2Vec2 location = playerEntity.render.node.body->GetPosition();
    bullet.render.node.body->SetTransform(location, angle);
    bullet.render.node.body->SetAwake(true);
    
    // adjust the starting position of the bullet so it does not collide with the player sprite
    float xDirection = direction.x != 0.f ? direction.x : playerEntity.render.node.scaleX;
    CGFloat longestSide = fmaxf(playerEntity.render.node.boundingBox.size.width, playerEntity.render.node.boundingBox.size.height);
    
    CGFloat c = sqrtf( longestSide*longestSide + longestSide* longestSide);
    CGFloat offset = (c * .5) / [LevelHelperLoader pixelsToMeterRatio];
    bullet.render.node.body->SetTransform( b2Vec2(location.x + (offset * xDirection), location.y), arc4random() * M_PI_2);
    
    b2Vec2 impulse = b2Vec2(bullet.projectile.fireSpeed.x * xDirection, bullet.projectile.fireSpeed.y);
    b2Body *body = bullet.render.node.body;
    b2Vec2 center = body->GetWorldCenter();
    b2Vec2 rotationPoint = b2Vec2(center.x + arc4random() * bullet.render.node.contentSize.width * .5,
                                  center.y + arc4random() * bullet.render.node.contentSize.height * .5); // apply force to a random point
    body->ApplyLinearImpulse( impulse, rotationPoint);
    
    // store projectile starting position
    bullet.projectile.position = [LevelHelperLoader metersToPoints:body->GetPosition()];

    [_actionSystem playAction:ActionStateAttack forDuration:weapon.animationDuration entity:playerEntity];
    
    return YES;
}

@end
