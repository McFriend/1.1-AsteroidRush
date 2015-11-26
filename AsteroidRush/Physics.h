//
//  Physics.h
//  AsteroidRush
//
//  Created by George Sabanov on 03.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(uint32_t, THCollisionCategory) {
    CollisionCategoryMeteorit           = 1 << 0,       // 0000
    CollisionCategoryLaser              = 1 << 1,       // 0010
    CollisionCategoryDebris             = 1 << 2,       // 0100
    CollisionCategorySpaceShip          = 1 << 3        // 1000
};

@interface Physics : NSObject
+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max;
@end
