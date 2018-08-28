//
//  CDArticleModel.h
//  ZYLab
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"

@interface CDArticleCoverModel : CDBaseCellModel

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic, assign) NSUInteger number;

@end
