//
//  FNSplashViewController.m
//  CheatDictionary
//
//  Created by zzy on 2019/2/28.
//  Copyright © 2019 朱正毅. All rights reserved.
//

#import "FNSplashViewController.h"
#import "CDDevice.h"
#import "LLFullScreenAdView.h"
#import "CCPageControlView.h"

@interface FNSplashViewController ()

@end

@implementation FNSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([CDDevice isFirstOpen]) {
        [self addADView];
    } else {
        [self addGuidePage];
    }
}

- (void)dissmiss {
    if (self.dissmissBlock) {
        self.dissmissBlock();
    }
}

- (void)addGuidePage {
    CCPageControlView *view = [[CCPageControlView alloc] init];
    [self.view addSubview:view];
    
    view.imageArr = @[@"g1", @"g2", @"g3", @"g4", @"g5"];
    view.dissmissBlock = ^{
        [self dissmiss];
    };
}

- (void)addADView {
    LLFullScreenAdView *adView = [[LLFullScreenAdView alloc] init];
    adView.duration = 1;
    adView.skipType = SkipButtonTypeCircleAnimationTest;
    adView.adImageTapBlock = ^(NSString *content) {
        NSLog(@"%@", content);
    };
    
    adView.dissmissBlock = ^{
        [self dissmiss];
    };
    
    [self.view addSubview:adView];
    
    //    [adView reloadAdImageWithUrl:@"http://s8.mogucdn.com/p2/170223/28n_4eb3la6b6b0h78c23d2kf65dj1a92_750x1334.jpg"];
    [adView adImageShowWithImage:[UIImage imageNamed:@"g1"]];
}

- (void)dealloc
{
    
}

@end
