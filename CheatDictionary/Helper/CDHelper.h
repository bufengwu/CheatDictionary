//
//  CDHelper.h
//  CheatDictionary
//
//  Created by zzy on 2018/8/24.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDHelper : NSObject

//获取时间
+ (NSString *)nowTimeWithForMat:(NSString *)format;

//获取特定格式时间
+ (NSString *)dateTimeWithForMat:(NSString *)format WithDate:(NSDate *)datel;

//根据时间戳获取时间
+ (NSString *)getTimeWithTimeInterval:(NSString *)time WithDateFarmat:(NSString *)format;

@end
