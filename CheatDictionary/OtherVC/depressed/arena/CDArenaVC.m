//
//  CDChannelCoverVC.m
//  ZYLab
//
//  Created by 哔哩哔哩 on 2018/7/2.
//  Copyright © 2018年 哔哩哔哩. All rights reserved.
//

#import "CDChannelCoverVC.h"
#import "CDChannelCoverVM.h"
#import "CDBaseCollectionHeaderView.h"

@interface CDChannelCoverVC ()

@property (nonatomic, strong) CDChannelCoverVM *viewModel;

@end

@implementation CDChannelCoverVC
@dynamic viewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [CDChannelCoverVM new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel loadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CDSectionModel *sectionModel = self.viewModel.objects[indexPath.section];
        NSString *reuseIdentifier = NSStringFromClass([sectionModel.headerModel viewClass]);
        CDBaseCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        [headerView installWithObject:sectionModel.headerModel ];
        return headerView;
    }
    return [UICollectionReusableView new];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CDSectionModel *model = self.viewModel.objects[section];
    return model.objects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CDSectionModel *sectionModel = self.viewModel.objects[indexPath.section];
    CDBaseCellModel *cellModel = sectionModel.objects[indexPath.row];
    CDBaseCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([cellModel cellClass]) forIndexPath:indexPath];
    [cell installWithObject:cellModel];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CDSectionModel *sectionModel = self.viewModel.objects[indexPath.section];
    CDBaseCellModel *cellModel = sectionModel.objects[indexPath.row];
    return [cellModel.cellClass getSizeWithObject:nil];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CDSectionModel *sectionModel = self.viewModel.objects[section];
    return [[sectionModel.headerModel viewClass] getSizeWithObject:nil];
}

@end
