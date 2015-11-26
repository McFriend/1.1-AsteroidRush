//
//  ArcadeScene.m
//  AsteroidRush
//
//  Created by George Sabanov on 11.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//

#import "ArcadeScene.h"
#import "Physics.h"
#import "LaserNode.h"
#import "SpaceShipNode.h"
#import "MeteoritNode.h"
@import CoreMotion;

@interface ArcadeScene ()
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;
@property (nonatomic) AVAudioPlayer* backgroundMusic;
@property (nonatomic) NSTimeInterval reloadingTime;
@property (nonatomic) int fireInt;//
@property (nonatomic) float scoreStartingWidth;

@end

@implementation ArcadeScene{
    
    SpaceShipNode *spaceShip;
    CMMotionManager *_motionManager;
    MeteoritNode *meteor;
    LaserNode *laser;
    int scoreInt;
    SKLabelNode *score;
    int lifesNumber;
    SKSpriteNode* life1;
    SKSpriteNode* life2;
    SKSpriteNode* life3;
    SKLabelNode* fireNumberLabel;//
    SKSpriteNode* bulletsNode;
    SKSpriteNode* bulletsNode2;
    SKSpriteNode* bulletsNode3;
    SKSpriteNode* bulletsNode4;
    SKSpriteNode* bulletsNode5;
    BOOL isGameEnd;
    int firedTimesBeforeReloading;
    BOOL reloading;

}



