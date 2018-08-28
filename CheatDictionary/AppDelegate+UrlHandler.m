//
//  AppDelegate+UrlHandler.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/28.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "AppDelegate+UrlHandler.h"
#import "CDRouter.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"

@implementation AppDelegate (UrlHandler)

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self application:application openURL:url options:@{}];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    if (sourceApplication)
        options[@"UIApplicationOpenURLOptionsSourceApplicationKey"] = sourceApplication;
    if (annotation) {
        options[@"UIApplicationOpenURLOptionsAnnotationKey"] = annotation;
    }
    return [self application:application openURL:url options:options];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    __block BOOL handled = [[CDRouter shared] pushUrl:url.absoluteString animated:NO];
    return handled;
}


- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    BOOL handled = NO;
    NSURL *url = nil;
    if ([shortcutItem.type isEqualToString:@"XXX"]) {
        url = [NSURL URLWithString:@"BundleId://xxx/"];
    } else {
        url = [NSURL URLWithString:@""];
    }
    handled = [self application:application openURL:url options:@{}];
    completionHandler(handled);
}

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType
{
    return YES;
}

- (BOOL)application:(nonnull UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray * __nullable))restorationHandle
{
    /// 传入的是iOS的 Universal Links
    if ([userActivity.activityType isEqualToString:@"NSUserActivityTypeBrowsingWeb"]) {
        NSURL *url = userActivity.webpageURL;
        return [self application:application openURL:url options:@{}];
    } else {
        return NO;
    }
}

@end

#pragma clang diagnostic pop
