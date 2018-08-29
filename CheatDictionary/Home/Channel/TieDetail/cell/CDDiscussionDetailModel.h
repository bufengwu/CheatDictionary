//
//  CDDiscussionDetailModel.h
//  CheatDictionary
//
//  Created by zzy on 2018/7/16.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"

@interface CDDiscussionDetailModel : CDBaseCellModel

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSUInteger floor;

//如果有楼中楼回复，会附带下列字段
@property (nonatomic, strong) NSString *leader_name;   //王大锤
@property (nonatomic, strong) NSString *leader_uri;
@property (nonatomic, assign) NSUInteger comments_num;   //共1条回复
@property  (nonatomic, strong) NSString *comments_uri;

@end
