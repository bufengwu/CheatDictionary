//
//  CDMineVM.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDMineVM.h"

#import "CDUserInfoModel.h"
#import "CDSectionModel.h"
#import "CDShowMoreHeaderModel.h"

//#import "CDMineEndModel.h"
//#import "CDMineEndCell.h"

#import "CDUserInfoCell.h"
#import "CDSectionHeaderShowMoreView.h"

//#import "CDUserCenterItemModel.h"
//#import "CDUserCenterItemCell.h"

#import "CDUserInfoBoardCell.h"

#import "CDUserBoardModel.h"

@implementation CDMineVM

- (void)loadData {
    
    CDUserInfoModel *userInfoModel = [CDUserInfoModel new];
    userInfoModel.avatar = @"icon_avatar_default";
    userInfoModel.name = @"牧野狼";
    userInfoModel.desc = @"擅长打铁、捕鱼、设计马桶";
    
    userInfoModel.itemTitle1 = @"总星数";
    userInfoModel.itemDesc1 = @"10";
    
    userInfoModel.itemTitle2 = @"答题数";
    userInfoModel.itemDesc2 = @"150";
    
    userInfoModel.itemTitle3 = @"胜场数";
    userInfoModel.itemDesc3 = @"22";
    
    userInfoModel.itemTitle4 = @"证书";
    userInfoModel.itemDesc4 = @"0";
    
//    // <------> //
//    CDSectionModel * sectionModel1 = [CDSectionModel new];
//    {
//        CDShowMoreHeaderModel *header = [CDShowMoreHeaderModel new];
//        header.title = @"擅长擂台";
//        sectionModel1.headerModel = header;
//
//        CDUserCenterItemModel *itemModel = [CDUserCenterItemModel new];
//        sectionModel1.objects = [NSMutableArray arrayWithObjects:itemModel, nil];
//    }
//
//    CDSectionModel * sectionModel2 = [CDSectionModel new];
//    {
//        CDShowMoreHeaderModel *header = [CDShowMoreHeaderModel new];
//        header.title = @"我的证书";
//        sectionModel2.headerModel = header;
//
//        CDUserCenterItemModel *itemModel = [CDUserCenterItemModel new];
//        sectionModel2.objects = [NSMutableArray arrayWithObjects:itemModel, nil];
//    }
//
//    CDMineEndModel *endModel = [CDMineEndModel new];
//    endModel.title = @"联系我们";
//    endModel.icon = @"icon_server";
//
    
    CDUserBoardModel *board = [CDUserBoardModel new];
    
    self.objects = @[userInfoModel, board];
}


- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDUserInfoCell" : [CDUserInfoCell class],
             @"CDUserInfoBoardCell" : [CDUserInfoBoardCell class]
             };
}

- (NSDictionary<NSString *,Class> *)headerIdentifierMapping {
    return @{
             @"CDSectionHeaderShowMoreView" : [CDSectionHeaderShowMoreView class],
             };
}

@end
