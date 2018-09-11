//
//  UIImage+CDImage.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/28.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "UIImage+CDImage.h"

NSString *hexStringFromColor(UIColor *color)
{
    if (!color) return @"";
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = 0, g = 0, b = 0;
    size_t len = CGColorGetNumberOfComponents(color.CGColor);
    if (len > 0) {
        r = components[0];
    }
    if (len > 1) {
        g = components[1];
    }
    if (len > 2) {
        b = components[2];
    }
    
    NSString *temp = [NSString stringWithFormat:@"#%02lX%02lX%02lX",
                      lroundf(r * 255.f),
                      lroundf(g * 255.f),
                      lroundf(b * 255.f)];
    return temp;
}

@implementation UIImage (CDImage)

+ (UIImage *)cd_imageNamed:(NSString *)name withBundleIdentifier:(NSString *)bundleIdentifier
{
    if (!name || name.length <= 0 ||
        !bundleIdentifier || bundleIdentifier.length <= 0) {
        return nil;
    }
    
    NSBundle *bundle = [NSBundle bundleWithIdentifier:bundleIdentifier];
    if (!bundle) {
        return nil;
    }
    
    return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
}

- (NSData *)cd_compressedData
{
    CGFloat quality = 1.0f;
    NSData *imgData = UIImageJPEGRepresentation(self, quality);
    while (imgData.length > 1024.f * 1024.f) {
        if (imgData.length > 2048.f * 1024.f) {
            quality = quality * 0.8f;
        } else {
            quality = quality * 0.9f;
        }
        imgData = UIImageJPEGRepresentation(self, quality);
    }
    return imgData;
}

- (UIImage *)cd_resizableImageWithLeft:(CGFloat)left top:(CGFloat)top
{
    UIImage *newImg = nil;
    if ([self respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, self.size.height - top - 1.f, self.size.width - left - 1.f);
        newImg = [self resizableImageWithCapInsets:insets];
    } else {
        newImg = [self stretchableImageWithLeftCapWidth:left topCapHeight:top];
    }
    return newImg;
}

#pragma mark -

+ (UIImage *)cd_imageWithColor:(UIColor *)color
{
    return [self cd_imageWithColor:color size:CGSizeMake(1.f, 1.f)];
}

+ (UIImage *)cd_imageWithColor:(UIColor *)color
                           size:(CGSize)size
{
    if (CGSizeEqualToSize(size, CGSizeZero)) return nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)cd_imageWithColor:(UIColor *)color
                  concernRadius:(CGFloat)radius
{
    return [self cd_imageWithColor:color borderColor:nil concernRadius:radius];
}

+ (UIImage *)cd_imageWithColor:(UIColor *)color
                    borderColor:(UIColor *)bdColor
                  concernRadius:(CGFloat)radius
{
    NSAssert([NSThread isMainThread], @"defulat image creater must in main thread");
    
    static NSCache *cache;
    if (!cache) {
        cache = [NSCache new];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:^(NSNotification * __unused notification) {
                                                          [cache removeAllObjects];
                                                      }];
    }
    
    NSString *key = [NSString stringWithFormat:@"%@", hexStringFromColor(color)];
    if (bdColor) {
        key = [key stringByAppendingFormat:@"-%@", hexStringFromColor(bdColor)];
    }
    if (radius > 0) {
        key = [key stringByAppendingFormat:@"-%f", radius];
    }
    
    UIImage *image = [cache objectForKey:key];
    if (!image) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(radius * 2, radius * 2), NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        
        if (bdColor) {
            CGContextSetStrokeColorWithColor(context, bdColor.CGColor);
        }
        
        CGContextSaveGState(context);
        CGContextFillEllipseInRect(context, CGRectMake(0, 0, radius * 2, radius * 2));
        CGContextRestoreGState(context);
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (image) {
            [cache setObject:image forKey:key];
        }
    }
    
    return image;
}

+ (UIImage *)cd_concernImageWithColor:(UIColor *)color
                                  size:(CGSize)size
                         concernRadius:(CGFloat)radius
{
    return [self cd_concernImageWithColor:color
                                      size:size
                               borderColor:nil
                             concernRadius:radius];
}

+ (UIImage *)cd_concernImageWithColor:(UIColor *)color
                                  size:(CGSize)size
                           borderColor:(UIColor *)bdColor
                         concernRadius:(CGFloat)radius
{
    return [self cd_concernImageWithColor:color
                                      size:size
                               borderColor:bdColor
                               borderWidth:0
                              cornerRadius:radius
                                cornerType:CDImageCornerTypeAll];
}

