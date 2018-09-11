//
//  CDMineVM.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDListBaseVM.h"
#import "CDUserInfoModel.h"

@interface CDUserProfileVM : CDListBaseVM

@property (nonatomic, strong) CDUserInfoModel *userInfoModel;

@end
