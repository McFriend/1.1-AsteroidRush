//
//  Physics.m
//  AsteroidRush
//
//  Created by George Sabanov on 03.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//

#import "Physics.h"

@implementation Physics
+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max {
    return arc4random()%(max - min) + min;
}
@end
