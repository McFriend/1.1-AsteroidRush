//
//  LaserNode.m
//  AsteroidRush
//
//  Created by George Sabanov on 03.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//

#import "LaserNode.h"
#import "SpaceShipNode.h"
#import "Physics.h"
@implementation LaserNode

+(instancetype)laserAtPosition:(CGPoint)position withEndPoint:(CGPoint)endPoint{
    LaserNode *laser = [self spriteNodeWithImageNamed:@"missile"];
    laser.position = position;
    
        //CGPoint endPoint = CGPointMake(spaceShip.position.x, self.view.frame.size.height + 50);
    
        SKAction *moveLaser = [SKAction moveTo:endPoint duration:1];
        laser.physicsBody.collisionBitMask = 0;
        laser.physicsBody.contactTestBitMask = CollisionCategoryMeteorit;
        laser.physicsBody.categoryBitMask = CollisionCategoryLaser;
    
        [laser runAction:moveLaser];
    [laser setupPhysicsBody];
    laser.name = @"laser";
    return laser;
}
- (void) setupPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryLaser;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryMeteorit;
}


@end
