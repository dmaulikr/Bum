//
//  GB2ShapeCache+Helpers.h
//  BumGame
//
//  Created by Grant Davis on 4/17/13.
//
//

#import "GB2ShapeCache.h"

// This helper category allows us to check if there have been bodies
// added with a particular name. This is used to automatically create
// bodies from the cache for game objects when created from CocosBuilder.
@class GameObject;
@interface GB2ShapeCache (Helpers)
- (BOOL)hasBodyNamed:(NSString *)body;
- (b2Body *)createDynamicBodyWithName:(NSString *)bodyName gameObject:(GameObject *)node;
- (b2Body *)createStaticBodyWithName:(NSString *)bodyName gameObject:(GameObject *)node;
- (b2Body *)createBodyWithName:(NSString *)bodyName type:(b2BodyType)type gameObject:(GameObject *)node;
@end
