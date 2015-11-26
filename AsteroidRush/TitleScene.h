//
//  TitleScene.h
//  AsteroidRush
//
//  Created by George Sabanov on 02.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>
@interface TitleScene : SKScene <GKGameCenterControllerDelegate>
@property (nonatomic) AVAudioPlayer* backgroundMusic;
@end
