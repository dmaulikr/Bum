//
//  GameObject.h
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//
//

#import <Foundation/Foundation.h>
#import "Component.h"
#import "Entity.h"
#import "EntityManager.h"
#import "GB2ShapeCache.h"

@interface GameObject : CCSprite {
}

@property (unsafe_unretained, nonatomic) b2Body *body;
@property (unsafe_unretained, nonatomic) Entity *entity;
@property (unsafe_unretained, nonatomic) EntityManager *manager;

- (void)didLoadFromCCB;

@end


// This helper category allows us to check if there have been bodies
// added with a particular name. This is used to automatically create
// bodies from the cache for game objects when created from CocosBuilder.
@interface GB2ShapeCache (GameObject)
- (BOOL)hasBodyNamed:(NSString *)body;
- (b2Body *)createDynamicBodyWithName:(NSString *)bodyName gameObject:(GameObject *)node;
- (b2Body *)createStaticBodyWithName:(NSString *)bodyName gameObject:(GameObject *)node;
- (b2Body *)createBodyWithName:(NSString *)bodyName type:(b2BodyType)type gameObject:(GameObject *)node;
@end