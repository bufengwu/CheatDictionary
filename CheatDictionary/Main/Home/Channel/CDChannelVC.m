//
//  CDChannelVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/12.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDChannelVC.h"
#import "CDChannelVM.h"

#import "CDBaseCellModel.h"
#import "CDSectionModel.h"

#import <SVPullToRefresh/SVPullToRefresh.h>

@interface CDChannelVC ()

@property (nonatomic, strong) CDChannelVM *viewModel;
@end

@implementation CDChannelVC
@dynamic viewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [CDChannelVM new];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.viewModel loadData];

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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id model = self.viewModel.objects[indexPath.section];
    CDBaseCellModel *curModel;
    if ([model isKindOfClass:[CDSectionModel class]]) {
        curModel = ((CDSectionModel *)model).objects[indexPath.row];
    } else {
        curModel = model;
    }
    
    if (!curModel.uri) {
        return;
    }
    [[CDRouter shared] pushUrl:curModel.uri animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 16, 5, 16);
}

@end
