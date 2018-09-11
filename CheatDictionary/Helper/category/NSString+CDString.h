//
//  NSString+CDString.h
//  CheatDictionary
//
//  Created by zzy on 2018/9/6.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CDString)

/**
 对字符串中特殊的字符进行编码/转义
 https://zh.wikipedia.org/wiki/%E7%99%BE%E5%88%86%E5%8F%B7%E7%BC%96%E7%A0%81
 
 @return 编码后的字符串
 */
- (NSString *)cd_urlEncodedString;

/**
 对字符串中的百分号编码进行解码
 
 @return 解码后的字符串
 */
- (NSString *)cd_urlDecodedString;

/**
 对字符串进行base64编码
 https://zh.wikipedia.org/wiki/Base64
 string -> encode string
 
 @return 编码后的字符串
 */
- (NSString *)cd_base64EncodedString;

/**
 对字符串进行base64解码
 string -> decode string
 
 @return 解码后的字符串
 */
- (NSString *)cd_base64DecodedString;

/**
 对字符串进行base64解码
 string -> decode data
 
 @return 解码后的data
 */
- (NSData *)cd_base64DecodedData;

- (NSString *)cd_md5String;

#pragma mark -

/**
 校验string是否为有效URL
 
 @return YES为有效URL；NO为无效URL
 */
- (BOOL)cd_isValidUrl;

/**
 对String进行单个参数拼接，遵循URL path规范
 eg: path?key=value#fragment
 
 @param key key不允许为空
 @param value value不允许为空
 @return 返回拼接参数后的链接
 */
- (NSString *)cd_appendParamsWithKey:(NSString *)key value:(NSString *)value;

/**
 对String进行多个参数拼接，遵循URL path规范 (内部不做任何编码转换)
 eg: path?key=value#fragment
 
 @param queryDict 参数字典，key和value不允许为空
 @return 返回拼接参数后的链接
 */
- (NSString *)cd_appendParamsWithDictionary:(NSDictionary<NSString*, NSString*> *)queryDict;

#pragma mark -


/**
 获取字符串的字符长度，包含中英文
 
 @return 字符长度
 */
- (NSUInteger)cd_unicharLength;

/**
 根据字体及宽度计算字符串的占位大小
 
 @param font 字体大小，建议使用 BFCFont 统一字体
 @param width 限定宽度，获取实际高度
 @return 字符串实际的占位大小
 */
- (CGSize)cd_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width;

/**
 根据字体及高度计算字符串的占位大小
 
 @param font 字体大小，建议使用 BFCFont 统一字体
 @param height 限定高度，获取实际宽度
 @return 字符串实际的占位大小
 */
- (CGSize)cd_sizeWithFont:(UIFont *)font forHeight:(CGFloat)height;

/**
 根据字体及高度计算字符串的占位大小
 
 @param font 字体大小，建议使用 BFCFont 统一字体
 @param size 限定尺寸，获取实际大小
 @return 字符串实际的占位大小
 */
- (CGSize)cd_sizeWithFont:(UIFont *)font forSize:(CGSize)size;

#pragma mark -

/**
 通过时间戳计算时间差（几小时前、几天前
 
 @param compareDate 待转换的时间戳
 @return @"%ld小时前"
 */
+ (NSString *)cd_compareCurrentTime:(NSTimeInterval)compareDate;

/**
 通过时间戳得出对应的时间
 
 @param timestamp 时间戳
 @return @"@"%ld年%ld月%ld日"
 */
+ (NSString *)cd_getDateStringWithTimestamp:(NSTimeInterval)timestamp;

/**
 通过时间戳和formatter 显示格式化时间字符串
 @param timestamp 时间戳
 @param formatter 格式
 @return 时间字符串
 */
+ (NSString *)cd_getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString *)formatter;

/**
 将数值转换为可读数值字符串
 eg:
 2233 -> 2233
 22333 ->  2.2万
 2233322333 -> 22.3亿
 
 @param count 长整型数值
 @return 可读数值字符串
 */
+ (NSString *)cd_readableStringWithNumber:(unsigned long)count;

@end
