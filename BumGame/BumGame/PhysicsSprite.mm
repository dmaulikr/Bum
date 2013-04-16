//
//  PhysicsSprite.mm
//  Phyisc
//
//  Created by Grant Davis on 4/16/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import "PhysicsSprite.h"

#pragma mark - PhysicsSprite
@implementation PhysicsSprite

- (void)didLoadFromCCB
{
    CGPoint p = self.position;
    
//    // Define the dynamic body.
//	//Set up a 1m squared box in the physics world
//	b2BodyDef bodyDef;
//	bodyDef.type = b2_dynamicBody;
//	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
//	b2Body *body = world->CreateBody(&bodyDef);
//	
//	// Define another box shape for our dynamic body.
//	b2PolygonShape dynamicBox;
//	dynamicBox.SetAsBox(.5f, .5f);//These are mid points for our 1m box
//    
//	// Define the dynamic body fixture.
//	b2FixtureDef fixtureDef;
//	fixtureDef.shape = &dynamicBox;
//	fixtureDef.density = 1.0f;
//	fixtureDef.friction = 0.3f;
//	body->CreateFixture(&fixtureDef);
//	
//	[sprite setPhysicsBody:body];
}


-(void)setPhysicsBody:(b2Body *)body
{
	body_ = body;
}

// this method will only get called if the sprite is batched.
// return YES if the physics values (angles, position ) changed
// If you return NO, then nodeToParentTransform won't be called.
-(BOOL) dirty
{
	return YES;
}

// returns the transform matrix according the Chipmunk Body values
-(CGAffineTransform) nodeToParentTransform
{	
	b2Vec2 pos  = body_->GetPosition();
	
	float x = pos.x * PTM_RATIO;
	float y = pos.y * PTM_RATIO;
	
	if ( ignoreAnchorPointForPosition_ ) {
		x += anchorPointInPoints_.x;
		y += anchorPointInPoints_.y;
	}
	
	// Make matrix
	float radians = body_->GetAngle();
	float c = cosf(radians);
	float s = sinf(radians);
	
	if( ! CGPointEqualToPoint(anchorPointInPoints_, CGPointZero) ){
		x += c*-anchorPointInPoints_.x + -s*-anchorPointInPoints_.y;
		y += s*-anchorPointInPoints_.x + c*-anchorPointInPoints_.y;
	}
	
	// Rot, Translate Matrix
	transform_ = CGAffineTransformMake( c,  s,
									   -s,	c,
									   x,	y );	
	
	return transform_;
}


@end
