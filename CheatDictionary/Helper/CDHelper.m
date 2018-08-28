//
//  CDHelper.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/24.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDHelper.h"

@implementation CDHelper

+ (NSString *)nowTimeWithForMat:(NSString *)format
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //YYYY/MM/dd
    [formatter setDateFormat:format];
    NSString *DateTime = [formatter stringFromDate:date];
    
    return DateTime;
}

+ (NSString *)dateTimeWithForMat:(NSString *)format WithDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //YYYY/MM/dd
    [formatter setDateFormat:format];
    NSString *DateTime = [formatter stringFromDate:date];
    
    return DateTime;
}

+ (NSString *)getTimeWithTimeInterval:(NSString *)time WithDateFarmat:(NSString *)format{
    NSInteger timeInterger = [time integerValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInterger];
    NSString *timeStr = [NSString stringWithFormat:@"%@",[self dateTimeWithForMat:format WithDate:confromTimesp]];
    return timeStr;
}

@end
