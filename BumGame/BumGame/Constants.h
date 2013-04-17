//
//  Constants.h
//  BumGame
//
//  Created by Grant Davis on 4/16/13.
//
//

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32

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
    ActionStateAttack,
    ActionStateBlock,
    ActionStateHurt,
    ActionStateKnockedOut
} ActionState;

typedef enum MovementState {
    MovementStateIdle,
    MovementStateWalk,
    MovementStateRun
} MovementState;

typedef enum GameObjectType {
    GameObjectTypeFloor = 0,
    GameObjectTypePlayer,
    GameObjectTypeEnemy,
    GameObjectTypePowerup
} GameObjectType;

// 4 - structures
typedef struct _BoundingBox {
    CGRect actual;
    CGRect original;
} BoundingBox;


// the number of map tiles the main character can vertically move between.
#define FLOOR_ROWS 3

#define PLAYER_WALK_SPEED 7.5f
#define PLAYER_RUN_SPEED 15.f
#define PLAYER_JUMP_SPEED 500.f


// 5 - positioning
// these helper macros are used to correct positionnig between ipad/iphone
/*  DETERMINE THE DEVICE USED  */
#ifdef UI_USER_INTERFACE_IDIOM()
#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD() (NO)
#endif

#define ADJUST_CCP(__p__)       \
(IS_IPAD() == NO ?             \
ccp( __p__.x / 2, __p__.y / 2 ) : \
__p__)

#define REVERSE_CCP(__p__)      \
(IS_IPAD() == YES ?             \
ccp( ( __p__.x - kXoffsetiPad ) / 2, ( __p__.y - kYoffsetiPad ) / 2 ) : \
__p__)
