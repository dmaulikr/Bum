//
//  GameLayer.h
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CameraSystem.h"
#import "ControlsSystem.h"
#import "ProjectileSystem.h"
#import "MovementSystem.h"
#import "ActionSystem.h"
#import "HealthSystem.h"
#import "Bum.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "EntityManager.h"
#import "EntityFactory.h"

@interface GameLayer : CCLayer {
    
    // variables set from CCB
    CCLayer *_level;
    
    b2World* _world;					// strong ref
	GLESDebugDraw *m_debugDraw;		// strong ref
    
    // set from CCB
    Bum *player;
    
    // entity framework
    EntityManager *_entityManager;
    EntityFactory *_entityFactory;
    
    // game systems
    HealthSystem *_healthSystem;
    MovementSystem *_movementSystem;
    ActionSystem *_actionSystem;
    CameraSystem *_cameraSystem;
    ControlsSystem *_controlsSystem;
    ProjectileSystem *_projectileSystem;
}

// value set from CCB. this is used to load a physics body that defines the level boundaries.
// this is required to be set for each level. 
@property (strong, nonatomic) NSString *boundaryName;

- (void)didLoadFromCCB;

@end
