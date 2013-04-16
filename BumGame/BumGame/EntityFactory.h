//
//  EntityFactory.h
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//
//

#import <Foundation/Foundation.h>

@class Entity;
@class EntityManager;
@class CCSpriteBatchNode;
@class CCLayer;
@class CCNode;
@class LevelHelperLoader;

@interface EntityFactory : NSObject

- (id)initWithEntityManager:(EntityManager *)entityManager
                      layer:(CCLayer *)layer;

@property (strong, readonly) CCLayer *layer;

//- (Entity *)createHumanPlayer;
//
//- (Entity *)createBulletWithName:(NSString *)name;
//
//- (Entity *)createAIPlayer;

@end
