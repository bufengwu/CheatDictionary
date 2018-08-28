//
//  CDApiClient.h
//  CheatDictionary
//
//  Created by zzy on 2018/7/17.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDApiClient : NSObject

+ (void)POST:(NSString *)url  payload:(NSDictionary *)payload success:(void(^)(id))success failure:(void(^)(NSInteger code, NSString *message))failure;

+ (void)GET:(NSString *)url success:(void (^)(id))success failure:(void (^)(NSInteger, NSString *))failure;

@end
