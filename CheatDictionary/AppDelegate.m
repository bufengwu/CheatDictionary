//
//  AppDelegate.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/6/30.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+PushService.h"

#import "CDDevice.h"
#import "LLFullScreenAdView.h"
#import "CCPageControlView.h"
#import <MMDrawerController/MMDrawerController.h>
#import "CDNavigationController.h"
#import "CDLeftViewController.h"

#define kClassKey   @"rootVCClassString"
#define kNavTitleKey   @"navTitle"
#define kTabTitleKey   @"tabTitle"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"

@interface AppDelegate () <UISplitViewControllerDelegate>

@property(nonatomic,strong) UITabBarController * tabBarController;
@property(nonatomic,strong) CDLeftViewController * leftController;
@property(nonatomic,strong) MMDrawerController * drawerController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = NavbarColor;
    self.window.rootViewController = self.drawerController;
    [self.window makeKeyAndVisible];
    [self setAppearanceStyle];
    
    if ([CDDevice isFirstOpen]) {
        [self addADView];
    } else {
        [self addGuidePage];
    }
    
    [self registerRouter];
    
    [self registerNotification];
    [CDApiClient GET:@"log/check?code=200" success:nil failure:nil];
    
    if (launchOptions && launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]) {
        [self receivedRemoteNotificationFromColdBoot:launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]];
    }
    return YES;
}

#pragma mark - setup

- (UITabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [UITabBarController new];
        NSArray *childItemsArray = @[
                                     @{kClassKey  : @"CDHomeVC",
                                       kNavTitleKey  : @"首页",
                                       kTabTitleKey  : @"首页",
                                       kImgKey    : @"tab_home",
                                       kSelImgKey : @"tab_home"},
                                     
                                     @{kClassKey  : @"CDNewsContainerVC",
                                       kNavTitleKey  : @"资讯",
                                       kTabTitleKey  : @"资讯",
                                       kImgKey    : @"tab_arena",
                                       kSelImgKey : @"tab_arena"},
                                     ];
        
        [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
            UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
            UINavigationController *nav = [[CDNavigationController alloc] initWithRootViewController:vc];
            NSString *normalFilePath = dict[kImgKey];
            NSString *selectedFilePath = dict[kSelImgKey];
            
            vc.tabBarItem.image = [[[UIImage imageNamed:normalFilePath] tintImageWithColor:TabBarTitleColorNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedFilePath];
            vc.tabBarItem.title = vc.title = dict[kNavTitleKey];;
            vc.tabBarItem.imageInsets = UIEdgeInsetsZero;
            vc.tabBarItem.titlePositionAdjustment= UIOffsetMake(0, -3);
            [self->_tabBarController addChildViewController:nav];
        }];
    }
    return _tabBarController;
}

- (MMDrawerController *)drawerController {
    if (!_drawerController) {
        MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:self.tabBarController leftDrawerViewController:self.leftController rightDrawerViewController:nil];
        //设置打开/关闭抽屉的手势
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
        //设置左右两边抽屉显示的多少
        drawerController.maximumLeftDrawerWidth = 200.0;
        drawerController.maximumRightDrawerWidth = 200.0;
        _drawerController = drawerController;
    }
    return _drawerController;
}

- (CDLeftViewController *)leftController {
    if (!_leftController) {
        _leftController = [CDLeftViewController new];
    }
    return _leftController;
}

- (void)addGuidePage {
    CCPageControlView *view = [[CCPageControlView alloc] init];
    [self.window addSubview:view];
    
    view.imageArr = @[@"g1", @"g2", @"g3", @"g4", @"g5"];
}

- (void)addADView {
    LLFullScreenAdView *adView = [[LLFullScreenAdView alloc] init];
    adView.duration = 1;
    adView.skipType = SkipButtonTypeCircleAnimationTest;
    adView.adImageTapBlock = ^(NSString *content) {
        NSLog(@"%@", content);
    };
    [self.window addSubview:adView];
    
    //    [adView reloadAdImageWithUrl:@"http://s8.mogucdn.com/p2/170223/28n_4eb3la6b6b0h78c23d2kf65dj1a92_750x1334.jpg"];
    [adView adImageShowWithImage:[UIImage imageNamed:@"g1"]];
}

