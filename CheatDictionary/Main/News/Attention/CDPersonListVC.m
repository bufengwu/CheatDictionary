//
//  CDPersonListVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/14.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDPersonListVC.h"
#import "CDBaseCellModel.h"
#import "CDPersonListVM.h"

@interface CDPersonListVC ()

@property (nonatomic, strong) CDPersonListVM *viewModel;

@end

@implementation CDPersonListVC
@dynamic viewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [CDPersonListVM new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我关注的";
    [self.viewModel loadData];
    
    @weakify(self)
    self.viewModel.completeLoadDataBlock = ^(BOOL success) {
        @strongify(self)
        if (success) {
            [self.collectionView reloadData];
        } else {
            [CDToast showBottomToast:@"出错了呀"];
        }
    };
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


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
@end
