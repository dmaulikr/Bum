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

@interface GameObject : CCNode {
}

@property (unsafe_unretained, nonatomic) Entity *entity;
@property (unsafe_unretained, nonatomic) EntityManager *manager;

- (void)didLoadFromCCB;

@end
