//
//  AppDelegate+PushService.h
//  CheatDictionary
//
//  Created by zzy on 2018/8/28.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (PushService)

- (void)registerNotification;

- (void)receivedRemoteNotificationFromColdBoot:(NSDictionary *)dictionary;

@end
