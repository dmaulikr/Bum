//
//  WeaponComponent.m
//  Bum
//
//  Created by Grant Davis on 4/5/13.
//
//

#import "WeaponComponent.h"

@implementation WeaponComponent

- (id)initWithSprite:(LHSprite *)sprite
               range:(float)range
              damage:(float)dmg
        areaOfEffect:(BOOL)aoe
{
    if (self = [super init]) {
        _sprite = sprite;
        _range = range;
        _damage = dmg;
        _isAreaOfEffectDamage = aoe;
        _weaponPosition = CGPointMake(.5f, .5f);
        _animationDuration = 1.f;
        _fireRate = 1.f;
    }
    return self;
}
@end
