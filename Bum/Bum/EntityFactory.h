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

@interface EntityFactory : NSObject

- (id)initWithEntityManager:(EntityManager *)entityManager batchNode:(CCSpriteBatchNode *)batchNode;

- (Entity *)createHumanPlayerWithFrameName:(NSString *)frameName;
- (Entity *)createAIPlayer;
- (Entity *)createQuirkMonster;

@end
