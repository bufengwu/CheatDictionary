//
//  CDRouter.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/6.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDRouter.h"

@implementation CDRouter {
    UITabBarController *_tabBarController;
}

- (void)setTabBarController:(UITabBarController *)vc {
    _tabBarController = vc;
}


- (BOOL)pushUrl:(NSString *)url animated:(BOOL)animated {
    UIViewController *vc = [[HHRouter shared] matchController:url];
    if (!vc) {
        return NO;
    }
    if (vc.params[@"animation"]) {
        animated = [vc.params[@"animation"] boolValue];
    }
    [_tabBarController.selectedViewController pushViewController:vc animated:animated];
    return YES;
}

- (BOOL)presentUrl:(NSString *)url animated:(BOOL)animated {
    UIViewController *vc = [[HHRouter shared] matchController:url];
    if (!vc) {
        return NO;
    }
    if (vc.params[@"animation"]) {
        animated = [vc.params[@"animation"] boolValue];
    }
    [_tabBarController.selectedViewController presentViewController:vc animated:animated completion:nil];
    return YES;
}

@end
