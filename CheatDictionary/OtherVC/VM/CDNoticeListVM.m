//
//  CDNoticeListVM.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/14.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDNoticeListVM.h"
#import "CDNoticeCell.h"
#import "CDNoticeModel.h"

@implementation CDNoticeListVM


- (void)loadData {
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < 10; i++) {
        CDNoticeModel *notice = [CDNoticeModel new];
        notice.avatarImage = @"icon_avatar_default";
        notice.name = @"窃 格瓦拉";
        notice.time = @"7月5日";
        notice.action = @"回复了你的文章";
        notice.noticeTitle = @"海关统计数据显示，我国货物贸易顺差自2016年第三季度起，已连续8个季度呈现同比收窄态势。";
        notice.myMomentTitle = @"打工这方面......打工是不可能打工的 这辈子不可能打工的，做生意又不会做，就是偷这种东西，才能维持得了生活这样子.";
        notice.uri = @"CDArticleDetailVC";
        [mutableArray addObject:notice];
    }
    
    self.objects = mutableArray;
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDNoticeCell" : [CDNoticeCell class],
             };
}

@end