-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.lastUpdateTimeInterval = 0;
        self.timeSinceEnemyAdded = 0;
        self.addEnemyTimeInterval = 0.5;
        self.totalGameTime = 0;
        scoreInt = 0;
        lifesNumber = 3;
        int firesLeft = [[NSUserDefaults standardUserDefaults] integerForKey:@"firesLeft"];
        _fireInt = firesLeft;
        NSURL* url = [[NSBundle mainBundle] URLForResource:@"backgroundSound" withExtension:@"mp3"];
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.backgroundMusic.numberOfLoops = -1;
        [self.backgroundMusic prepareToPlay];
        self.physicsWorld.contactDelegate = self;
        bulletsNode5 = [SKSpriteNode spriteNodeWithImageNamed:@"Bullet"];
        bulletsNode4 = [SKSpriteNode spriteNodeWithImageNamed:@"Bullet"];
        bulletsNode3 = [SKSpriteNode spriteNodeWithImageNamed:@"Bullet"];
        bulletsNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"Bullet"];
        bulletsNode = [SKSpriteNode spriteNodeWithImageNamed:@"Bullet"];

 //       _fireInt = @([[NSUserDefaults alloc] integerForKey:@"firesLeft"]).intValue;
        
        SKSpriteNode *backGroundNode = [SKSpriteNode spriteNodeWithImageNamed:@"bg-stars_00"];
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
                              [SKTexture textureWithImageNamed:@"bg-stars_18"]];
        score = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Regular"];
        score.text = [NSString stringWithFormat:@"Score : %d",scoreInt];
        score.fontSize = 20;
        life1 = [SKSpriteNode spriteNodeWithImageNamed:@"life"];
        life2 = [SKSpriteNode spriteNodeWithImageNamed:@"life"];
        life3 = [SKSpriteNode spriteNodeWithImageNamed:@"life"];
        life3.position = CGPointMake(5*(life3.frame.size.width), 2*(CGRectGetMidY(self.frame)) - life3.frame.size.height );
        life2.position = CGPointMake(life3.position.x - life2.frame.size.width*2, life3.position.y);
        life1.position = CGPointMake(life2.position.x - life3.frame.size.width*2, life3.position.y);
        SKAction *backgroundAnimation = [SKAction animateWithTextures:textures timePerFrame:0.02];
        score.position = CGPointMake(2*(CGRectGetMidX(self.frame)) - score.frame.size.width/3*2,life3.position.y - 10);
        SKAction *animationRepeat = [SKAction repeatActionForever:backgroundAnimation];
        [backGroundNode runAction:animationRepeat];
        backGroundNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:backGroundNode];
        
        bulletsNode5.position = CGPointMake(10*(bulletsNode.frame.size.width),life3.position.y - bulletsNode.frame.size.height - 10);
        bulletsNode4.position = CGPointMake(bulletsNode5.position.x - bulletsNode5.frame.size.width*2, bulletsNode5.position.y);
        bulletsNode3.position = CGPointMake(bulletsNode4.position.x - bulletsNode5.frame.size.width*2, bulletsNode5.position.y);
        bulletsNode2.position = CGPointMake(bulletsNode3.position.x - bulletsNode5.frame.size.width*2, bulletsNode5.position.y);
        bulletsNode.position = CGPointMake(bulletsNode2.position.x - bulletsNode5.frame.size.width*2, bulletsNode5.position.y);
        bulletsNode.xScale = 0.5;
        bulletsNode2.xScale = 0.5;
        bulletsNode3.xScale = 0.5;
        bulletsNode4.xScale = 0.5;
        bulletsNode5.xScale = 0.5;
        bulletsNode.yScale  = 0.7;
        bulletsNode2.yScale = 0.7;
        bulletsNode3.yScale = 0.7;
        bulletsNode4.yScale = 0.7;
        bulletsNode5.yScale = 0.7;
        fireNumberLabel = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Regular"];
        fireNumberLabel.fontSize = 20;
        fireNumberLabel.text = [NSString stringWithFormat:@"%d", _fireInt];
        fireNumberLabel.alpha = 0.6;
        fireNumberLabel.position = CGPointMake(fireNumberLabel.frame.size.width/2 + 5, bulletsNode5.position.y - fireNumberLabel.frame.size.height*2);
        
        
        spaceShip = [SpaceShipNode spaceShipAtPosition:CGPointMake(CGRectGetMidX(self.frame), spaceShip.frame.size.height + 100)];
        [self addChild:spaceShip];
        
        _motionManager = [[CMMotionManager alloc]init];
        [self startMonitoringAcceleration];
        
        life3.zPosition = 9;
        life2.zPosition = 9;
        life1.zPosition = 9;
        score.zPosition = 9;
        
        [self addChild:life3];
        [self addChild:life2];
        [self addChild:life1];
        [self addChild:score];
        [self addChild:bulletsNode5];
        [self addChild:bulletsNode4];
        [self addChild:bulletsNode3];
        [self addChild:bulletsNode2];
        [self addChild:bulletsNode];
        [self addChild:fireNumberLabel];
        NSLog(@"%f", bulletsNode5.position.y);
        self.scoreStartingWidth = score.frame.size.width;
    }
    
    return self;
}
-(void)addMeteor{
    if (lifesNumber > 0) {
        int i = meteor.frame.size.width;
        float pos = arc4random()%(320 - i) + 0.5*i;
        meteor = [MeteoritNode meteoritAtPosition:CGPointMake(pos, self.view.frame.size.height + 1*meteor.frame.size.height)];
        
        SKAction *fallMeteor = [SKAction moveToY:-10*meteor.frame.size.height duration:1];
        
        [meteor runAction: fallMeteor];
        [self addChild:meteor];
    } if (lifesNumber == 0) {
        return;
    }
    
    
}
-(void)didMoveToView:(SKView *)view{
    [self.backgroundMusic play];
}
-(void)updateScore{
    if (!isGameEnd) {
       score.text = [NSString stringWithFormat:@"Score : %d",scoreInt];
    }
    
    
    if (scoreInt == 1000) {
        score.position = CGPointMake(score.position.x - score.frame.size.width + self.scoreStartingWidth , score.position.y);
    }
    if (scoreInt == 10000) {
        score.position = CGPointMake(score.position.x - score.frame.size.width + self.scoreStartingWidth , score.position.y);
    }
    if (scoreInt == 100000) {
        score.position = CGPointMake(score.position.x - score.frame.size.width + self.scoreStartingWidth , score.position.y);
    }
    if (scoreInt == 1000000) {
        score.position = CGPointMake(score.position.x - score.frame.size.width + self.scoreStartingWidth , score.position.y);
    }
    
}

