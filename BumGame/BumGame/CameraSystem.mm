//
//  CameraSystem.m
//  Bum
//
//  Created by Grant Davis on 3/21/13.
//
//

#import "CameraSystem.h"
#import "PlayerComponent.h"
#import "RenderComponent.h"
#import "MovementComponent.h"

@interface CameraSystem () {
    __unsafe_unretained CCLayer *_layer;
}

@end

@implementation CameraSystem

- (id)initWithEntityManager:(EntityManager *)entityManager
                      layer:(CCLayer *)layer
{
    if (self = [super initWithEntityManager:entityManager]) {
        _layer = layer;
    }
    return self;
}

- (void)update:(float)dt
{
    NSArray *players = [self.entityManager getAllEntitiesPosessingComponentOfClass:[PlayerComponent class]];
    assert(players.count == 1);
    
    Entity *entity = [players lastObject];
    PlayerComponent *player = [entity player];
    RenderComponent *render = [entity render];
    assert(player);
    assert(render);
    
    // move the parallax
    [self setViewpointCenter:render.node.position];
}


-(void)setViewpointCenter:(CGPoint) position {
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGRect worldRect = CGRectMake(0, 0, _layer.contentSize.width, _layer.contentSize.height);
    
    int x = MAX(position.x, worldRect.origin.x + winSize.width / 2);
    int y = MAX(position.y, worldRect.origin.y + winSize.height / 2);
    x = MIN(x, (worldRect.origin.x + worldRect.size.width) - winSize.width / 2);
    y = MIN(y, (worldRect.origin.y + worldRect.size.height) - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    
    _layer.position = viewPoint;
}



@end
