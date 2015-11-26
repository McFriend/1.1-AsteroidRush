//
//  ShopScene.m
//  AsteroidRush
//
//  Created by George Sabanov on 15.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//

#import "ShopScene.h"
#import "TitleScene.h"

@implementation ShopScene{
    SKLabelNode *back;
    SKSpriteNode *firePoints;
    SKLabelNode *firePointsIntLabel;
    SKSpriteNode *pointsImg;
    SKLabelNode *pointTotal;
    NSInteger *points;
    
    SKLabelNode *buyLaserPowerLabel;
    SKLabelNode *buyLaserPowerPrice;
    
    SKLabelNode *buyLaserPowerLabel2;
    SKLabelNode *buyLaserPowerPrice2;
    
    SKLabelNode *buyCoinsLabel;
    SKLabelNode *buyCoinsPrice;
    
    SKLabelNode *buyCoinsLabelx2;
    SKLabelNode *buyCoinsPricex2;
    
    SKLabelNode *buyCoinsLabelx3;
    SKLabelNode *buyCoinsPricex3;
    
    SKSpriteNode *spaceShipSkin;
    SKLabelNode *spaceShipPriceNode;
    
}
-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
       
        
        SKSpriteNode *backGround = [SKSpriteNode spriteNodeWithImageNamed:@"bg-stars_00"];
        NSArray *textures = @[[SKTexture textureWithImageNamed:@"bg-stars_00"],
                              [SKTexture textureWithImageNamed:@"bg-stars_01"],
                              [SKTexture textureWithImageNamed:@"bg-stars_02"],
                              [SKTexture textureWithImageNamed:@"bg-stars_03"],
                              [SKTexture textureWithImageNamed:@"bg-stars_04"],
                              [SKTexture textureWithImageNamed:@"bg-stars_05"],
                              [SKTexture textureWithImageNamed:@"bg-stars_06"],
                              [SKTexture textureWithImageNamed:@"bg-stars_07"],
                              [SKTexture textureWithImageNamed:@"bg-stars_08"],
                              [SKTexture textureWithImageNamed:@"bg-stars_09"],
                              [SKTexture textureWithImageNamed:@"bg-stars_10"],
                              [SKTexture textureWithImageNamed:@"bg-stars_11"],
                              [SKTexture textureWithImageNamed:@"bg-stars_12"],
                              [SKTexture textureWithImageNamed:@"bg-stars_13"],
                              [SKTexture textureWithImageNamed:@"bg-stars_14"],
                              [SKTexture textureWithImageNamed:@"bg-stars_15"],
                              [SKTexture textureWithImageNamed:@"bg-stars_16"],
                              [SKTexture textureWithImageNamed:@"bg-stars_17"],
                              [SKTexture textureWithImageNamed:@"bg-stars_18"],
                              ];
        
        SKAction *backgroundAnimation = [SKAction animateWithTextures:textures timePerFrame:0.02];
        
        SKAction *animationRepeat = [SKAction repeatActionForever:backgroundAnimation];
        [backGround runAction:animationRepeat];
        backGround.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:backGround];
        
        NSURL* url = [[NSBundle mainBundle] URLForResource:@"backgroundSound" withExtension:@"mp3"];
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.backgroundMusic.numberOfLoops = -1;
        [self.backgroundMusic prepareToPlay];

        pointsImg = [SKSpriteNode spriteNodeWithImageNamed:@"rock"];
        pointsImg.position = CGPointMake(2*(CGRectGetMidX(self.frame)) - pointsImg.frame.size.width/3*2, (CGRectGetHeight(self.frame)) - 20);
        pointsImg.size = CGSizeMake(25, 25);
        [self addChild:pointsImg];
        
        pointTotal = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
        pointTotal.fontSize = 22;
        
        points = [[NSUserDefaults standardUserDefaults] integerForKey:@"totalPoints"];
        
        pointTotal.text = [NSString stringWithFormat:@"%d", points];
        pointTotal.position = CGPointMake(pointsImg.position.x - pointTotal.frame.size.width - 5, pointsImg.position.y - 10);
        [self addChild:pointTotal];
        
        
        
        NSLog(@"%f, %f", pointTotal.position.x, pointTotal.position.y
              );
        firePointsIntLabel = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Regular"];
        firePointsIntLabel.text = [NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"firesLeft"]];
        firePointsIntLabel.position = CGPointMake(firePointsIntLabel.frame.size.width/2, pointTotal.position.y);
        firePointsIntLabel.fontSize = 22;
        
        [self addChild:firePointsIntLabel];
        firePoints = [SKSpriteNode spriteNodeWithImageNamed:@"Bullet"];
        firePoints.position = CGPointMake(firePointsIntLabel.position.x*2, pointTotal.position.y + 5);
        firePoints.xScale = 0.6;
        firePoints.yScale = 0.6;
        
        [self addChild: firePoints];
        
        buyLaserPowerLabel = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
        buyLaserPowerLabel.fontSize = 25;
        buyLaserPowerLabel.text = @"Buy Lasers";
        buyLaserPowerLabel.position = CGPointMake(5 + buyLaserPowerLabel.frame.size.width/2, CGRectGetMidY(self.frame) - 80);
        
        
        buyLaserPowerPrice = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
        buyLaserPowerPrice.fontSize = 25;
        buyLaserPowerPrice.text = @"5/50";
        buyLaserPowerPrice.position = CGPointMake(self.frame.size.width - buyLaserPowerPrice.frame.size.width/2 - 5, CGRectGetMidY(self.frame) - 80);
        buyLaserPowerPrice.name = @"priceLaser";
        buyLaserPowerLabel.name = @"labelLaser";
        
        
        
        buyLaserPowerLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
        buyLaserPowerLabel2.fontSize = 25;
        buyLaserPowerLabel2.text = @"Buy Lasers";
        buyLaserPowerLabel2.position = CGPointMake(5 + buyLaserPowerLabel2.frame.size.width/2, CGRectGetMidY(self.frame) - 110);
        
        
        buyLaserPowerPrice2 = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
        buyLaserPowerPrice2.fontSize = 25;
        buyLaserPowerPrice2.text = @"50/500";
        buyLaserPowerPrice2.position = CGPointMake(self.frame.size.width - buyLaserPowerPrice2.frame.size.width/2 - 5, CGRectGetMidY(self.frame) - 110);
        buyLaserPowerPrice2.name = @"priceLaser2";
        buyLaserPowerLabel2.name = @"labelLaser2";
        
        
        
        buyCoinsLabel = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
        buyCoinsLabel.fontSize = 25;
        buyCoinsLabel.text = @"Buy 2.5k coins";
        buyCoinsLabel.position = CGPointMake(5 + buyCoinsLabel.frame.size.width/2, buyLaserPowerLabel2.position.y - 50);
        
        [self addChild:buyCoinsLabel];
        buyCoinsPrice = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
        buyCoinsPrice.fontSize = 25;
        buyCoinsPrice.text = @"$0.99";
        buyCoinsPrice.position = CGPointMake(self.frame.size.width - buyCoinsPrice.frame.size.width/2 - 5, buyLaserPowerLabel2.position.y - 50);
        buyCoinsPrice.name = @"priceCoins";
        buyCoinsLabel.name = @"labelCoins";
        [self addChild:buyCoinsPrice];
        
        buyCoinsLabelx2 = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
        buyCoinsLabelx2.fontSize = 25;
        buyCoinsLabelx2.text = @"Buy 5k coins";
        buyCoinsLabelx2.position = CGPointMake(5 + buyCoinsLabelx2.frame.size.width/2, buyCoinsPrice.position.y - 30);
        
        [self addChild:buyCoinsLabelx2];
        buyCoinsPricex2 = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
        buyCoinsPricex2.fontSize = 25;
        buyCoinsPricex2.text = @"$1.99";
        buyCoinsPricex2.position = CGPointMake(self.frame.size.width - buyCoinsPricex2.frame.size.width/2 - 5, buyCoinsPrice.position.y - 30);
        buyCoinsPricex2.name = @"priceCoins2";
        buyCoinsLabelx2.name = @"labelCoins2";
        [self addChild:buyCoinsPricex2];
        
        buyCoinsLabelx3 = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
        buyCoinsLabelx3.fontSize = 25;
        buyCoinsLabelx3.text = @"Buy 15k coins";
        buyCoinsLabelx3.position = CGPointMake(5 + buyCoinsLabelx3.frame.size.width/2, buyCoinsPricex2.position.y - 30);
        
        [self addChild:buyCoinsLabelx3];
        buyCoinsPricex3 = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
        buyCoinsPricex3.fontSize = 25;
        buyCoinsPricex3.text = @"$2.99";
        buyCoinsPricex3.position = CGPointMake(self.frame.size.width - buyCoinsPricex3.frame.size.width/2 - 5, buyCoinsPricex2.position.y - 30);
        buyCoinsPricex3.name = @"priceCoins3";
        buyCoinsLabelx3.name = @"labelCoins3";
        [self addChild:buyCoinsPricex3];
        
        spaceShipSkin = [SKSpriteNode spriteNodeWithImageNamed:@"ship-morph0040"];
        spaceShipSkin.position = CGPointMake(CGRectGetMidX(self.frame) , CGRectGetMaxY(self.frame)*0.75);
        [self addChild:spaceShipSkin];
        [self addChild:buyLaserPowerLabel];
        [self addChild:buyLaserPowerPrice];
        [self addChild:buyLaserPowerLabel2];
        [self addChild:buyLaserPowerPrice2];
    }
    return self;
}
-(void)didBuyPoints:(NSInteger)points{
    NSInteger pointsBefore = [[NSUserDefaults standardUserDefaults] integerForKey:@"totalPoints"];
    pointsBefore += points;
    [[NSUserDefaults standardUserDefaults] setInteger:pointsBefore forKey:@"totalPoints"];
    pointTotal.text = [NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"totalPoints"]];
    pointTotal.position = CGPointMake(pointsImg.position.x - pointTotal.frame.size.width - 5, pointsImg.position.y - 10);

}
-(void)addFiresCount:(int)addFires andPrice:(int)price{
    
    NSInteger firesLeft = [[NSUserDefaults standardUserDefaults] integerForKey:@"firesLeft"];
   
    NSInteger pointsBefore = [[NSUserDefaults standardUserDefaults] integerForKey:@"totalPoints"];
    if (pointsBefore < price) {
        return;
    }else if(pointsBefore >= price){
        pointsBefore -= price;
        firesLeft += addFires;
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:firesLeft forKey:@"firesLeft"];
    [[NSUserDefaults standardUserDefaults] setInteger:pointsBefore forKey:@"totalPoints"];
    pointTotal.text = [NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"totalPoints"]];
    firePointsIntLabel.text = [NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"firesLeft"]];
}
-(void)didMoveToView:(SKView *)view{
    [self.backgroundMusic play];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    if ([node.name isEqualToString:@"priceLaser"] || [node.name isEqualToString:@"labelLaser"] ) {
        [self addFiresCount:5 andPrice:50];
        firePointsIntLabel.position = CGPointMake(firePointsIntLabel.frame.size.width/2, pointTotal.position.y);
        firePoints.position = CGPointMake(firePointsIntLabel.position.x*2, pointTotal.position.y + 5);
    }
    else if ([node.name isEqualToString:@"priceLaser2"] || [node.name isEqualToString:@"labelLaser2"] ) {
        
        [self addFiresCount:50 andPrice:500];
        firePointsIntLabel.position = CGPointMake(firePointsIntLabel.frame.size.width/2, pointTotal.position.y);
        firePoints.position = CGPointMake(firePointsIntLabel.position.x*2, pointTotal.position.y + 5);
    }
    else if ([node.name isEqualToString:@"priceCoins"] || [node.name isEqualToString:@"labelCoins"] ) {

        NSURL *url = [[NSBundle mainBundle] URLForResource:@"ProductIDs"
                                             withExtension:@"plist"];
        NSArray *productIdentifiers = [NSArray arrayWithContentsOfURL:url];
        NSSet* productsSet = [NSSet setWithArray:productIdentifiers];
        [[SCPStoreKitManager sharedInstance] requestProductsWithIdentifiers:productsSet
                                               productsReturnedSuccessfully:^(NSArray *products) {
                                                   NSLog(@"Products : %@", products);
                                                   [[SCPStoreKitManager sharedInstance] requestPaymentForProduct:products[0]
                                                                               paymentTransactionStatePurchasing:^(NSArray *transactions) {
                                                                                   NSLog(@"Purchasing products : %@", transactions);
                                                                               }
                                                                                paymentTransactionStatePurchased:^(NSArray *transactions) {
                                                                                    NSLog(@"Purchased products : %@", transactions);
                                                                                    [self didBuyPoints:2500];
                                                                                    
                                                                                    NSLog(@"Funds added :)");
                                                                                }
                                                                                   paymentTransactionStateFailed:^(NSArray *transactions) {
                                                                                       NSLog(@"Failed products : %@", transactions);
                                                                                   }
                                                                                 paymentTransactionStateRestored:^(NSArray *transactions) {
                                                                                     NSLog(@"Restored products : %@", transactions);
                                                                                 }
                                                                                                         failure:^(NSError *error) {
                                                                                                             NSLog(@"Failure : %@", [error localizedDescription]);
                                                                                                         }];
                                                   
                                                   
                                               }
                                                            invalidProducts:^(NSArray *invalidProducts) {
                                                                NSLog(@"Invalid Products : %@", invalidProducts);
                                                            }
                                                                    failure:^(NSError *error) {
                                                                        NSLog(@"Error : %@", [error localizedDescription]);
                                                                    }];

    }
    else if ([node.name isEqualToString:@"priceCoins2"] || [node.name isEqualToString:@"labelCoins2"] ) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"ProductIDs"
                                             withExtension:@"plist"];
        NSArray *productIdentifiers = [NSArray arrayWithContentsOfURL:url];
        NSSet* productsSet = [NSSet setWithArray:productIdentifiers];
        [[SCPStoreKitManager sharedInstance] requestProductsWithIdentifiers:productsSet
                                               productsReturnedSuccessfully:^(NSArray *products) {
                                                   NSLog(@"Products : %@", products);
                                                   [[SCPStoreKitManager sharedInstance] requestPaymentForProduct:products[1]
                                                                               paymentTransactionStatePurchasing:^(NSArray *transactions) {
                                                                                   NSLog(@"Purchasing products : %@", transactions);
                                                                               }
                                                                                paymentTransactionStatePurchased:^(NSArray *transactions) {
                                                                                    NSLog(@"Purchased products : %@", transactions);
                                                                                    [self didBuyPoints:5000];
                                                                                    
                                                                                    NSLog(@"Funds added :)");
                                                                                }
                                                                                   paymentTransactionStateFailed:^(NSArray *transactions) {
                                                                                       NSLog(@"Failed products : %@", transactions);
                                                                                   }
                                                                                 paymentTransactionStateRestored:^(NSArray *transactions) {
                                                                                     NSLog(@"Restored products : %@", transactions);
                                                                                 }
                                                                                                         failure:^(NSError *error) {
                                                                                                             NSLog(@"Failure : %@", [error localizedDescription]);
                                                                                                         }];
                                                   
                                                   
                                               }
                                                            invalidProducts:^(NSArray *invalidProducts) {
                                                                NSLog(@"Invalid Products : %@", invalidProducts);
                                                            }
                                                                    failure:^(NSError *error) {
                                                                        NSLog(@"Error : %@", [error localizedDescription]);
                                                                    }];
        
    }
    else if ([node.name isEqualToString:@"priceCoins3"] || [node.name isEqualToString:@"labelCoins3"] ) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"ProductIDs"
                                             withExtension:@"plist"];
        NSArray *productIdentifiers = [NSArray arrayWithContentsOfURL:url];
        NSSet* productsSet = [NSSet setWithArray:productIdentifiers];
        [[SCPStoreKitManager sharedInstance] requestProductsWithIdentifiers:productsSet
                                               productsReturnedSuccessfully:^(NSArray *products) {
                                                   NSLog(@"Products : %@", products);
                                                   [[SCPStoreKitManager sharedInstance] requestPaymentForProduct:products[2]
                                                                               paymentTransactionStatePurchasing:^(NSArray *transactions) {
                                                                                   NSLog(@"Purchasing products : %@", transactions);
                                                                               }
                                                                                paymentTransactionStatePurchased:^(NSArray *transactions) {
                                                                                    NSLog(@"Purchased products : %@", transactions);
                                                                                    [self didBuyPoints:15000];
                                                                                    
                                                                                    NSLog(@"Funds added :)");
                                                                                }
                                                                                   paymentTransactionStateFailed:^(NSArray *transactions) {
                                                                                       NSLog(@"Failed products : %@", transactions);
                                                                                   }
                                                                                 paymentTransactionStateRestored:^(NSArray *transactions) {
                                                                                     NSLog(@"Restored products : %@", transactions);
                                                                                 }
                                                                                                         failure:^(NSError *error) {
                                                                                                             NSLog(@"Failure : %@", [error localizedDescription]);
                                                                                                         }];
                                                   
                                                   
                                               }
                                                            invalidProducts:^(NSArray *invalidProducts) {
                                                                NSLog(@"Invalid Products : %@", invalidProducts);
                                                            }
                                                                    failure:^(NSError *error) {
                                                                        NSLog(@"Error : %@", [error localizedDescription]);
                                                                    }];
        
    }
    else {
        [self gotoTitle];
        NSLog(@"Nothing Tapped , but %@", node.name);
        
    }
    
}
-(void)willMoveFromView:(SKView *)view{
    [_backgroundMusic stop];
}
-(void)gotoTitle{
    TitleScene *titleScene = [TitleScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:0.5];
    [self.view presentScene:titleScene transition:transition];
    
}
@end
