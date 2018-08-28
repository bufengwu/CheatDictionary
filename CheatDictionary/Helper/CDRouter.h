//
//  CDRouter.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/6.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <HHRouter/HHRouter.h>

@interface CDRouter : HHRouter

- (void)setTabBarController:(UITabBarController *)vc;

- (BOOL)pushUrl:(NSString *)url animated:(BOOL)animated;

- (BOOL)presentUrl:(NSString *)url animated:(BOOL)animated;

@end
