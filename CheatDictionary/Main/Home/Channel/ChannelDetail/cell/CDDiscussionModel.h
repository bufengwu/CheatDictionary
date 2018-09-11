//
//  CDDiscussionModel.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/14.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"

@interface CDDiscussionModel : CDBaseCellModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *comments;

@end
