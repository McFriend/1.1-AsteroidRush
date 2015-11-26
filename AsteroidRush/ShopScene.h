//
//  ShopScene.h
//  AsteroidRush
//
//  Created by George Sabanov on 15.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import <StoreKit/StoreKit.h>
#import <SCPStoreKitManager/SCPStoreKitManager.h>
@interface ShopScene : SKScene <SKPaymentTransactionObserver, SKProductsRequestDelegate>
@property (nonatomic) AVAudioPlayer* backgroundMusic;
@property (nonatomic) NSArray* products;
@end
