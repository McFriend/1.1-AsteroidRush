//
//  SpaceShipNode.m
//  AsteroidRush
//
//  Created by George Sabanov on 03.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//

#import "SpaceShipNode.h"
#import "Physics.h"
@implementation SpaceShipNode
+ (instancetype) spaceShipAtPosition:(CGPoint)position{
    SpaceShipNode *spaceShip = [self spriteNodeWithImageNamed:@"ship-small_01"];
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"ship-small_01"],
                          [SKTexture textureWithImageNamed:@"ship-small_02"],
                          [SKTexture textureWithImageNamed:@"ship-small_03"],
                          [SKTexture textureWithImageNamed:@"ship-small_04"]];
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    SKAction *animateRepeat = [SKAction repeatActionForever:animation];
    [spaceShip runAction:animateRepeat];
    spaceShip.position = position;
    [spaceShip setupPhysicsBody];
    spaceShip.name = @"spaceShip";
    return spaceShip;
}
-(void)setupPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryMeteorit;
    self.physicsBody.categoryBitMask = CollisionCategorySpaceShip;
}
    

@end
