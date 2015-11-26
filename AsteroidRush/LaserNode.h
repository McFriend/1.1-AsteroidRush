//
//  LaserNode.h
//  AsteroidRush
//
//  Created by George Sabanov on 03.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LaserNode : SKSpriteNode


+(instancetype)laserAtPosition:(CGPoint)position withEndPoint:(CGPoint)endPoint;


@end
