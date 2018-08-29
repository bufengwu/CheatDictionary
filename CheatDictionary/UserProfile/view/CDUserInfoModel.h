//
//  CDUserInfoModel.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"

@interface CDUserInfoModel : CDBaseCellModel

@property(nonatomic, copy) NSString *avatar;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *desc;

@property(nonatomic, copy) NSString *itemTitle1;
@property(nonatomic, copy) NSString *itemDesc1;

@property(nonatomic, copy) NSString *itemTitle2;
@property(nonatomic, copy) NSString *itemDesc2;

@property(nonatomic, copy) NSString *itemTitle3;
@property(nonatomic, copy) NSString *itemDesc3;

@property(nonatomic, copy) NSString *itemTitle4;
@property(nonatomic, copy) NSString *itemDesc4;

@end
