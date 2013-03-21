//
//  CameraSystem.h
//  Bum
//
//  Created by Grant Davis on 3/21/13.
//
//

#import "System.h"
#import "LevelHelperLoader.h"

@interface CameraSystem : System

@property (nonatomic, unsafe_unretained) LevelHelperLoader *loader;

- (id)initWithEntityManager:(EntityManager *)entityManager
              entityFactory:(EntityFactory *)entityFactory
                levelLoader:(LevelHelperLoader *)loader
                      layer:(CCLayer *)layer;

@end
