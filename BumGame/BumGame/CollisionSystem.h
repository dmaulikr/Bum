//
//  CollisionSystem.h
//  BumGame
//
//  Created by Grant Davis on 4/17/13.
//
//

#import "System.h"
#import "Box2D.h"

@interface CollisionSystem : System

- (id)initWithWorld:(b2World *)world;

@end



class ContactListener : public b2ContactListener {
public:
	ContactListener();
	~ContactListener();
    
	virtual void BeginContact(b2Contact *contact);
	virtual void EndContact(b2Contact *contact);
	virtual void PreSolve(b2Contact *contact, const b2Manifold *oldManifold);
	virtual void PostSolve(b2Contact *contact, const b2ContactImpulse *impulse);
};