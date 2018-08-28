//
//  CDAlert.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/24.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBigAlertView.h"
#import <BlocksKit/BlocksKit+UIKit.h>

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@implementation CDBigAlertView

#pragma mark - 显示只有确定按钮的弹窗

+ (instancetype)alertWithTile:(NSString *)title
                      message:(NSString *)message
           confirmButtonTitle:(NSString *)confirmButtonTitle
               confirmHandler:(dispatch_block_t)confirmHandler {
    
    CDBigAlertView *backView = [[CDBigAlertView alloc] init];
    backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    backView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    
    UIImage *whiteImage = [UIImage imageNamed:@"big_alert_bg"];
    CGFloat P = whiteImage.size.width/whiteImage.size.height;
    
    UIImageView *whiteImg = [[UIImageView alloc]init];
    whiteImg.image = whiteImage;
    whiteImg.userInteractionEnabled = YES;
    [backView addSubview:whiteImg];
    [whiteImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenW * 0.75, ScreenW * 0.75/P));
        make.centerY.equalTo(backView.mas_centerY).multipliedBy(0.9);
        make.centerX.equalTo(backView.mas_centerX);
    }];
    
    
    UILabel *name = [[UILabel alloc]init];
    name.text = title;
    name.textColor = HEXCOLOR(0xffffff);
    name.font = [UIFont systemFontOfSize:17];
    [whiteImg addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.centerX.equalTo(whiteImg.mas_centerX);
        make.centerY.equalTo(whiteImg.mas_top).offset(20);
    }];
    
    
    UIImage *btnImg = [UIImage imageNamed:@"big_alert_btn"];
    CGFloat btnP = btnImg.size.width/btnImg.size.height;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:confirmButtonTitle forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button setBackgroundImage:btnImg forState:UIControlStateNormal];
    [button setBackgroundImage:btnImg forState:UIControlStateHighlighted];
    
    [button bk_addEventHandler:^(id sender) {
        if (confirmHandler) {
            confirmHandler();
        }
         [backView removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    
    button.layer.cornerRadius = 7;
    button.layer.masksToBounds = YES;
    [whiteImg addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenW * 0.6, ScreenW * 0.6/btnP));
        make.bottom.equalTo(whiteImg.mas_bottom).offset(-30);
        make.centerX.equalTo(whiteImg.mas_centerX);
    }];
    
    UILabel *detailLab = [[UILabel alloc]init];
    
    detailLab.textColor = HEXCOLOR(0x323232);
    detailLab.font = [UIFont systemFontOfSize:17];
    detailLab.numberOfLines = 0;
    detailLab.text = message;
    detailLab.textAlignment = NSTextAlignmentLeft;
    [whiteImg addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteImg.mas_left).offset(20);
        make.right.equalTo(whiteImg.mas_right).offset(-20);
        make.bottom.equalTo(whiteImg.mas_centerY).multipliedBy(1.4);
        make.top.equalTo(whiteImg.mas_centerY).multipliedBy(0.4);
    }];
    return backView;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview: self];
}

@end
