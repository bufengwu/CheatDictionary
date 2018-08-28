//
//  CDHomeVM.m
//  ZYLab
//
//  Created by 哔哩哔哩 on 2018/7/3.
//  Copyright © 2018年 哔哩哔哩. All rights reserved.
//

#import "CDHomeVM.h"

#import "CDSectionHeaderShowMoreView.h"

#import "CDBigImageCell.h"
#import "CDTopActivityCell.h"
#import "CDChannelCoverCell.h"
#import "CDArticleCell.h"


@implementation CDHomeVM

- (void)loadData {
    
    CDBigImageModel *bigCardModel = [CDBigImageModel new];
    bigCardModel.imageUrl = @"";
    bigCardModel.uri = @"/web/https%3a%2f%2fbaidu.com";
    
    CDTopActivityModel *challengeModel = [CDTopActivityModel new];
    challengeModel.title = @"明明明明明白白白很喜欢他，但他不说，请问，明明喜欢他吗";
    challengeModel.content = @"明明白白我的心，渴望一段真感情";
    challengeModel.number = 1734;
    challengeModel.uri = @"CDChallengeDetailVC";
    
    CDSectionModel *sectionModel = [CDSectionModel new];
    {
        CDShowMoreHeaderModel *header = [CDShowMoreHeaderModel new];
        header.title = @"今日挑战";
        header.more = @"查看全部";
        header.uri = @"/CDChallengeTableVC";
        sectionModel.headerModel = header;
    }
    sectionModel.objects = [NSMutableArray arrayWithArray:@[challengeModel]];
    sectionModel.sectionEdges = UIEdgeInsetsMake(0, 16, 0, 16);
    
    CDSectionModel *sectionModel2 = [CDSectionModel new];
    {
        CDShowMoreHeaderModel *header = [CDShowMoreHeaderModel new];
        header.title = @"擂台";
        header.more = @"查看全部";
        header.uri = @"CDChannelCoverVC";
        sectionModel2.headerModel = header;
    }
    sectionModel2.objects = [NSMutableArray array];
    for (int i = 0; i < 12; i++) {
        CDChannelCoverModel *arenaModel = [CDChannelCoverModel new];
        arenaModel.icon = @"";
        arenaModel.title = @"三国";
        arenaModel.uri = @"CDChannelCoverEnterVC";
        [sectionModel2.objects addObject:arenaModel];
    }
    
    CDSectionModel *sectionModel3 = [CDSectionModel new];
    {
        CDShowMoreHeaderModel *header = [CDShowMoreHeaderModel new];
        header.title = @"知识房间";
        header.more = @"查看全部";
        header.uri = @"CDRoomVC";
        sectionModel3.headerModel = header;
    }
    sectionModel3.sectionEdges = UIEdgeInsetsMake(0, 16, 0, 16);
    sectionModel3.objects = [NSMutableArray array];
    for (int i = 0; i < 12; i++) {
        CDArticleModel *roomModel = [CDArticleModel new];
        roomModel.icon = @"";
        roomModel.title = @"诗经中的植物";
//        roomModel.number = 330;
        roomModel.uri = @"CDRoomEnterVC";
        [sectionModel3.objects addObject:roomModel];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.objects = @[bigCardModel, sectionModel, sectionModel2, sectionModel3];
        
        
        if (self.completeLoadDataBlock) {
            self.completeLoadDataBlock();
        }
    });
    
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDChannelCoverCell"     : [CDChannelCoverCell class],
             @"CDBigImageCell"  : [CDBigImageCell class],
             @"CDChallengeCell" : [CDTopActivityCell class],
             @"CDArticleCell"      : [CDArticleCell class],
             };
}

- (NSDictionary<NSString *,Class> *)headerIdentifierMapping {
    return @{
             @"CDSectionHeaderShowMoreView" : [CDSectionHeaderShowMoreView class],
             };
}

@end
