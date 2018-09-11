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
    
    [CDApiClient GET:@"user_profile" success:^(NSDictionary *data) {
        CDUserInfoModel *userInfoModel = [CDUserInfoModel modelWithJSON:data];
        
        self.userInfoModel = userInfoModel;
        
        if (self.completeLoadDataBlock) {
            self.completeLoadDataBlock(YES);
        }
        
    } failure:^(NSInteger code, NSString *message) {
        
        if (self.completeLoadDataBlock) {
            self.completeLoadDataBlock(NO);
        }
    }];
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDUserBoardTopCell"      : [CDUserBoardTopCell class],
             @"CDUserBoardBottomCell"   : [CDUserBoardBottomCell class]
             };
}

@end
