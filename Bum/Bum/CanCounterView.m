//
//  CanCounterView.m
//  Bum
//
//  Created by Grant Davis on 4/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CanCounterView.h"

@interface CanCounterView () {
    CCLabelTTF *_textLabel;
}

@end


@implementation CanCounterView

- (id)init
{
    if (self = [super init]) {
        _textLabel = [[CCLabelTTF alloc] initWithString:@"0"
                                               fontName:@"Helvetica"
                                               fontSize:18.f];
        [self addChild:_textLabel];
    }
    return self;
}

@end
