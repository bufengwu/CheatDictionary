//
//  NSString+CDString.m
//  CheatDictionary
//
//  Created by zzy on 2018/9/6.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "NSString+CDString.h"
#import <CommonCrypto/CommonDigest.h>
#import <YYKit/NSData+YYAdd.h>

/**
 部分工具函数在YYKit中有重复，可以优化去除
 */
@implementation NSString (CDString)

- (NSUInteger)cd_unicharLength
{
    NSUInteger len = [self length];
    NSUInteger aLen = 0, uLen = 0, bLen = 0;
    unichar ch;
    for (int index = 0; index < len; index++) {
        ch = [self characterAtIndex:index];
        if (isblank(ch)) {
            bLen++;
        } else if (isascii(ch)) {
            aLen++;
        } else {
            uLen++;
        }
    }
    return uLen * 2 + aLen + bLen;
}

- (CGSize)cd_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width
{
    return [self cd_sizeWithFont:font forSize:CGSizeMake(width, MAXFLOAT)];
}

- (CGSize)cd_sizeWithFont:(UIFont *)font forHeight:(CGFloat)height
{
    return [self cd_sizeWithFont:font forSize:CGSizeMake(MAXFLOAT, height)];
}

- (CGSize)cd_sizeWithFont:(UIFont *)font forSize:(CGSize)size
{
    if (!font || CGSizeEqualToSize(size, CGSizeZero)) {
        return CGSizeZero;
    }
    
    static NSMutableParagraphStyle *style;
    static NSDictionary *atts;
    if (!atts) {
        style = [[NSMutableParagraphStyle alloc] init];
        style.paragraphSpacing = 0;
        style.lineSpacing = 0;
        style.lineBreakMode = NSLineBreakByWordWrapping;
        
        atts = @{NSFontAttributeName: font,
                 NSParagraphStyleAttributeName: style};
    } else {
        UIFont *cacheFont = atts[NSFontAttributeName];
        if (![font isEqual:cacheFont]) {
            atts = @{NSFontAttributeName: font,
                     NSParagraphStyleAttributeName: style};
        }
    }
    
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:atts
                              context:nil].size;
}

#pragma mark -
- (NSString *)cd_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedString];
}

- (NSString *)cd_base64DecodedString
{
    NSData *decodeData = [self cd_base64DecodedData];
    if (!decodeData) return nil;
    
    return [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
}

- (NSData *)cd_base64DecodedData
{
    return [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

- (NSString *)cd_md5String
{
    const char *cstr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, (CC_LONG)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark -

- (BOOL)cd_isValidUrl
{
    NSString *regex = @"[a-zA-z]+://[^\\s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (NSString *_Nonnull)cd_appendParamsWithKey:(NSString *_Nonnull)key value:(NSString *_Nonnull)value
{
    if (!key || !value) {
        return self;
    }
    
    return [self cd_appendParamsWithDictionary:@{key: value}];
}

- (NSString *_Nonnull)cd_appendParamsWithDictionary:(NSDictionary<NSString*, NSString*> *_Nonnull)queryDict
{
    if (!queryDict || ![queryDict isKindOfClass:[NSDictionary class]]) {
        return self;
    }
    
    NSURL *url = [NSURL URLWithString:self];
    if (!url) return self;
    
    NSString *queryStr = url.query;
    for (NSString *itemKey in [queryDict allKeys]) {
        NSString *itemValue = [queryDict valueForKey:itemKey];
        if (!itemKey || ![itemKey isKindOfClass:[NSString class]] || !itemValue) {
            continue;
        }
        
        NSString *queryItem = [NSString stringWithFormat:@"%@=%@", itemKey, itemValue];
        if (queryStr && queryStr.length > 0) {
            queryStr = [queryStr stringByAppendingFormat:@"&%@", queryItem];
        } else {
            queryStr = queryItem;
        }
    }
    
    NSRange range;
    if (url.query && url.query.length > 0) {
        range = [self rangeOfString:url.query];
    } else {
        if (url.fragment && url.fragment.length > 0) {
            NSRange tmpRange = [self rangeOfString:url.fragment];
            range = NSMakeRange(tmpRange.location - 1, 0);
        } else {
            range = NSMakeRange(self.length, 0);
        }
        
        queryStr = [NSString stringWithFormat:@"?%@", queryStr];
    }
    
    return [self stringByReplacingCharactersInRange:range withString:queryStr];
}

- (NSString *)cd_urlEncodedString
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 CFSTR("!*'();:@&=+$,/?%#[] "),
                                                                                 kCFStringEncodingUTF8);
}

- (NSString *)cd_urlDecodedString
{
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                 (CFStringRef)self,
                                                                                                 CFSTR(""),
                                                                                                 kCFStringEncodingUTF8);
}

#pragma mark -

+ (NSString *)cd_compareCurrentTime:(NSTimeInterval) compareDate
{
    NSDate *confromTimesp        = [NSDate dateWithTimeIntervalSince1970:compareDate/1000];
    
    NSTimeInterval  timeInterval = [confromTimesp timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    
    NSCalendar *calendar     = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents*referenceComponents=[calendar components:unitFlags fromDate:confromTimesp];
    //    NSInteger referenceYear  =referenceComponents.year;
    //    NSInteger referenceMonth =referenceComponents.month;
    //    NSInteger referenceDay   =referenceComponents.day;
    NSInteger referenceHour  =referenceComponents.hour;
    //    NSInteger referemceMinute=referenceComponents.minute;
    
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp= timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = timeInterval/3600) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if ((temp = timeInterval/3600/24)==1)
    {
        result = [NSString stringWithFormat:@"昨天%ld时",(long)referenceHour];
    }
    else if ((temp = timeInterval/3600/24)==2)
    {
        result = [NSString stringWithFormat:@"前天%ld时",(long)referenceHour];
    }
    
    else if((temp = timeInterval/3600/24) <31){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = timeInterval/3600/24/30) <12){
        result = [NSString stringWithFormat:@"%ld个月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

+ (NSString*)cd_getDateStringWithTimestamp:(NSTimeInterval)timestamp
{
    NSDate *confromTimesp    = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSCalendar *calendar     = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents*referenceComponents=[calendar components:unitFlags fromDate:confromTimesp];
    NSInteger referenceYear  =referenceComponents.year;
    NSInteger referenceMonth =referenceComponents.month;
    NSInteger referenceDay   =referenceComponents.day;
    
    return [NSString stringWithFormat:@"%ld年%ld月%ld日",referenceYear,(long)referenceMonth,(long)referenceDay];
}

+ (NSString*)cd_getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString*)formatter
{
    if ([NSString stringWithFormat:@"%@", @(timestamp)].length == 13) {
        timestamp /= 1000.0f;
    }
    NSDate*timestampDate=[NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *strDate = [dateFormatter stringFromDate:timestampDate];
    
    return strDate;
}

+ (NSString *)cd_readableStringWithNumber:(unsigned long)count
{
    NSString *readableStr = @"-";
    if (count <= 0) return readableStr;
    if (count < 10000) {
        readableStr = [NSString stringWithFormat:@"%zd", count];
    } else if (count < 100000000 && round(count/10000.f) < 10000) {
        readableStr = [NSString stringWithFormat:@"%.1f万", count/10000.f];
        readableStr = [readableStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else {
        readableStr = [NSString stringWithFormat:@"%.1f亿", count/100000000.f];
        readableStr = [readableStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    return readableStr;
}

@end
