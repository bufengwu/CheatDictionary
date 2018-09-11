//
//  CDAlert.h
//  CheatDictionary
//
//  Created by zzy on 2018/8/24.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 CDBigAlertView *alert = [CDBigAlertView alertWithTile:@"提示" message:@"time" confirmButtonTitle:@"确认" confirmHandler:^{
 NSLog(@"xxxxx");
 }];
 [alert show];
 
*/
@interface CDBigAlertView : UIView

+ (instancetype)alertWithTile:(NSString *)title
                      message:(NSString *)message
           confirmButtonTitle:(NSString *)confirmButtonTitle
               confirmHandler:(dispatch_block_t)confirmHandler;

- (void)show;

@end
