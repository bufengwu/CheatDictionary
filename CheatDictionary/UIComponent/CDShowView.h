//
//  HHShowView.h
//  Alert
//
//  Created by 花花 on 2017/12/9.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>

//按钮
typedef NS_ENUM(NSUInteger, HHAlertActionStyle) {
    HHAlertActionCancel, //取消
    HHAlertActionConfirm, //确认
    
};
@interface CDAlertAction:NSObject

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) HHAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@property(nonatomic,copy)void(^handler)(CDAlertAction *);
+ (instancetype)actionTitle:(NSString *)title style:(HHAlertActionStyle)style handler:(void(^)(CDAlertAction *action))handler;

@end

@interface CDShowView : UIView

//btn Color
@property(nonatomic,strong)UIColor *butttonCancelBgColor;
@property(nonatomic,strong)UIColor *butttonConfirmBgColor;

+ (instancetype)alertTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
        confirmButtonTitle:(NSString *)confirmButtonTitle
             cancelHandler:(dispatch_block_t)cancelHandler
            confirmHandler:(dispatch_block_t)confirmHandler;

- (void)show;

- (void)hide;

@end


