//
//  CDMineVM.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDUserProfileVM.h"

#import "CDUserBoardTopCell.h"
#import "CDUserBoardBottomCell.h"

@implementation CDUserProfileVM

- (void)loadData {
    
    NSString *jPath = [[NSBundle mainBundle] pathForResource:@"user_profile" ofType:@"json"];
    NSDictionary *jDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jPath] options:NSJSONReadingMutableLeaves error:nil];
    NSArray *data = [jDic objectForKey:@"data"];
    
    
    CDUserInfoModel *userInfoModel = [CDUserInfoModel modelWithJSON:data];
    
    self.userInfoModel = userInfoModel;
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDUserBoardTopCell"      : [CDUserBoardTopCell class],
             @"CDUserBoardBottomCell"   : [CDUserBoardBottomCell class]
             };
}

@end
