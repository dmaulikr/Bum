//
//  CollisionSystem.m
//  BumGame
//
//  Created by Grant Davis on 4/17/13.
//
//

#import "CollisionSystem.h"
#import "GameObject.h"

@implementation CollisionSystem

- (id)initWithWorld:(b2World *)world
{
    if (self = [super init]) {
        ContactListener *contactListener = new ContactListener();
        world->SetContactListener(contactListener);
    }
    return self;
}

@end


ContactListener::ContactListener() {
}

ContactListener::~ContactListener() {
}

void ContactListener::BeginContact(b2Contact *contact) {
	CCNode *o1 = (__bridge GameObject*)contact->GetFixtureA()->GetBody()->GetUserData();
	CCNode *o2 = (__bridge GameObject*)contact->GetFixtureB()->GetBody()->GetUserData();
    
    if ([o1 isKindOfClass:[GameObject class]]) {
        [(GameObject *)o1 didBeginContactWithObject:o2];
    }
    if ([o2 isKindOfClass:[GameObject class]]) {
        [(GameObject *)o2 didBeginContactWithObject:o1];
    }
}

void ContactListener::EndContact(b2Contact *contact) {
    CCNode *o1 = (__bridge GameObject*)contact->GetFixtureA()->GetBody()->GetUserData();
	CCNode *o2 = (__bridge GameObject*)contact->GetFixtureB()->GetBody()->GetUserData();
    
    if ([o1 isKindOfClass:[GameObject class]]) {
        [(GameObject *)o1 didEndContactWithObject:o2];
    }
    if ([o2 isKindOfClass:[GameObject class]]) {
        [(GameObject *)o2 didEndContactWithObject:o1];
    }
}

void ContactListener::PreSolve(b2Contact *contact, const b2Manifold *oldManifold) {
}

void ContactListener::PostSolve(b2Contact *contact, const b2ContactImpulse *impulse) {
}