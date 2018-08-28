//
//  CDChannelCoverVM.m
//  ZYLab
//
//  Created by 哔哩哔哩 on 2018/7/3.
//  Copyright © 2018年 哔哩哔哩. All rights reserved.
//

#import "CDChannelCoverVM.h"

#import "CDPlayRuleModel.h"
#import "CDChannelCoverModel.h"
#import "CDShowMoreHeaderModel.h"
#import "CDChannelCoverPlayRuleHeaderModel.h"

#import "CDChannelCoverCell.h"
#import "CDPlayRuleCell.h"
#import "CDChannelCoverPlayRuleHeaderView.h"
#import "CDSectionHeaderShowMoreView.h"

@implementation CDChannelCoverVM

- (void)loadData {
    
    CDSectionModel *sectionModel = [CDSectionModel new];
    {
        CDChannelCoverPlayRuleHeaderModel *header = [CDChannelCoverPlayRuleHeaderModel new];
        header.title = @"玩法规则";
        header.vitality = @"100/100";
        sectionModel.headerModel = header;
        
        sectionModel.objects = [NSMutableArray array];
        
        CDPlayRuleModel *ruleModel = [CDPlayRuleModel new];
        ruleModel.icon = @"icon_honor";
        ruleModel.title = @"我的段位";
        ruleModel.content = @"三体二段";
        [sectionModel.objects addObject:ruleModel];
        
        ruleModel = [CDPlayRuleModel new];
        ruleModel.icon = @"icon_rank";
        ruleModel.title = @"好友排行榜";
        ruleModel.content = @"看看谁在玩";
        [sectionModel.objects addObject:ruleModel];
    }
    
    CDSectionModel *sectionModel2 = [CDSectionModel new];
    {
        CDShowMoreHeaderModel *header = [CDShowMoreHeaderModel new];
        header.title = @"全部擂台";
        sectionModel2.headerModel = header;
        sectionModel2.objects = [NSMutableArray array];
        for (int i = 0; i < 16; i++) {
            CDChannelCoverModel *arenaModel = [CDChannelCoverModel new];
            arenaModel.icon = @"";
            arenaModel.title = @"全能王";
            [sectionModel2.objects addObject:arenaModel];
        }
    }
    self.objects = @[sectionModel, sectionModel2];
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDChannelCoverCell"     : [CDChannelCoverCell class],
             @"CDPlayRuleCell"  : [CDPlayRuleCell class]
             };
}

- (NSDictionary<NSString *,Class> *)headerIdentifierMapping {
    return @{
             @"CDSectionHeaderShowMoreView" : [CDSectionHeaderShowMoreView class],
             @"CDChannelCoverPlayRuleHeaderView" : [CDChannelCoverPlayRuleHeaderView class],
             };
}

@end
