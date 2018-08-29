//
//  CDArticleModel.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"

@interface CDArticleModel : CDBaseCellModel

@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *desc;

@end
