//
//  MeteoritNode.h
//  AsteroidRush
//
//  Created by George Sabanov on 03.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SpaceShipNode.h"
#import "LaserNode.h"
#import "Physics.h"
@interface MeteoritNode : SKSpriteNode
+ (instancetype) meteoritAtPosition:(CGPoint)position;

@end
