//
//  CameraSystem.h
//  Bum
//
//  Created by Grant Davis on 3/21/13.
//
//

#import "System.h"

@interface CameraSystem : System


- (id)initWithEntityManager:(EntityManager *)entityManager
              entityFactory:(EntityFactory *)entityFactory
                      layer:(CCLayer *)layer;

@end
