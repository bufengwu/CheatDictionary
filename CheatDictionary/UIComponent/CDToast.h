//
//  CDToast.h
//  CheatDictionary
//
//  Created by zzy on 2018/8/23.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDToast : NSObject

+ (instancetype)sharedStyle;

+ (void)showBottomToast:(NSString *)message; // show toast at top (centerY = 0.8 * viewHeight) of view, for specified scenario
+ (void)showCenterToast:(NSString *)message; // show toast at center of view, for normal scenario
+ (void)showTopToast:(NSString *)message; // show toast at top (centerY = 0.2 * viewHeight) of view, for keyboard scenario
+ (void)showToast:(NSString *)message withOffsetFromCenter:(CGPoint)offset;

+ (void)showBottomToastWithCustomView:(UIView*)viewForToast afterDismissed:(void(^)(BOOL didTappped))complete;

+ (void)showLoading;
+ (void)hideLoading;

@end
