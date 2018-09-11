//
//  CDMineTableVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/6/30.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDUserProfileVC.h"

#import "CDUserProfileVM.h"

#import "CDBaseCellModel.h"

#import "CDUserBoardTopCell.h"
#import "CDUserBoardBottomCell.h"

@interface CDUserProfileVC ()

@property (nonatomic, strong) UIView *navBar;

@property (nonatomic, strong) CDUserProfileVM *viewModel;

@end

@implementation CDUserProfileVC
@dynamic viewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [CDUserProfileVM new];        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    
    [self.view addSubview:self.navBar];
    
    self.collectionView.bounces = NO;
    if (@available(iOS 11.0, *)) {      //这个视图让cell顶着屏幕顶，不空出状态栏高度
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.viewModel loadData];
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

#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CDBaseCollectionViewCell *cell;
    if (indexPath.section == 0) {
        cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CDUserBoardTopCell" forIndexPath:indexPath];
    } else if (indexPath.section == 1) {
        cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CDUserBoardBottomCell" forIndexPath:indexPath];        
    }
    [cell installWithObject:self.viewModel.userInfoModel];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [[CDUserBoardTopCell class] getSizeWithObject:nil];
    } else if (indexPath.section == 1) {
        return [[CDUserBoardBottomCell class] getSizeWithObject:nil];
    }
    return CGSizeZero;
}

#pragma mark -

- (void)goBack {
    if ([self.navigationController.viewControllers indexOfObject:self] == 0) {
        [self dismissViewControllerAnimated:NO completion:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIView *)navBar {
    if (!_navBar) {
        _navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _navBar.backgroundColor = [NavbarColor colorWithAlphaComponent:0];
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 25, 21, 21)];
        UIImage *backImg = [[UIImage imageNamed:@"icon_back"] cd_imageWithTintColor:SecondaryNavbarTitleSelected];
        [backBtn setImage:backImg forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [_navBar addSubview:backBtn];
    }
    return _navBar;
}

@end
