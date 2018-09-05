//
//  CDMineTableVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/6/30.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDUserCenterVC.h"
#import "CDMineVM.h"

@interface CDUserCenterVC ()

@property (nonatomic, strong) UIView *navBar;

@property (nonatomic, strong) CDMineVM *viewModel;

@end

@implementation CDUserCenterVC
@dynamic viewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [CDMineVM new];        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:self.navBar];
    
    if (@available(iOS 11.0, *)) {      //这个视图让cell顶着屏幕顶，不空出状态栏高度
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.title = @"个人中心";
    self.collectionView.bounces = NO;
    
    [self.viewModel loadData];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
    UIImage *backImg = [[UIImage imageNamed:@"icon_back"] cd_imageWithTintColor:SecondaryNavbarTitleSelected];
    [backBtn setImage:backImg forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:backBtn];
    
    self.navBar.backgroundColor = [NavbarColor colorWithAlphaComponent:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f", scrollView.contentOffset.y);
    self.navBar.backgroundColor = [NavbarColor colorWithAlphaComponent:(scrollView.contentOffset.y)/60.f];
}

- (void)goBack {
    
    if ([self.navigationController.viewControllers indexOfObject:self] == 0) {
        [self dismissViewControllerAnimated:NO completion:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