+ (UIImage *)cd_concernImageWithColor:(UIColor *)color
                                  size:(CGSize)size
                           borderColor:(UIColor *)bdColor
                           borderWidth:(CGFloat)bdWidth
                          cornerRadius:(CGFloat)radius
                            cornerType:(CDImageCornerType)type
{
    NSAssert([NSThread isMainThread], @"defulat image creater must in main thread");
    
    size.width = size.width ?: 10.f;
    size.height= size.height ?: 10.f;
    radius = MIN(radius, MIN(size.width, size.height) / 2);
    
    static NSCache *cache;
    if (!cache) {
        cache = [NSCache new];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:^(NSNotification * __unused notification) {
                                                          [cache removeAllObjects];
                                                      }];
    }
    
    NSString *key = [NSString stringWithFormat:@"corner-%@", NSStringFromCGSize(size)];
    if (type != CDImageCornerTypeNone) {
        key = [key stringByAppendingFormat:@"-%ld", (long)type];
    }
    if (color) {
        key = [key stringByAppendingFormat:@"-%@", hexStringFromColor(color)];
    }
    if (bdWidth) {
        key = [key stringByAppendingFormat:@"-%f", bdWidth];
    }
    if (bdColor) {
        key = [key stringByAppendingFormat:@"-%@", hexStringFromColor(bdColor)];
    }
    if (radius > 0) {
        key = [key stringByAppendingFormat:@"-%f", radius];
    }
    
    UIImage *image = [cache objectForKey:key];
    if (!image) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        if (bdWidth) {
            CGContextSetLineWidth(context, bdWidth);
        }
        CGContextSaveGState(context);
        
        if (bdColor) {
            CGContextSetStrokeColorWithColor(context, bdColor.CGColor);
            CGContextMoveToPoint(context, 0, radius);
            CGContextAddArc(context, radius, radius, radius, M_PI, 3 * M_PI_2, 0);
            CGContextAddArc(context, size.width - radius, radius, radius, 3 * M_PI_2, 0, 0);
            CGContextAddArc(context, size.width - radius, size.height - radius, radius, 0, M_PI_2, 0);
            CGContextAddArc(context, radius, size.height - radius, radius, M_PI_2, M_PI, 0);
            CGContextClosePath(context);
            CGContextStrokePath(context);
            CGContextRestoreGState(context);
        }
        
        if (type & CDImageCornerTypeTopLeft) {
            CGContextSaveGState(context);
            CGContextMoveToPoint(context, radius, 0);
            CGContextAddLineToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, 0, radius);
            CGContextAddArc(context, radius, radius, radius, M_PI, 3 * M_PI_2, 0);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
        }
        
        if (type & CDImageCornerTypeTopRight) {
            CGContextSaveGState(context);
            CGContextMoveToPoint(context, size.width - radius, 0);
            CGContextAddLineToPoint(context, size.width, 0);
            CGContextAddLineToPoint(context, size.width, radius);
            CGContextAddArc(context, size.width - radius, radius, radius, 0, 3 * M_PI_2, 1);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
        }
        
        if (type & CDImageCornerTypeBtmLeft) {
            CGContextSaveGState(context);
            CGContextMoveToPoint(context, 0, size.height - radius);
            CGContextAddLineToPoint(context, 0, size.height);
            CGContextAddLineToPoint(context, radius, size.height);
            CGContextAddArc(context, radius, size.height - radius, radius, M_PI_2, M_PI, 0);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
        }
        
        if (type & CDImageCornerTypeBtmRight) {
            CGContextSaveGState(context);
            CGContextMoveToPoint(context, size.width-radius, size.height);
            CGContextAddLineToPoint(context, size.width, size.height);
            CGContextAddLineToPoint(context, size.width, size.height - radius);
            CGContextAddArc(context, size.width - radius, size.height - radius, radius, 0, M_PI_2, 0);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
        }
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (image) {
            [cache setObject:image forKey:key];
        }
    }
    
    return image;
}

#pragma mark -

- (UIImage *)cd_imageWithTintColor:(UIColor *)tintColor
{
    return [self cd_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)cd_imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self cd_imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)cd_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

#pragma mark -

- (NSString * __nullable)cd_decodeQRCode {
    NSArray *contentArr = [self cd_decodeQRCodes];
    
    return contentArr.count > 0 ? contentArr[0] : nil;
}

- (NSArray<NSString *> * __nonnull)cd_decodeQRCodes {
    NSMutableArray<NSString *> *contentArr = [NSMutableArray arrayWithCapacity:3];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:self.CGImage]];
    [features enumerateObjectsUsingBlock:^(CIQRCodeFeature* _Nonnull feature, NSUInteger idx, BOOL * _Nonnull stop) {
        if (feature.messageString) {
            [contentArr addObject:feature.messageString];
        }
    }];
    
    return [contentArr copy];
}

@end