- (void)startMonitoringAcceleration
{
    if (_motionManager.accelerometerAvailable) {
        [_motionManager startAccelerometerUpdates];
        // NSLog(@"accelerometer updates on...");
        
    }
}

- (void)stopMonitoringAcceleration
{
    if (_motionManager.accelerometerAvailable && _motionManager.accelerometerActive) {
        [_motionManager stopAccelerometerUpdates];
        //NSLog(@"accelerometer updates off...");
    }
}





- (void)updateShipPositionFromMotionManager
{
    CMAccelerometerData* data = _motionManager.accelerometerData;
    if (fabs(data.acceleration.x) > 0.01) {
        //  NSLog(@"acceleration value = %f",data.acceleration.x);
        if (data.acceleration.x < 0) {
            if (!(spaceShip.position.x < spaceShip.frame.size.width/1.5))  {
                spaceShip.position = CGPointMake(spaceShip.position.x + 25*data.acceleration.x, spaceShip.position.y);
            }
        }
        if (data.acceleration.x > 0) {
            if (!(spaceShip.position.x > self.view.frame.size.width - spaceShip.frame.size.width/1.5)) {
                spaceShip.position = CGPointMake(spaceShip.position.x + 25*data.acceleration.x, spaceShip.position.y);
            }
        }
    }
}

- (void) didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask ) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    
    if ( firstBody.categoryBitMask == CollisionCategoryMeteorit &&
        secondBody.categoryBitMask == CollisionCategoryLaser ) {
        
        
        MeteoritNode *meteorBody = (MeteoritNode *)firstBody.node;
        LaserNode *laserBody = (LaserNode*)secondBody.node;
        
        [meteorBody removeFromParent];
        [laserBody removeFromParent];
        [self createDebrisAtPosition:contact.contactPoint];
        //  [self addMeteor];
        
        
        
    } else if ( firstBody.categoryBitMask == CollisionCategoryMeteorit &&
               secondBody.categoryBitMask == CollisionCategorySpaceShip ) {
        
        lifesNumber --;
        
        MeteoritNode *meteorBody = (MeteoritNode *)firstBody.node;
        [meteorBody removeFromParent];
        [self createDebrisAtPosition:contact.contactPoint];
        SKAction* soundAction = [SKAction playSoundFileNamed:@"contactSound.wav" waitForCompletion:NO];
        if (lifesNumber == 2) {
            life3.hidden = YES;
            [spaceShip runAction:soundAction];
            
        }
        if (lifesNumber == 1) {
            life2.hidden = YES;
            [spaceShip runAction:soundAction];
        }
        if (lifesNumber == 0) {
            life1.hidden = YES;
            [spaceShip runAction:soundAction];
            [self gameOver];
        }
        //[self addMeteor];
        
    }
    
    
}


