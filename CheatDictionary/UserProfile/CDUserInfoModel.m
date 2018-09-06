//
//  CDUserInfoModel.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDUserInfoModel.h"
#import "CDUserInfoCell.h"

#import "CDArticleModel.h"
#import "CDMomentModel.h"

@implementation CDUserInfoModel

- (Class)cellClass {
    return [CDUserInfoCell class];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"certificate" : [NSString class],
             @"article" :[CDArticleModel class],
             @"dynamic":[CDMomentModel class],
             };
}

@end
