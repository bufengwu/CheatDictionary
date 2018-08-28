//
//  CDDevice.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/22.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDDevice.h"
#import <UICKeyChainStore/UICKeyChainStore.h>

@implementation CDDevice

+ (BOOL)isFirstOpen {
    NSString *key = @"isFirst";
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:key];
    if (!isFirst) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return isFirst;
}

+ (BOOL)isFirstInstall {
    NSString *key = @"isFirst";
    NSString *isFirst = [[UICKeyChainStore keyChainStore] stringForKey:key];
    if (![isFirst length]) {
        [[UICKeyChainStore keyChainStore] setString:key forKey:key];
        return NO;
    }
    return YES;
}

@end
