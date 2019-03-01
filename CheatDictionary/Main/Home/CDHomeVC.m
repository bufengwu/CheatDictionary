//
//  CDHomeVC.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/12.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDHomeVC.h"
#import "CDRecVC.h"
#import "CDUserProfileVC.h"
#import "CDNoticeVC.h"
#import "CDChannelVC.h"

#import "CDBigAlertView.h"

#import "UIViewController+MMDrawerController.h"

#define kTitleKey   @"kTitleKey"
#define kClassKey   @"kClassKey"

@interface CDHomeVC () <UISearchBarDelegate>

@property (nonatomic, strong) NSArray *childItemsArray;

@end

@implementation CDHomeVC {
    UIViewController *_currentVC;
}

- (instancetype)init {
    if (self = [super init]) {
        self.childItemsArray = @[
                                 @{
                                     kClassKey  : [CDRecVC class],
                                     kTitleKey  : @"热门"
                                     },
                                 @{
                                     kClassKey  : [CDChannelVC class],
                                     kTitleKey  : @"版块"
                                     },
                                 ];
        self.menuViewStyle = WMMenuViewStyleTriangle;
        self.progressWidth = 10;
        self.progressHeight = 5;
        self.progressColor = SecondaryNavbarSelectedRed;
        self.titleColorNormal = SecondaryNavbarTitleNormal;
        self.titleColorSelected = SecondaryNavbarTitleSelected;
        self.titleSizeSelected = 15;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //仅在当前VC 启用抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuView.backgroundColor = SecondaryNavbarColor;
//    self.menuView.layoutMode = WMMenuViewLayoutModeLeft;
    self.showOnNavigationBar = YES;
    self.itemMargin = 10;
    
    {
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:contentView.bounds];
        [leftBtn setImage:[UIImage imageNamed:@"icon_avatar_little"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(showUserCenter:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:leftBtn];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
        self.navigationItem.leftBarButtonItem = barButtonItem;
    }
    
    NSMutableArray *rightBtns = [NSMutableArray arrayWithCapacity:3];
    {
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:contentView.bounds];
        [rightBtn setImage:[UIImage imageNamed:@"icon_bell"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(showMsgCenter:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:rightBtn];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
        [rightBtns addObject:barButtonItem];
//        self.navigationItem.rightBarButtonItem = barButtonItem;
    }
    {
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:contentView.bounds];
        [rightBtn setImage:[[UIImage imageNamed:@"flow_edit_btn"] cd_imageWithTintColor:TabBarTitleColorNormal] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(showEditVC) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:rightBtn];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
//        self.navigationItem.rightBarButtonItem = barButtonItem;
        
        [rightBtns addObject:barButtonItem];
    }
    {
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:contentView.bounds];
        [rightBtn setImage:[[UIImage imageNamed:@"icon_search"] cd_imageWithTintColor:TabBarTitleColorNormal] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(showSearchVC) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:rightBtn];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
//        self.navigationItem.rightBarButtonItem = barButtonItem;
        
        [rightBtns addObject:barButtonItem];
    }
    
    self.navigationItem.rightBarButtonItems = rightBtns;
    
    {
        
//        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 302, 35)];

//        searchBar.delegate = self;

//        self.navigationItem.titleView = searchBar;
    }
    
    //双击手势
    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    
    UITapGestureRecognizer * twoFingerDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerDoubleTap:)];
    [twoFingerDoubleTap setNumberOfTapsRequired:2];
    //双指双击
    [twoFingerDoubleTap setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:twoFingerDoubleTap];
}

- (BOOL)showSearchVC {
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        
    }];
    
    [[CDRouter shared] presentUrl:@"CDSearchVC" animated:NO];
    return NO;
}
- (void)showMsgCenter:(UIButton *)sender {
    [[CDRouter shared] pushUrl:@"CDNoticeVC" animated:YES];
}

- (void)showEditVC {
    [[CDRouter shared] pushUrl:@"CDEditVC" animated:YES];
}

- (void)showUserCenter:(UIButton *)sender {
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    return;
}

-(void)doubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}

-(void)twoFingerDoubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideRight completion:nil];
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
    return CGRectMake(0, 0, SCREEN_WIDTH/2, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 0, SCREEN_WIDTH, self.view.bounds.size.height);
}

@end
