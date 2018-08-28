//
//  UIImage+CDImage.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/28.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CDImage)

- (UIImage *)tintImageWithColor:(UIColor *)tintColor;

+ (UIImage *)imageWithColor:(UIColor *)color height:(CGFloat)height;

@end