- (void) createDebrisAtPosition:(CGPoint)position {
    NSInteger numberOfPieces = [Physics randomWithMin:5 max:20];
    
    
    for (int i=0; i < numberOfPieces; i++) {
        NSInteger randomPiece = [Physics randomWithMin:1 max:9];
        NSString *imageName = [NSString stringWithFormat:@"debris_0%ld",(long)randomPiece];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debris.position = position;
        [self addChild:debris];
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = CollisionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = CollisionCategorySpaceShip | CollisionCategoryDebris;
        debris.name = @"Debris";
        
        debris.physicsBody.velocity = CGVectorMake([Physics randomWithMin:-150 max:150],
                                                   [Physics randomWithMin:150 max:350]);
        
        [debris runAction:[SKAction waitForDuration:2.0] completion:^{
            [debris removeFromParent];
        }];
        
    }
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    [self updateShipPositionFromMotionManager];
    
    if ( self.lastUpdateTimeInterval ) {
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
        if (lifesNumber > 0) {
        scoreInt = @(self.totalGameTime).intValue*10;
        [self updateScore];
        }


    }
    if (firedTimesBeforeReloading == 10 ) {
        bulletsNode.alpha = 0;
    }
    if (firedTimesBeforeReloading == 9) {
        bulletsNode.alpha = 0.5;
    }
    if (firedTimesBeforeReloading == 8) {
        bulletsNode2.alpha = 0;
    }
    if (firedTimesBeforeReloading == 7) {
        bulletsNode2.alpha = 0.5;
    }
    if (firedTimesBeforeReloading == 6) {
        bulletsNode3.alpha = 0;
    }
    if (firedTimesBeforeReloading == 5) {
        bulletsNode3.alpha = 0.5;
    }
    if (firedTimesBeforeReloading == 4) {
        bulletsNode4.alpha = 0;
    }
    if (firedTimesBeforeReloading == 3) {
        bulletsNode4.alpha = 0.5;
    }
    if (firedTimesBeforeReloading == 2) {
        bulletsNode5.alpha = 0;
    }
    if (firedTimesBeforeReloading == 1) {
        bulletsNode5.alpha = 0.5;
    }
    if (firedTimesBeforeReloading == 0 && !reloading) {
        [bulletsNode5 removeAllActions];
        [bulletsNode4 removeAllActions];
        [bulletsNode3 removeAllActions];
        [bulletsNode2 removeAllActions];
        [bulletsNode removeAllActions];
        bulletsNode5.alpha = 1;
        bulletsNode4.alpha = 1;
        bulletsNode3.alpha = 1;
        bulletsNode2.alpha = 1;
        bulletsNode.alpha = 1;
    }

    
    if (!reloading) {
        if (firedTimesBeforeReloading == 10) {
            reloading = YES;
            if (_fireInt > 10) {
                firedTimesBeforeReloading = 0;
                
            }
            if (_fireInt <= 10 && _fireInt > 0) {
                firedTimesBeforeReloading = 10 - _fireInt;
                
            }
            if (_fireInt == 0) {
                reloading = NO;
            }
            self.reloadingTime = 0;
            SKAction* reloadAction = [SKAction fadeAlphaTo:0.5 duration:0.2];
            SKAction* reloadOutAction = [SKAction fadeAlphaTo:1.0 duration:0.2];
            SKAction* reloadAnimation = [SKAction sequence:@[reloadAction, reloadOutAction]];
            [bulletsNode5 runAction:[SKAction repeatActionForever:reloadAnimation]];
            [bulletsNode4 runAction:[SKAction repeatActionForever:reloadAnimation]];
            [bulletsNode3 runAction:[SKAction repeatActionForever:reloadAnimation]];
            [bulletsNode2 runAction:[SKAction repeatActionForever:reloadAnimation]];
            [bulletsNode runAction:[SKAction repeatActionForever:reloadAnimation]];
        }
        if (_fireInt == 0) {
            bulletsNode5.alpha = 0.1;
            bulletsNode4.alpha = 0.1;
            bulletsNode3.alpha = 0.1;
            bulletsNode2.alpha = 0.1;
            bulletsNode.alpha = 0.1;
        }
    }
    if (reloading) {
        self.reloadingTime += currentTime - self.lastUpdateTimeInterval;
        NSLog(@"%f", self.reloadingTime);
        
    }
    if (self.reloadingTime >= 3.5) {
        
        reloading = NO;

    }
    
    if ( self.timeSinceEnemyAdded > self.addEnemyTimeInterval ) {
        [self addMeteor];
        self.timeSinceEnemyAdded = 0;
    }
    
    self.lastUpdateTimeInterval = currentTime;
    
    if ( self.totalGameTime > 480 ) {
        // 480 / 60 = 8 minutes
        self.addEnemyTimeInterval = 0.10;
        
        
    } else if ( self.totalGameTime > 240 ) {
        // 240 / 60 = 4 minutes
        self.addEnemyTimeInterval = 0.25;
        
    } else if ( self.totalGameTime > 120 ) {
        // 120 / 60 = 2 minutes
        self.addEnemyTimeInterval = 0.30;
        
    } else if ( self.totalGameTime > 60 ) {
        self.addEnemyTimeInterval = 0.35;
        
    }
    
    
    ///////
    
    for (SKNode* node in self.children) {
        if (node.position.y > self.frame.size.height - 5 && [node.name hasPrefix:@"laser"]) {
            [node removeFromParent];
            NSLog(@"Removed");
        }
    }
    
    //////
}

