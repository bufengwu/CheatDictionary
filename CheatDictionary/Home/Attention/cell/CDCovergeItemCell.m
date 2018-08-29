//
//  CDCovergeItemCell.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDCovergeItemCell.h"

#import "CDPersonRecCell.h"
#import "CDPersonRecModel.h"

#define kCollectionViewMargin 10

@interface CDCovergeItemCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *itemModels;

@end

@implementation CDCovergeItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(id )object {
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0; i < 13; i++) {
        CDPersonRecModel *roomModel = [CDPersonRecModel new];
        roomModel.icon = @"icon_avatar_default";
        roomModel.name = @"贝爷2号";
        roomModel.desc1 = @"擅长摸鱼、划水";
        roomModel.desc2 = @"粉丝 10W+";
        roomModel.uri = @"CDUserCenterVC";
        [mutableArray addObject:roomModel];
    }
    self.itemModels = mutableArray;
    [self.collectionView registerClass:[CDPersonRecCell class] forCellWithReuseIdentifier:@"CDPersonRecCell"];
}

#pragma mark -

- (void)configSubviews {
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = [CDPersonRecCell getSizeWithObject:nil].height + kCollectionViewMargin * 2;
        make.height.mas_equalTo(height);
        make.edges.equalTo(self.contentView).priorityHigh();
    }];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(kCollectionViewMargin, 16, kCollectionViewMargin, 16);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = RGB(211, 201, 179);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemModels.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CDPersonRecModel *model = self.itemModels[indexPath.row];
    CDPersonRecCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([model cellClass]) forIndexPath:indexPath];
    
    [cell installWithObject:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {    
    CDPersonRecModel *model = self.itemModels[indexPath.row];
    [[CDRouter shared] pushUrl:model.uri animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CDPersonRecModel *model = self.itemModels[indexPath.row];

    return [[model cellClass] getSizeWithObject:nil];
}

@end
