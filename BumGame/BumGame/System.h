//
//  System.h
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "EntityManager.h"

@interface System : NSObject

@property (strong) EntityManager * entityManager;

- (id)initWithEntityManager:(EntityManager *)entityManager;

- (void)update:(float)dt;

@end
