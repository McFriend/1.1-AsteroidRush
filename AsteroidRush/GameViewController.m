//
//  GameViewController.m
//  AsteroidRush
//
//  Created by George Sabanov on 02.11.14.
//  Copyright (c) 2014 Sabanov George. All rights reserved.
//
//
//  THViewController.m
//  Space Cat
//
//  Created by Amit Bijlani on 5/12/14.
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import "GameViewController.h"
#import "TitleScene.h"

@implementation GameViewController

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SKScene * scene = [TitleScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];

    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end