-(void)gameOver {
    SKAction *falling = [SKAction scaleBy:0.2 duration:1];
    SKAction *hide = [SKAction hide];
    
    SKAction *gameOver = [SKAction sequence:@[falling, hide]];
    [spaceShip runAction:gameOver completion:^{
        
        SKLabelNode *GameOver = [SKLabelNode labelNodeWithFontNamed:@"Orbitron-Black"];
        GameOver.fontSize = 36;
        GameOver.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(GameOver.position.x,GameOver.position.y - 50 , 75, 35)];
        back.titleLabel.font = [UIFont fontWithName:@"Orbitron-Regular" size:20];
        GameOver.zPosition = 9;
        GameOver.text = @"Game Over";
        SKAction* playSound = [SKAction playSoundFileNamed:@"gameoverSound.wav" waitForCompletion:YES];
        [self runAction:playSound];
        [bulletsNode5 removeFromParent];
        [bulletsNode4 removeFromParent];
        [bulletsNode3 removeFromParent];
        [bulletsNode2 removeFromParent];
        [bulletsNode removeFromParent];
        [fireNumberLabel removeFromParent];
        SKAction *scoreAction = [SKAction moveTo:CGPointMake(GameOver.position.x, GameOver.position.y - 60) duration:0];
        [self addChild:GameOver];
        [score runAction:scoreAction];
        NSInteger highScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"] intValue];
        int pointsBefore = @([[NSUserDefaults standardUserDefaults] integerForKey:@"totalPoints"]).intValue;
        int pointsAfter = scoreInt + pointsBefore;
        [[NSUserDefaults standardUserDefaults] setInteger:_fireInt forKey:@"firesLeft"];
        [[NSUserDefaults standardUserDefaults] setInteger:pointsAfter forKey:@"totalPoints"];
        
        if (scoreInt > highScore) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:scoreInt] forKey:@"highScore"];
            NSLog(@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"]);
            
        }
        [self reportHighScore:[[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"]];
        
    }];

    
}
- (void) reportHighScore:(NSInteger) highScore {
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        GKScore* highScoreBoard = [[GKScore alloc] initWithLeaderboardIdentifier:@"arcadeBoard"];
        highScoreBoard.value = highScore;
        [GKScore reportScores:@[highScoreBoard] withCompletionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"Error : %@", error);
            }
            if (!error) {
                NSLog(@"Succesfully submited score : %lld", highScoreBoard.value);
                
            }
        }];
    }
}
-(void)willMoveFromView:(SKView *)view{
    [_backgroundMusic stop];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    if (!reloading) {
        if (lifesNumber > 0 && _fireInt > 0) {
        laser = [LaserNode laserAtPosition:spaceShip.position withEndPoint:CGPointMake(spaceShip.position.x, self.view.frame.size.height + 50)];
        SKAction* playSound = [SKAction playSoundFileNamed:@"laserSound.mp3" waitForCompletion:NO];
        [laser runAction:playSound];
        [self addChild:laser];
        NSLog(@"fireint = %d", _fireInt);
        firedTimesBeforeReloading ++;
        _fireInt --;
        fireNumberLabel.position = CGPointMake(fireNumberLabel.frame.size.width/2 + 5, bulletsNode5.position.y - fireNumberLabel.frame.size.height*2);

        }
    }
    if (lifesNumber <= 0) {
            TitleScene *titleScene = [TitleScene sceneWithSize:self.frame.size];
            SKTransition *transition = [SKTransition fadeWithDuration:1.0];
            [self.view presentScene:titleScene transition:transition];
        }

    if (reloading) {
        NSLog(@"Reloading");
    }
    fireNumberLabel.text = [NSString stringWithFormat:@"%d",_fireInt];
    NSLog(@"%f, %f",fireNumberLabel.position.x,fireNumberLabel.position.y);
}



@end