- (void)setAppearanceStyle {
    //状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //TabBar颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:TabBarTitleColorNormal} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:SecondaryNavbarTitleSelected} forState:UIControlStateSelected];
    [[UITabBar appearance] setTintColor:SecondaryNavbarTitleSelected];
    [[UITabBar appearance] setBarTintColor:TabBarColor];
    [UITabBar appearance].translucent = NO;
    //导航栏颜色
    [[UINavigationBar appearance] setBarTintColor:NavbarColor];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:NavbarTitleColor}];
    //导航栏返回按钮颜色
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateSelected];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateHighlighted];
    [[UIBarButtonItem appearance] setTintColor:SecondaryNavbarTitleSelected];
 
    //searchBar颜色
    [[UISearchBar appearance] setBackgroundColor:[UIColor clearColor]];
    UIImage *clearImg = [UIImage imageWithColor:[UIColor clearColor] height:1.0f];
    [[UISearchBar appearance] setBackgroundImage:clearImg];
    [[UISearchBar appearance] setSearchFieldBackgroundImage:[UIImage imageNamed:@"img_search_bg_302x35_"] forState:UIControlStateNormal];
}

- (void)registerRouter {
    [[CDRouter shared] setTabBarController:self.tabBarController];
    
    [[CDRouter shared] map:@"/web/:url" toControllerClass:[NSClassFromString(@"CDWebViewController") class]];
    
    [[CDRouter shared] map:@"/CDLoginVC" toControllerClass:[NSClassFromString(@"CDLoginVC") class]];
    [[CDRouter shared] map:@"/CDUserCenterVC" toControllerClass:[NSClassFromString(@"CDUserCenterVC") class]];
    
    [[CDRouter shared] map:@"/CDNoticeVC" toControllerClass:[NSClassFromString(@"CDNoticeVC") class]];
    
    [[CDRouter shared] map:@"/CDArticleDetailVC" toControllerClass:[NSClassFromString(@"CDArticleDetailVC") class]];
    [[CDRouter shared] map:@"/CDArticleListVC" toControllerClass:[NSClassFromString(@"CDArticleListVC") class]];
    
    
    [[CDRouter shared] map:@"/CDChannelDetailVC/:type" toControllerClass:[NSClassFromString(@"CDChannelDetailVC") class]];
    [[CDRouter shared] map:@"/CDPersonListVC" toControllerClass:[NSClassFromString(@"CDPersonListVC") class]];
    [[CDRouter shared] map:@"/CDDiscussionDetailVC/:type" toControllerClass:[NSClassFromString(@"CDDiscussionDetailVC") class]];
    
    [[CDRouter shared] map:@"/CDEditVC" toControllerClass:[NSClassFromString(@"CDEditVC") class]];
    
    [[CDRouter shared] map:@"/FarmLandViewController" toControllerClass:[NSClassFromString(@"FarmLandViewController") class]];
    [[CDRouter shared] map:@"/BTDreamViewController" toControllerClass:[NSClassFromString(@"BTDreamViewController") class]];
    [[CDRouter shared] map:@"/CDComboBoxViewController" toControllerClass:[NSClassFromString(@"CDComboBoxViewController") class]];
    [[CDRouter shared] map:@"/RadarChartVC" toControllerClass:[NSClassFromString(@"RadarChartVC") class]];
    
    [[CDRouter shared] map:@"/CDSearchVC" toControllerClass:[NSClassFromString(@"CDSearchVC") class]];
}

#pragma mark -

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)applicationWillTerminate:(UIApplication *)application {

}

- (void)applicationDidReceiveMemoryWarning:(UIApplication*)application
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation
{
    [application setStatusBarOrientation:application.statusBarOrientation];
}

@end
