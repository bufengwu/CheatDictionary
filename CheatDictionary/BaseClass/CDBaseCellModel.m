//
//  CDBaseCellModel.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"

@implementation CDBaseCellModel

- (Class)cellClass {
    return Nil;
}

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    // value should be Class or Class name.
    return @{};
}

@end
