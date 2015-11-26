//
//  TitleScene.m
//  AsteroidRush
//
//  Created by George Sabanov on 02.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//

#import "TitleScene.h"
#import "GameScene.h"
#import "ArcadeScene.h"
#import "ShopScene.h"
#import <GameKit/GameKit.h>
@implementation TitleScene{
    SKSpriteNode *titleShip;
    SKLabelNode *arcadeGameButtonLabel;
    SKLabelNode *simpleGameButtonLabel;
    SKLabelNode *gameCenterButtonLabel;
    SKLabelNode *shopButtonLabel;
    SKSpriteNode *firePoints;
    SKLabelNode *firePointsIntLabel;
    SKLabelNode *start;
    SKSpriteNode *pointsImg;
    SKLabelNode *pointTotal;
    NSInteger *points;
    
    
}
-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
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

        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
            if (error == nil) {
                NSLog(@"Authentication Successful");
            }
            else {
                NSLog(@"Authentication Failed with Error : %@", error);
            }
        }];

        
        SKLabelNode *title = [[SKLabelNode alloc] init];
        title.fontSize = 36;
        title.color = [UIColor whiteColor];
        title.fontName = @"Orbitron-Medium";
        title.text = @"Asteroid Rush";
        title.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 3*title.frame.size.height);
        
        [self addChild:title];
        
//        highScore = [[SKLabelNode alloc] init];
//        highScore.fontSize = 20;
//        highScore.color = [UIColor whiteColor];
//        highScore.fontName = @"Orbitron-Medium";
//        highScore.text = [NSString stringWithFormat:@"High Score is : %d",  [[[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"] intValue]];
//        highScore.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 180);
        
//        [self addChild:highScore];
        start = [[SKLabelNode alloc] init];
        start.fontSize = 16;
        start.color = [UIColor whiteColor];
        start.fontName = @"Orbitron-Medium";
        start.text = @"Tap anywhere to start";
        start.position = CGPointMake(CGRectGetMidX(self.frame), start.frame.size.height + 10);
        
        [self addChild:start];
        
        titleShip = [SKSpriteNode spriteNodeWithImageNamed:@"ship-morph0001"];
        NSArray *texturesMorph = @[[SKTexture textureWithImageNamed:@"ship-morph0001"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0002"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0003"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0004"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0005"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0006"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0007"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0008"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0009"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0010"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0021"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0022"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0023"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0024"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0025"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0026"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0027"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0028"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0029"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0030"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0031"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0032"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0033"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0034"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0035"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0036"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0037"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0038"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0039"],
                                   [SKTexture textureWithImageNamed:@"ship-morph0040"],
                                   ];
        
        SKAction *morphAnimation = [SKAction animateWithTextures:texturesMorph timePerFrame:0.02];
        [titleShip runAction:morphAnimation];
        titleShip.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 30);
        
        [self addChild:titleShip];
        


    }
    return self;
}
-(void)didMoveToView:(SKView *)view{
    [self.backgroundMusic play];
}
/*
- (SKSpriteNode *)settingsButtonNode
{
  //  UIImage *settingsIMG = [UIImage imageNamed:@"settings"];
    SKSpriteNode *settingsNode = [SKSpriteNode spriteNodeWithImageNamed:@"setting"];
    settingsNode.position = CGPointMake(self.frame.size.width - 30, self.frame.size.height - 30);
    settingsNode.name = @"settings";//how the node is identified later
    settingsNode.zPosition = 9.0;
    SKAction *scale = [SKAction scaleBy:0.14 duration:0];
    [settingsNode runAction:scale];
    SKAction *rotateSettings = [SKAction rotateByAngle:45 duration:1];
    SKAction *rotatForever = [SKAction repeatActionForever:rotateSettings];
    [settingsNode runAction:rotatForever];
    
    return settingsNode;
}
*/
-(void)willMoveFromView:(SKView *)view{
    [_backgroundMusic stop];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
                        //    IF NEED TO GET TAPPED LOCATION
    //UITouch *touch = [touches anyObject];
    //CGPoint location = [touch locationInNode:self];
    //SKNode *node = [self nodeAtPoint:location];
///////////////////////////////////////////////////////////////////////////////////////////////////
    if (titleShip.position.y ==  CGRectGetMidY(self.frame) + 30) {
        SKAction *moveSpaceShip = [SKAction moveToY: self.frame.size.height + titleShip.size.height/2 duration:0.3];
        
        [titleShip runAction:moveSpaceShip completion:^{
        
            arcadeGameButtonLabel = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
            simpleGameButtonLabel = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
            gameCenterButtonLabel = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
            shopButtonLabel = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Medium"];
            shopButtonLabel.text = @"Shop";
            arcadeGameButtonLabel.text = @"Arcade Mode";
            simpleGameButtonLabel.text = @"Fast Play Mode";
            gameCenterButtonLabel.text = @"Scores";
            
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
            arcadeGameButtonLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 60);
            simpleGameButtonLabel.position = CGPointMake(arcadeGameButtonLabel.position.x,arcadeGameButtonLabel.position.y - 100);
            gameCenterButtonLabel.position = CGPointMake(arcadeGameButtonLabel.position.x, start.position.y);
            shopButtonLabel.position = CGPointMake(gameCenterButtonLabel.position.x, gameCenterButtonLabel.position.y + gameCenterButtonLabel.frame.size.height + 20);
            arcadeGameButtonLabel.name = @"arcade";
            simpleGameButtonLabel.name = @"simple";
            gameCenterButtonLabel.name = @"scoreButton";
            shopButtonLabel.name = @"shop";
            [self addChild:arcadeGameButtonLabel];
            [self addChild:simpleGameButtonLabel];
            [self addChild:gameCenterButtonLabel];
            [self addChild:shopButtonLabel];
            
//            [highScore removeFromParent];
            [start removeFromParent];
        }];
}   else
    {

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
        if ([node.name isEqualToString:@"arcade"]) {
            [self gotoArcade];
        }
        if ([node.name isEqualToString:@"simple"]) {
            [self gotoGame];
        }
        if ([node.name isEqualToString:@"scoreButton"]) {
            [self showGameCenter];
        }
        if ([node.name isEqualToString:@"shop"]) {
            [self gotoShop];
        }
    }
}
- (void) showGameCenter
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
        UIViewController *vc = self.view.window.rootViewController;
//        gameCenterController.gameCenterDelegate = (id)vc;
        [vc presentViewController: gameCenterController animated:YES completion:Nil];


    }
}
-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)gotoGame{
    GameScene *gamePlayScene = [GameScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:0.5];
    [self.view presentScene:gamePlayScene transition:transition];

}
-(void)gotoShop{
    ShopScene *shopScene = [ShopScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:0.5];
    [self.view presentScene:shopScene transition:transition];
    
}

-(void)gotoArcade{
    ArcadeScene *arcadePlayScene = [ArcadeScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:0.5];
    [self.view presentScene:arcadePlayScene transition:transition];
    
}



@end