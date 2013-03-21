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
@class LevelHelperLoader;

@interface EntityFactory : NSObject

- (id)initWithEntityManager:(EntityManager *)entityManager
                      layer:(CCLayer *)layer
          levelHelperLoader:(LevelHelperLoader *)loader;

- (Entity *)createHumanPlayer;
- (Entity *)createAIPlayer;

@end
