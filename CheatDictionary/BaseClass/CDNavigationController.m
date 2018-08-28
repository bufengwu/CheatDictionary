//
//  CDNavigationController.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/27.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDNavigationController.h"

@interface CDNavigationController ()

@end

@implementation CDNavigationController

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
