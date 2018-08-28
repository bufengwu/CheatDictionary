//
//  CDBaseCollectionVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCollectionVC.h"
#import "CDSectionModel.h"
#import "CDBaseCellModel.h"
#import "CDBaseCollectionHeaderView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface CDBaseCollectionVC ()<DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@end

@implementation CDBaseCollectionVC

- (instancetype)init
{
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = CollectViewBG;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.alwaysBounceVertical = YES;
    
    [[self.viewModel cellIdentifierMapping] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, Class  _Nonnull cls, BOOL * _Nonnull stop) {
        [self.collectionView registerClass:cls forCellWithReuseIdentifier:key];
    }];
    [[self.viewModel headerIdentifierMapping] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, Class  _Nonnull cls, BOOL * _Nonnull stop) {
        [self.collectionView registerClass:cls forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:key];
    }];
    
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate = self;
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewModel.objects.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id model = self.viewModel.objects[section];
    if ([model isKindOfClass:[CDSectionModel class]]) {
        return ((CDSectionModel *)model).objects.count;
    } else {
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id model = self.viewModel.objects[indexPath.section];
    CDBaseCellModel *curModel;
    if ([model isKindOfClass:[CDSectionModel class]]) {
        curModel = ((CDSectionModel *)model).objects[indexPath.row];
    } else {
        curModel = model;
    }
    CDBaseCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([curModel cellClass]) forIndexPath:indexPath];
    [cell installWithObject:curModel];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        id model = self.viewModel.objects[indexPath.section];
        if ([model isKindOfClass:[CDSectionModel class]]) {
            CDSectionModel *sectionModel = (CDSectionModel *)model;
            NSString *reuseIdentifier = NSStringFromClass([sectionModel.headerModel viewClass]);
            CDBaseCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            [headerView installWithObject:sectionModel.headerModel ];
            return headerView;
        }
    }
    return [UICollectionReusableView new];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    id model = self.viewModel.objects[section];
    if ([model isKindOfClass:[CDSectionModel class]]) {
        CDSectionModel *sectionModel = (CDSectionModel *)model;
        return [[sectionModel.headerModel viewClass] getSizeWithObject:nil];
    } else {
        return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.viewModel.objects[indexPath.section];
    if ([model isKindOfClass:[CDSectionModel class]]) {
        CDBaseCellModel *innerModel = ((CDSectionModel *)model).objects[indexPath.row];
        return [[innerModel cellClass] getSizeWithObject:nil];
    } else {
        return [[model cellClass] getSizeWithObject:nil];
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    id model = self.viewModel.objects[section];
    if ([model isKindOfClass:[CDSectionModel class]]) {
        return ((CDSectionModel *)model).sectionEdges;
    } else {
        return UIEdgeInsetsZero;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 9;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

#pragma mark -

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"什么都没有啊";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = @"网络不给力，请点击重试哦~";
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 设置所有字体大小为 #15
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:15.0]
                   range:NSMakeRange(0, text.length)];
    // 设置所有字体颜色为浅灰色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:[UIColor lightGrayColor]
                   range:NSMakeRange(0, text.length)];
    // 设置指定4个字体为蓝色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:HEXCOLOR(0x007EE5)
                   range:NSMakeRange(7, 4)];
    return attStr;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -70.0f;
}

#pragma mark - DZNEmptyDataSetDelegate

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    // button clicked...
}

@end
