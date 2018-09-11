//
//  CDBarHeaderModel.h
//  CheatDictionary
//
//  Created by zzy on 2018/8/9.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"

@interface CDBarHeaderModel : CDBaseCellModel

@property(nonatomic, strong) NSString *icon;
@property(nonatomic, strong) NSString *today;
@property(nonatomic, strong) NSString *all;
@property(nonatomic, strong) NSArray *masters;

@end
