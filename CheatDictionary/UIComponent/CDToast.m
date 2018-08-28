//
//  CDToast.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/23.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDToast.h"
#import "TopmostView.h"
#import "UIView+Layout.h"
#import "Toast/UIView+Toast.h"

@implementation CDToast

static CDToast *CDToast_;
static CSToastStyle *sharedStyle_;

+ (instancetype)sharedStyle
{
    if (!CDToast_) {
        if (!sharedStyle_) {
            sharedStyle_ = [[CSToastStyle alloc] initWithDefaultStyle];
            sharedStyle_.titleFont = [UIFont systemFontOfSize:16];
            sharedStyle_.messageFont = [UIFont systemFontOfSize:16];
            sharedStyle_.cornerRadius = 8;
            sharedStyle_.horizontalPadding = 12;
            sharedStyle_.verticalPadding = 12;
        }
        
        [CSToastManager setTapToDismissEnabled:NO];
        [CSToastManager setSharedStyle:sharedStyle_];
        [CSToastManager setDefaultDuration:2];
        [CSToastManager setDefaultPosition:CSToastPositionCenter];
        [CSToastManager setQueueEnabled:NO];
    }
    return CDToast_;
}

+ (void)showCenterToast:(NSString *)message
{
    NSAssert([NSThread isMainThread], @"toast has been called on main thread");
    [[TopmostView viewForApplicationWindow] makeToast:message duration:[CSToastManager defaultDuration] position:CSToastPositionCenter];
}

+ (void)showTopToast:(NSString *)message
{
    NSAssert([NSThread isMainThread], @"toast has been called on main thread");
    TopmostView *topmostView = [TopmostView viewForApplicationWindow];
    CGPoint position = CGPointMake(topmostView.tz_width * 0.5, topmostView.tz_height * 0.2);
    [topmostView makeToast:message duration:[CSToastManager defaultDuration] position:[NSValue valueWithCGPoint:position]];
}

+ (void)showBottomToast:(NSString *)message
{
    NSAssert([NSThread isMainThread], @"toast has been called on main thread");
    TopmostView *topmostView = [TopmostView viewForApplicationWindow];
    CGPoint position = CGPointMake(topmostView.tz_width * 0.5, topmostView.tz_height * 0.8);
    [topmostView makeToast:message duration:[CSToastManager defaultDuration] position:[NSValue valueWithCGPoint:position]];
}

+ (void)showToast:(NSString *)message withOffsetFromCenter:(CGPoint)offset
{
    NSAssert([NSThread isMainThread], @"toast has been called on main thread");
    TopmostView *topmostView = [TopmostView viewForApplicationWindow];
    CGPoint position = topmostView.center;
    position.x += offset.x;
    position.y += offset.y;
    [topmostView makeToast:message duration:[CSToastManager defaultDuration] position:[NSValue valueWithCGPoint:position]];
}

+ (void)showBottomToastWithCustomView:(UIView *)viewForToast afterDismissed: (void(^)(BOOL didTappped))complete
{
    __block TopmostView* topmostView = [TopmostView viewForApplicationWindow];
    topmostView.userInteractionEnabled = YES;
    CGPoint position = CGPointMake(topmostView.tz_width * 0.5, topmostView.tz_height * 0.8);
    [topmostView showToast:viewForToast duration:[CSToastManager defaultDuration] position:[NSValue valueWithCGPoint:position] completion:^(BOOL didTap) {
        if (complete) {
            complete(didTap);
        }
        topmostView.userInteractionEnabled = NO;
    }];
}

+ (void)showLoading
{
    NSAssert([NSThread isMainThread], @"toast has been called on main thread");
    TopmostView *topmostView = [TopmostView viewForApplicationWindow];
    topmostView.userInteractionEnabled = YES;
    topmostView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [topmostView makeToastActivity:CSToastPositionCenter];
}

+ (void)hideLoading
{
    NSAssert([NSThread isMainThread], @"toast has been called on main thread");
    TopmostView *topmostView = [TopmostView viewForApplicationWindow];
    [topmostView hideToastActivity];
    topmostView.backgroundColor = [UIColor clearColor];
    topmostView.userInteractionEnabled = NO;
}

@end
