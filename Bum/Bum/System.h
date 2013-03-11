//
//  System.h
//  EndlessRPG
//
//  Created by Grant Davis on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "EntityManager.h"
#import "EntityFactory.h"

@interface System : NSObject

@property (strong) EntityManager * entityManager;
@property (strong) EntityFactory * entityFactory;

- (id)initWithEntityManager:(EntityManager *)entityManager
              entityFactory:(EntityFactory *)entityFactory;


- (void)update:(float)dt;

@end
