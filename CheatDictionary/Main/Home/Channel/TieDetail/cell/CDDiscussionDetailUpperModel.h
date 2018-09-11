//
//  CDDiscussionDetailUpperModel.h
//  CheatDictionary
//
//  Created by zzy on 2018/7/16.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"

@interface CDDiscussionDetailUpperModel : CDBaseCellModel

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSUInteger watch_num;


@end
