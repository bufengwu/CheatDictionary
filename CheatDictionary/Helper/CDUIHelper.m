//
//  CDUIHelper.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/27.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDUIHelper.h"

@implementation CDUIHelper

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


+ (UIImage *)circleRandColorImageWithRadius:(CGFloat)radius {
    return [self circleImage:[self imageWithColor:[UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1] radius:radius]];
}


+ (UIImage *)imageWithColor:(UIColor *)color radius:(CGFloat)radius {
    CGRect rect = CGRectMake(0.0f, 0.0f, radius, radius);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)circleImage:(UIImage *)srcImage {
    //获取图片尺寸
    CGSize size = srcImage.size;
    //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //创建圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    //设置为裁剪区域
    [path addClip];
    //绘制图片
    [srcImage drawAtPoint:CGPointZero];
    //获取裁剪后的图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

+ (void)setButtonContentCenter:(UIButton *)btn {
    CGFloat padding = 15;                           //用于指定文本和图片的间隔值。
    CGFloat btnWidth = btn.bounds.size.width;       //按钮控件的宽度
    CGFloat btnHeight = btn.bounds.size.height;     //按钮控件的高度
    
    CGSize titleSize = btn.titleLabel.bounds.size;  //文本控件在按钮中的frame值。
    CGSize imageSize = btn.imageView.bounds.size;   //图片控件在按钮中的frame值。
    CGFloat totalHeight= titleSize.height + padding + imageSize.height;  //图文上下布局时所占用的总高度，注意这里也算上他们之间的间隔值padding
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsMake(-(btnHeight-totalHeight)/2,
                                                    (btnWidth-imageSize.width)/2,
                                                    0,
                                                    (btnWidth-imageSize.width)/2);
    
    UIEdgeInsets titleEdgeInsets = UIEdgeInsetsMake((btnHeight-totalHeight)/2+padding,
                                                    -(btnWidth-titleSize.width)/2-padding/2,
                                                    -(btnHeight-totalHeight)/2,
                                                    0);
    [btn setImageEdgeInsets:imageEdgeInsets];
    [btn setTitleEdgeInsets:titleEdgeInsets];
}
@end
