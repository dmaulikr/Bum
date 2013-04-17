//
//  ControlsSystem.h
//  Bum
//
//  Created by Grant Davis on 3/22/13.
//
//

#import "System.h"
#import "GameButton.h"
#import "GameInterface.h"

@class ProjectileSystem;
@class ActionSystem;
@class Bum;
@interface ControlsSystem : System <GameButtonDelegate>

@property (nonatomic, unsafe_unretained) Bum *player;
@property (nonatomic, unsafe_unretained) GameInterface *interface;
@property (nonatomic, unsafe_unretained) ProjectileSystem *projectileSystem;

- (id)initWithEntityManager:(EntityManager *)entityManager player:(Bum *)player;

@end
