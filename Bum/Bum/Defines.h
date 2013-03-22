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


// the number of map tiles the main character can vertically move between.
#define FLOOR_ROWS 3

#define PLAYER_WALK_SPEED 10.f
#define PLAYER_RUN_SPEED 20.f
#define PLAYER_JUMP_SPEED 15.f