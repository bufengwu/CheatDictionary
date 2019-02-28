//
//  FNWindow.m
//  CheatDictionary
//
//  Created by zzy on 2019/2/28.
//  Copyright © 2019 朱正毅. All rights reserved.
//

#import "FNWindow.h"

@implementation FNWindow

- (void)setRootViewController:(UIViewController *)rootViewController {
    if (self.rootViewController) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
        [UIView transitionWithView:self duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            BOOL oldState = [UIView areAnimationsEnabled];
            [UIView setAnimationsEnabled:NO];
            [super setRootViewController:rootViewController];
            [UIView setAnimationsEnabled:oldState];
        } completion:nil];
    } else {
        [super setRootViewController:rootViewController];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

@end
