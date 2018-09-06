//
//  CDUserInfoModel.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"

@interface CDUserInfoModel : CDBaseCellModel

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *fans;
@property (nonatomic, copy) NSString *coins;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *ponit1_desc;
@property (nonatomic, copy) NSString *ponit1;
@property (nonatomic, copy) NSString *ponit2_desc;
@property (nonatomic, copy) NSString *ponit2;
@property (nonatomic, copy) NSString *ponit3_desc;
@property (nonatomic, copy) NSString *ponit3;
@property (nonatomic, copy) NSString *ponit4_desc;
@property (nonatomic, copy) NSString *ponit4;
@property (nonatomic, copy) NSString *ponit5_desc;
@property (nonatomic, copy) NSString *ponit5;

@property (nonatomic, strong) NSArray *certificate;
@property (nonatomic, strong) NSArray *article;
@property (nonatomic, strong) NSArray *dynamic;



@end
