//
//  CDNewsVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/27.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDNewsContainerVC.h"
#import "CDAttentionVC.h"
#import "CDPhotoNewsVC.h"

#define kTitleKey   @"kTitleKey"
#define kClassKey   @"kClassKey"

@interface CDNewsContainerVC ()

@property (nonatomic, strong) NSArray *childItemsArray;

@end

@implementation CDNewsContainerVC

- (instancetype)init {
    if (self = [super init]) {
        self.childItemsArray = @[
                                 @{
                                     kClassKey  : [CDAttentionVC class],
                                     kTitleKey  : @"关注"
                                     },
                                 @{
                                     kClassKey  : [CDPhotoNewsVC class],
                                     kTitleKey  : @"图片"
                                     },
                                 ];
        self.menuViewStyle = WMMenuViewStyleTriangle;
        self.progressWidth = 10;
        self.progressHeight = 5;
        self.progressColor = SecondaryNavbarSelectedRed;
        self.titleColorNormal = SecondaryNavbarTitleNormal;
        self.titleColorSelected = SecondaryNavbarTitleSelected;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuView.backgroundColor = SecondaryNavbarColor;
    self.view.backgroundColor = SecondaryNavbarColor; //没有导航栏时，状态栏等于view.backgroundColor
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;    
}

#pragma mark - Datasource &; Delegate

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.childItemsArray.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return [[self.childItemsArray[index] objectForKey:kClassKey] new];
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return [self.childItemsArray[index] objectForKey:kTitleKey];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    return CGRectMake(0, statusRect.size.height, SCREEN_WIDTH, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat top = statusRect.size.height + 44;
    return CGRectMake(0, top, SCREEN_WIDTH, self.view.bounds.size.height - top);
}


@end
