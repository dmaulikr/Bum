//
//  GameObject.h
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//
//

#import <Foundation/Foundation.h>
#import "Component.h"

// GameObjects hold components which describe the nature of an object.
// The different systems in the game interact with the components of objects
@interface GameObject : NSObject

- (void)addComponent:(Component *)component;
- (void)removeComponent:(Component *)component;
- (BOOL)hasComponentOfClass:(Class)klass;

- (NSArray *)components;
- (NSArray *)componentsWithClass:(Class)klass;

@end
