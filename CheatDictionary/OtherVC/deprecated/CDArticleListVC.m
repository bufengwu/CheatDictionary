//
//  CDArticleListVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDArticleListVC.h"
#import "CDArticleListVM.h"

#import "CDSectionHeaderShowMoreView.h"

@interface CDArticleListVC ()

@property (nonatomic, strong) CDArticleListVM *viewModel;

@end

@implementation CDArticleListVC
@dynamic viewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [CDArticleListVM new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"技能书";
    [self.viewModel loadData];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:contentView.bounds];
    [rightBtn setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"投稿" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(showWriteVC:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:rightBtn];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)showWriteVC:(UIButton *)sender {
    [[CDRouter shared] pushUrl:@"CDEditVC" animated:YES];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.objects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CDBaseCellModel *cellModel = self.viewModel.objects[indexPath.row];
    CDBaseCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([cellModel cellClass]) forIndexPath:indexPath];
    [cell installWithObject:cellModel];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CDBaseCellModel *cellModel = self.viewModel.objects[indexPath.row];
    return [cellModel.cellClass getSizeWithObject:nil];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 16, 10, 16);
}

@end
