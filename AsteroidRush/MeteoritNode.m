//
//  MeteoritNode.m
//  AsteroidRush
//
//  Created by George Sabanov on 03.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//

#import "MeteoritNode.h"

@implementation MeteoritNode
+ (instancetype) meteoritAtPosition:(CGPoint)position{
    MeteoritNode *meteorit = [self spriteNodeWithImageNamed:@"rock"];
    meteorit.position = position;
    SKAction *animation = [SKAction rotateByAngle:45 duration:0.2];
    SKAction *animateRepeat = [SKAction repeatActionForever:animation];
    [meteorit runAction:animateRepeat];
    [meteorit setupPhysicsBody];
    meteorit.name = @"meteorit";
    return meteorit;
    
}
-(void)setupPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategorySpaceShip | CollisionCategoryLaser;
    self.physicsBody.categoryBitMask = CollisionCategoryMeteorit;
}
@end
