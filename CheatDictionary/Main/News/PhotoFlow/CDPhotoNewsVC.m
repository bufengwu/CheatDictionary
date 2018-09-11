//
//  CDPhotoNewsVC.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/21.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDPhotoNewsVC.h"
#import "WSLWaterFlowLayout.h"

#import "CDPhotoDetailVC.h"

#import "CDSectionHeaderShowMoreView.h"
#import "CDPhotoFlowNewsCell.h"
#import "CDPhotoFlowNewsModel.h"
#import "CDSectionModel.h"
#import "CDPhotoNewsVM.h"

#import "CDFlowEditView.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface CDPhotoNewsVC () <UICollectionViewDelegate, UICollectionViewDataSource, WSLWaterFlowLayoutDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) CDPhotoNewsVM *viewModel;

//tableview空白视图的刷新事件，子类赋值
@property (nonatomic, strong) dispatch_block_t refreshBlock;

@end

@implementation CDPhotoNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [CDPhotoNewsVM new];
    [self.viewModel loadData];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[CDPhotoFlowNewsCell class] forCellWithReuseIdentifier:@"CDPhotoFlowNewsCell"];
    [self.collectionView registerClass:[CDSectionHeaderShowMoreView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CDSectionHeaderShowMoreView"];
    
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate = self;
    
    CDFlowEditView *flowEditView = [CDFlowEditView new];
    [self.view addSubview:flowEditView];
    [flowEditView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-60);
        make.width.height.mas_equalTo(60);
    }];
    
    
    @weakify(self)
    self.viewModel.completeLoadDataBlock = ^(BOOL success) {
        @strongify(self)
        if (success) {
            [self.collectionView reloadData];
        }
        [self.collectionView.pullToRefreshView stopAnimating];
    };
    
    
    self.refreshBlock = ^{
        @strongify(self)
        [self.viewModel loadData];
    };
}

#pragma mark -

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        WSLWaterFlowLayout *layout = [[WSLWaterFlowLayout alloc] init];
        layout.delegate = self;
        layout.flowLayoutStyle = WSLWaterFlowVerticalEqualWidth;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = MainLightBrownColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _collectionView;
}

#pragma mark - WSLWaterFlowLayoutDelegate

- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.viewModel.objects[indexPath.section];
    if ([model isKindOfClass:[CDSectionModel class]]) {
        CDPhotoFlowNewsModel *innerModel = ((CDSectionModel *)model).objects[indexPath.row];
        return [CDPhotoFlowNewsCell getSizeWithObject:innerModel];
    }
    return CGSizeZero;
}

-(CGSize )waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section {
    return [CDSectionHeaderShowMoreView getSizeWithObject:nil];
}

-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 2;
}

-(CGFloat)columnMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 5;
}

-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

#pragma mark - UICollectionView数据源

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.viewModel.objects.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id model = self.viewModel.objects[section];
    if ([model isKindOfClass:[CDSectionModel class]]) {
        return ((CDSectionModel *)model).objects.count;
    } else {
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CDPhotoFlowNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CDPhotoFlowNewsCell" forIndexPath:indexPath];
    
    id model = self.viewModel.objects[indexPath.section];
    if ([model isKindOfClass:[CDSectionModel class]]) {
        CDPhotoFlowNewsModel *innerModel = ((CDSectionModel *)model).objects[indexPath.row];
        [cell installWithObject:innerModel];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        id model = self.viewModel.objects[indexPath.section];
//        if ([model isKindOfClass:[CDSectionModel class]]) {
//            CDSectionModel *sectionModel = (CDSectionModel *)model;
//            NSString *reuseIdentifier = NSStringFromClass([sectionModel.headerModel viewClass]);
            CDSectionHeaderShowMoreView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CDSectionHeaderShowMoreView" forIndexPath:indexPath];
//            [headerView installWithObject:sectionModel.headerModel ];
        headerView.titleLabel.text = @"精选推荐";
            return headerView;
//        }
    }
    return [UICollectionReusableView new];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CDPhotoDetailVC *vc = [CDPhotoDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
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
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}

@end
