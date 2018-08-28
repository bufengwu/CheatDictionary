//
//  CDUIHelper.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/27.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SecondaryNavbarTitleNormal RGB(144, 125, 82)
#define SecondaryNavbarTitleSelected RGB(255, 223, 142)
#define SecondaryNavbarSelectedRed  RGB(173, 34, 10)

#define NavbarColor RGB(32, 31, 27)
#define SecondaryNavbarColor RGB(32, 27, 22)
#define TabBarColor RGB(31, 26, 16)

#define NavbarTitleColor RGB(254, 226, 154)
#define TabBarTitleColorNormal RGB(181, 155, 116)

#define CollectViewBG RGB(213, 201, 176)
#define CollectCellBG RGB(198, 182, 151)
#define MainSeparatorColor RGB(186, 175, 155)

#define CollectCellBorderColor RGB(181, 168, 145)

#define SectionHeaderTitleColor RGB(107, 91, 75)

@interface CDUIHelper : NSObject
//+ (UIImage *)imageWithColor:(UIColor *)color radius:(CGFloat)radius;

//+ (UIImage *)circleImage:(UIImage *)srcImage;

+ (void) setButtonContentCenter:(UIButton *)button;


/**
 生成一个随机颜色的圆形图片
 
 @param radius 直径
 @return 图片
 */
+ (UIImage *)circleRandColorImageWithRadius:(CGFloat)radius;

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;


@end
