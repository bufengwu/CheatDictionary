//
//  UIImage+CDImage.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/28.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, CDImageCornerType) {
    CDImageCornerTypeNone     = 0,
    CDImageCornerTypeTopLeft  = 1 << 0,
    CDImageCornerTypeTopRight = 1 << 1,
    CDImageCornerTypeBtmLeft  = 1 << 2,
    CDImageCornerTypeBtmRight = 1 << 3,
    CDImageCornerTypeLeft     = CDImageCornerTypeTopLeft | CDImageCornerTypeBtmLeft,
    CDImageCornerTypeRight    = CDImageCornerTypeTopRight | CDImageCornerTypeBtmRight,
    CDImageCornerTypeTop      = CDImageCornerTypeTopLeft | CDImageCornerTypeTopRight,
    CDImageCornerTypeBtm      = CDImageCornerTypeBtmLeft | CDImageCornerTypeBtmRight,
    CDImageCornerTypeAll      = CDImageCornerTypeTop | CDImageCornerTypeBtm
};

@interface UIImage (CDImage)

/**
 从指定Bundle中加载对应名称的图片
 
 @param name 对应bundle中的图片名称，可以省略图片后缀名
 @param bundleIdentifier 对应资源包的名称
 @return 返回bundle中对应的图片
 */
+ (UIImage *)cd_imageNamed:(NSString *)name withBundleIdentifier:(NSString *)bundleIdentifier;

/**
 将图片压缩成二进制格式数据
 大于2M将以自身质量的0.8进行压缩，小于2M大于1M将以自身质量的0.9进行压缩，直到图片质量小于1M
 
 @return 返回图片压缩后的二进制格式数据
 */
- (NSData *)cd_compressedData;

/**
 重置图片的尺寸
 绘制时触发重置图片操作：拉伸/压缩图片的左右/上下同等比例
 
 @param left 左右同等宽度
 @param top 上下同等高度
 @return 返回重置后尺寸后的新图片
 */
- (UIImage *)cd_resizableImageWithLeft:(CGFloat)left top:(CGFloat)top;

#pragma mark -

+ (UIImage *)cd_imageWithColor:(UIColor *)color;

/**
 通过颜色创建图像对象
 
 @param color 图片颜色
 @param size 图片尺寸
 @return 返回绘制后的图片对象
 */
+ (UIImage *)cd_imageWithColor:(UIColor *)color
                           size:(CGSize)size;

+ (UIImage *)cd_imageWithColor:(UIColor *)color
                  concernRadius:(CGFloat)radius;

/**
 通过颜色创建图像图像，并可配置边框颜色和圆角半径
 获取图像对象时优先从缓存中通过key进行查找，若缓存未命中则进行图像的绘制并加入到缓存中
 缓存中key的拼接规则：[color]-[bdColor]-[radius]，若其中单项没有则不拼接
 
 @param color 图片颜色
 @param bdColor 边框颜色
 @param radius 图片圆角半径
 @return 返回会之后的图片对象
 */
+ (UIImage *)cd_imageWithColor:(UIColor *)color
                    borderColor:(UIColor *)bdColor
                  concernRadius:(CGFloat)radius;


+ (UIImage *)cd_concernImageWithColor:(UIColor *)color
                                  size:(CGSize)size
                         concernRadius:(CGFloat)radius;

+ (UIImage *)cd_concernImageWithColor:(UIColor *)color
                                  size:(CGSize)size
                           borderColor:(UIColor *)bdColor
                         concernRadius:(CGFloat)radius;

/**
 通过颜色创建圆角图像对象，并可以配置图像的属性
 获取图像对象时优先从缓存中通过key进行查找，若缓存未命中则进行图像的绘制并加入到缓存中
 缓存中key的拼接规则：corner-[size]-[type]-[color]-[bdWidth]-[bdColor]-[radius]，若其中单项没有则不拼接
 
 @param color 图片颜色，为UIColor的十六进制字符串
 @param size 图片尺寸，默认宽高为10
 @param bdColor 边框颜色
 @param bdWidth 边框宽度
 @param radius 图片圆角半径
 @param type 绘制的图片圆角类型，默认为CDImageCornerTypeNone
 @return 返回绘制后的图片对象
 */
+ (UIImage *)cd_concernImageWithColor:(UIColor *)color
                                  size:(CGSize)size
                           borderColor:(UIColor *)bdColor
                           borderWidth:(CGFloat)bdWidth
                          cornerRadius:(CGFloat)radius
                            cornerType:(CDImageCornerType)type;

#pragma mark -

/**
 改变图片颜色，默认采用kCGBlendModeDestinationIn
 kCGBlendModeDestinationIn，保留透明度信息
 
 @param tintColor 绘制的色彩颜色
 @return 绘制后的新图像
 */
- (UIImage *)cd_imageWithTintColor:(UIColor *)tintColor;

/**
 改变图片颜色，默认采用kCGBlendModeOverlay，并保持透明度信息
 kCGBlendModeOverlay，保留灰度信息
 kCGBlendModeDestinationIn，保留透明度信息
 
 @param tintColor 绘制的色彩颜色
 @return 绘制后的新图像
 */
- (UIImage *)cd_imageWithGradientTintColor:(UIColor *)tintColor;

#pragma mark - 二维码

/*
 解析图片中的二维码，默认获取第一个识别的二维码内容。
 */
- (NSString * __nullable)cd_decodeQRCode;

/*
 解析图片中的二维码，返回图中能识别的所有二维码内容。
 */
- (NSArray<NSString *> * __nonnull)cd_decodeQRCodes;

@end
