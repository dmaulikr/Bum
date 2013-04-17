//
//  GB2ShapeCache+Helpers.m
//  BumGame
//
//  Created by Grant Davis on 4/17/13.
//
//

#import "GB2ShapeCache+Helpers.h"
#import "GameObject.h"

@implementation GB2ShapeCache (Helpers)

- (BOOL)hasBodyNamed:(NSString *)body
{
    return [shapeObjects_ objectForKey:body] != nil;
}

- (b2Body *)createDynamicBodyWithName:(NSString *)bodyName gameObject:(GameObject *)node
{
    return [self createBodyWithName:bodyName type:b2_dynamicBody gameObject:node];
}

- (b2Body *)createStaticBodyWithName:(NSString *)bodyName gameObject:(GameObject *)node
{
    return [self createBodyWithName:bodyName type:b2_staticBody gameObject:node];
}

- (b2Body *)createBodyWithName:(NSString *)bodyName type:(b2BodyType)type gameObject:(GameObject *)node
{
    assert([[GB2ShapeCache sharedShapeCache] hasBodyNamed:bodyName]);
    
    // create a body for physics interactions
    CGPoint p = node.position;
    b2BodyDef bodyDef;
    bodyDef.type = type;
    bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    bodyDef.userData = (__bridge void *)node;
    b2Body *body = node.manager.world->CreateBody(&bodyDef);
    body->SetFixedRotation(YES);
    
    // add the fixture definitions to the body
    [self addFixturesToBody:body forShapeName:bodyName];
    [node setAnchorPoint:[self anchorPointForShape:bodyName]];
    
    return body;
}

@end
