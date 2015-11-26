//
//  GameScene.m
//  AsteroidRush
//
//  Created by George Sabanov on 02.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//

#import "GameScene.h"
#import "Physics.h"
#import "LaserNode.h"
#import "SpaceShipNode.h"
#import "MeteoritNode.h"
@import CoreMotion;

@interface GameScene ()
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;
@property (nonatomic) AVAudioPlayer* backgroundMusic;
@end

@implementation GameScene{
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
        NSURL* url = [[NSBundle mainBundle] URLForResource:@"backgroundSound" withExtension:@"mp3"];
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.backgroundMusic.numberOfLoops = -1;
        [self.backgroundMusic prepareToPlay];
        
        self.physicsWorld.contactDelegate = self;
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
        }
    
    return self;
}
-(void)addMeteor{
    if (lifesNumber > 0) {
        int i = spaceShip.frame.size.width;
        float pos = arc4random()%(320 - i/2 - i) + i/2;
        meteor = [MeteoritNode meteoritAtPosition:CGPointMake(pos + meteor.frame.size.width, self.view.frame.size.height + 2*meteor.frame.size.height )];
        
        SKAction *fallMeteor = [SKAction moveToY:-10*meteor.frame.size.height duration:1];
        
        [meteor runAction: fallMeteor];
        [self addChild:meteor];
    } if (lifesNumber <= 0) {
        return;
    }

    
}
-(void)didMoveToView:(SKView *)view{
    [self.backgroundMusic play];
}
-(void)updateScore{
    score.text = [NSString stringWithFormat:@"Score : %d",scoreInt];
    
    if (scoreInt == 1000) {
        score.position = CGPointMake(score.position.x - 10, score.position.y);
    }
    if (scoreInt == 10000) {
        score.position = CGPointMake(score.position.x - 10, score.position.y);
    }
    if (scoreInt == 100000) {
        score.position = CGPointMake(score.position.x - 10, score.position.y);
    }
    if (scoreInt == 1000000) {
        score.position = CGPointMake(score.position.x - 10, score.position.y);
    }
    
    for (SKNode* node in self.children) {
        if (node.position.y > self.frame.size.height - 5 && [node.name hasPrefix:@"laser"]) {
            [node removeFromParent];
        }
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
        scoreInt += 100;
        [self updateScore];
        
        
    } else if ( firstBody.categoryBitMask == CollisionCategoryMeteorit &&
               secondBody.categoryBitMask == CollisionCategorySpaceShip ) {

        lifesNumber -= 1;
        
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

-(void)willMoveFromView:(SKView *)view{
    [_backgroundMusic stop];
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
        }
        
        if ( self.timeSinceEnemyAdded > self.addEnemyTimeInterval ) {
            [self addMeteor];
            self.timeSinceEnemyAdded = 0;
        }
        
        self.lastUpdateTimeInterval = currentTime;
        
        if ( self.totalGameTime > 480 ) {
            // 480 / 60 = 8 minutes
            self.addEnemyTimeInterval = 0.30;
            
            
        } else if ( self.totalGameTime > 240 ) {
            // 240 / 60 = 4 minutes
            self.addEnemyTimeInterval = 0.35;
            
        } else if ( self.totalGameTime > 120 ) {
            // 120 / 60 = 2 minutes
            self.addEnemyTimeInterval = 0.40;
            
        } else if ( self.totalGameTime > 60 ) {
            self.addEnemyTimeInterval = 0.45;
            
        }
    
    
    ///////
    
    for (SKNode* node in self.children) {
        if (node.position.y > 600 && [node.name hasPrefix:@"laser"]) {
            [node removeFromParent];
        }
    }
    
    //////
}
- (void) reportHighScore:(NSInteger) highScore {
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        GKScore* highScoreBoard = [[GKScore alloc] initWithLeaderboardIdentifier:@"fastBoard"]; ////////////////////////////   NO @"fastBoard" ///////////////////////////
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
-(void)gameOver {
    SKAction *falling = [SKAction scaleBy:0.2 duration:1];
    SKAction *hide = [SKAction removeFromParent];

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
        
        [self addChild:GameOver];
        NSInteger highScore = [[[NSUserDefaults standardUserDefaults] objectForKey:@"highScoreFast"] intValue];
        if (scoreInt > highScore) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:scoreInt] forKey:@"highScoreFast"];
        }
        [self reportHighScore:[[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreFast"]];
        
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (lifesNumber > 0) {
        laser = [LaserNode laserAtPosition:spaceShip.position withEndPoint:CGPointMake(spaceShip.position.x, self.view.frame.size.height + 50)];
        SKAction* playSound = [SKAction playSoundFileNamed:@"laserSound.mp3" waitForCompletion:NO];
        [laser runAction:playSound];
        [self addChild:laser];
    } else {
         TitleScene *titleScene = [TitleScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:titleScene transition:transition];
    }

    
}



@end
