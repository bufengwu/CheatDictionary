//
//  CDTabBarController.m
//  CheatDictionary
//
//  Created by zzy on 2018/9/7.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDTabBarController.h"

NSString * const CDTabBarDidClickNotification = @"CDTabBarDidClickNotification";

@interface CDTabBarController ()

@property (nonatomic, strong) UITabBarItem *lastItem;

@end

@implementation CDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.lastItem = self.tabBar.selectedItem;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item == self.lastItem) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CDTabBarDidClickNotification object:nil userInfo:nil];
    }
    self.lastItem = item;
}

@end
