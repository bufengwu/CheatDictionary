//
//  FNLauncher.m
//  CheatDictionary
//
//  Created by zzy on 2019/2/28.
//  Copyright © 2019 朱正毅. All rights reserved.
//

#import "FNLauncher.h"
#import "FNSplashViewController.h"

@implementation FNLauncher

+ (void)tryShowSplashWithDismissBlock:(dispatch_block_t)completionBlock {
    UIWindow *originalKeyWindow = [[UIApplication sharedApplication] keyWindow];
    FNSplashViewController *vc = [FNSplashViewController new];
    vc.dissmissBlock = ^{
        if (completionBlock) {
            completionBlock();
        }
    };
    originalKeyWindow.rootViewController = vc;
}

@end
