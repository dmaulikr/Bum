//
//  Defines.h
//  Bum
//
//  Created by Grant Davis on 3/15/13.
//
//
// 1 - convenience measurements
#define SCREEN [[CCDirector sharedDirector] winSize]
#define CENTER ccp(SCREEN.width/2, SCREEN.height/2)
#define CURTIME CACurrentMediaTime()

// 2 - convenience functions
#define random_range(low,high) (arc4random()%(high-low+1))+low
#define frandom (float)arc4random()/UINT64_C(0x100000000)
#define frandom_range(low,high) ((high-low)*frandom)+low

// 3 - enumerations
typedef enum ActionState {
    ActionStateNone = 0,
    ActionStateIdle,
    ActionStateAttack,
    ActionStateWalk,
    ActionStateHurt,
    ActionStateKnockedOut
} ActionState;

// 4 - structures
typedef struct _BoundingBox {
    CGRect actual;
    CGRect original;
} BoundingBox;

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32