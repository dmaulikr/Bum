//
//  EntityFactory.h
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "Box2D.h"

@class Entity;
@class EntityManager;
@class CCSpriteBatchNode;
@class CCLayer;
@class CCNode;

@interface EntityFactory : NSObject

- (id)initWithEntityManager:(EntityManager *)entityManager
                      layer:(CCLayer *)layer
                      world:(b2World *)world;

@property (strong, readonly) CCLayer *layer;


- (Entity *)entityForObjectNode:(CCNode *)node;

- (Entity *)createPlayerEntityWithNode:(CCNode *)node;

//- (Entity *)createBulletWithName:(NSString *)name;
//
//- (Entity *)createAIPlayer;

+ (EntityFactory *)sharedFactory;

@end
