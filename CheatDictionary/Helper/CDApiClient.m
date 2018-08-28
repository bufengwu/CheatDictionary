//
//  CDApiClient.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/17.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDApiClient.h"
#import <AFNetworking/AFNetworking.h>

static const NSString *const baseURL = @"http://pskd.uusama.com/api/";

@implementation CDApiClient

+ (void)POST:(NSString *)url payload:(NSDictionary *)payload success:(void (^)(id))success failure:(void (^)(NSInteger, NSString *))failure {
    NSString *fillURL = [baseURL stringByAppendingString:url];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:payload];
    
    dic[@"lang"] = @"zh";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager POST:fillURL
                              parameters:dic
                                progress:^(NSProgress * _Nonnull uploadProgress) {
                                    
                                }
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     NSLog(@"%@ ----> %@", fillURL, responseObject);
                                     if (success) {
                                         success(responseObject);
                                     }
                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     NSLog(@"%@ ----> %@", fillURL, error.localizedDescription);
                                     if (failure) {
                                         failure(error.code, error.localizedDescription);
                                     }
                                 }];
}
    
+ (void)GET:(NSString *)url success:(void (^)(id))success failure:(void (^)(NSInteger, NSString *))failure {
    NSString *fillURL = [baseURL stringByAppendingString:url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:fillURL parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"%@ ----> %@", fillURL, responseObject);
             if (success) {
                 success(responseObject);
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"%@ ----> %@", fillURL, error.localizedDescription);
             if (failure) {
                 failure(error.code, error.localizedDescription);
             }
         }];
}



@end
