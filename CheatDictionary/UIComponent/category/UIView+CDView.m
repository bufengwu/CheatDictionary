//
//  UIView+CDView.m
//  CheatDictionary
//
//  Created by zzy on 2018/9/7.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "UIView+CDView.h"

@implementation UIView (CDView)

- (BOOL)isShowingOnKeyWindow
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 把这个view在它的父控件中的frame(即默认的frame)转换成在window的frame
    CGRect convertFrame = [self.superview convertRect:self.frame toView: keyWindow];
    CGRect windowBounds = keyWindow.bounds;
    // 判断这个控件是否在主窗口上（即该控件和keyWindow有没有交叉）
    BOOL isOnWindow = CGRectIntersectsRect(convertFrame, windowBounds);
    // 再判断这个控件是否真正显示在窗口范围内（是否在窗口上，是否为隐藏，是否透明）
    BOOL isShowingOnWindow = (self.window == keyWindow) && !self.isHidden && (self.alpha > 0.01) && isOnWindow;
    return isShowingOnWindow;
}

@end
