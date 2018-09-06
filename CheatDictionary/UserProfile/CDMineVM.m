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
    
    NSString *jPath = [[NSBundle mainBundle] pathForResource:@"user_profile" ofType:@"json"];
    NSDictionary *jDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jPath] options:NSJSONReadingMutableLeaves error:nil];
    NSArray *data = [jDic objectForKey:@"data"];
    
    
    CDUserInfoModel *userInfoModel = [CDUserInfoModel modelWithJSON:data];
    
    self.userInfoModel = userInfoModel;
    
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
