//
//  AppDelegate+PushService.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/28.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "AppDelegate+PushService.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"

#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate (PushService)

- (void)registerNotification {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"notification  center open success");
            } else {
                NSLog(@"%@", error);
            }
        }];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

- (void)registerForRemoteNotificationWithDeviceToken:(NSData*)deviceToken {
    NSMutableString *deviceTokenString = [NSMutableString stringWithCapacity:([deviceToken length] * 2)];
    const unsigned char *dataBuffer = [deviceToken bytes];
    NSString *cd = [[NSString alloc] initWithBytes:dataBuffer length:deviceToken.length encoding:NSUTF8StringEncoding];
    if ([cd isEqualToString:@"00000000-0000-0000-0000-000000000000"] || [cd isEqualToString:@"00000000000000000000000000000000"]) {
        deviceTokenString = nil;
        return;
    } else {
        for (int i = 0; i < [deviceToken length]; ++i) {
            [deviceTokenString appendFormat:@"%02lx", (unsigned long)dataBuffer[i]];
        }
    }
    NSLog(@"%@", deviceTokenString);
}

- (void)receivedRemoteNotificationFromHotBoot:(NSDictionary *)userInfo {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    if (userInfo && [userInfo isKindOfClass:[NSDictionary class]]) {

    }
}

- (void)receivedRemoteNotificationFromColdBoot:(NSDictionary *)dictionary {
    if (dictionary != nil) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

#pragma mark -

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    [self registerForRemoteNotificationWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"%@", error);
}

#pragma mark - ios10以前本地通知响应
- (void)application:(UIApplication *)application didReceiveLocalNotification:(nonnull UILocalNotification *)notification {
    [self receivedRemoteNotificationFromHotBoot:notification.userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive) {
        // will be ignored when triggered by cold bot
        [self receivedRemoteNotificationFromHotBoot:userInfo];
    }
}

#pragma mark - after iOS10
#pragma mark - ios10以后本地通知响应
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]] && [UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        completionHandler(0);
    } else {
        completionHandler(UNNotificationPresentationOptionAlert | UIUserNotificationTypeSound);
    }
}

#pragma mark - ios10以后本地通知点击
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    // will be ignored when triggered by cold bot
    [self receivedRemoteNotificationFromHotBoot:response.notification.request.content.userInfo];
    completionHandler();
}

@end
#pragma clang diagnostic pop
