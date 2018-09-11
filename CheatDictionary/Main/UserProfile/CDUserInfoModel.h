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

//五维雷达图
@property (nonatomic, strong) NSArray<NSString *> *ponit_attributes;     //属性名
@property (nonatomic, strong) NSArray<NSNumber *> *ponit_series;     //属性值


@property (nonatomic, strong) NSArray *certificate;
@property (nonatomic, strong) NSArray *article;
@property (nonatomic, strong) NSArray *dynamic;



@end
