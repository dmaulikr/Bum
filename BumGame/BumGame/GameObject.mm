
//  GameObject.m
//  BumGame
//
//  Created by Grant Davis on 4/13/13.
//
//

#import "GameObject.h"
#import "EntityFactory.h"

#pragma mark - GB2ShapeCache

@implementation GB2ShapeCache (GameObject)

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


#pragma mark - GameObject

@implementation GameObject

- (void)didLoadFromCCB
{
    self.manager = [EntityManager sharedManager];
    
    // this code automatically looks for shapes that have the same class as this game object.
    // if a shape is found, we'll create a dynamic body and store a reference.
    NSString *className = NSStringFromClass([self class]);
    if ([[GB2ShapeCache sharedShapeCache] hasBodyNamed:className]) {
        self.body = [[GB2ShapeCache sharedShapeCache] createDynamicBodyWithName:className gameObject:self];
    }
}

@end

