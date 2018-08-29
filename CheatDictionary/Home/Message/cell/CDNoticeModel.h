//
//  CDNoticeModel.h
//  CheatDictionary
//
//  Created by zzy on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"

@interface CDNoticeModel : CDBaseCellModel

@property (nonatomic, copy) NSString *avatarImage;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *action;

@property (nonatomic, copy) NSString *noticeTitle;

@property (nonatomic, copy) NSString *myMomentTitle;

@end
