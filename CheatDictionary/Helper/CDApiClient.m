//
//  CDApiClient.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/17.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDApiClient.h"
#import <AFNetworking/AFNetworking.h>

static const NSString *const baseURL = @"http://localhost:8080/api/v1/";

@implementation CDApiClient

+ (void)POST:(NSString *)url payload:(NSDictionary *)payload success:(void (^)(NSDictionary *data))success failure:(void (^)(NSInteger, NSString *))failure {
    NSString *fillURL = [baseURL stringByAppendingString:url];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:payload];
    
    dic[@"lang"] = @"zh";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 4.f;
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

+ (void)GET:(NSString *)url payload:(NSDictionary *)payload success:(void (^)(NSDictionary *))success failure:(void (^)(NSInteger, NSString *))failure {
    NSString *path = [url cd_appendParamsWithDictionary:payload];
    [self GET:path success:success failure:failure];
}


+ (void)GET:(NSString *)url success:(void (^)(NSDictionary *))success failure:(void (^)(NSInteger, NSString *))failure {
    NSString *fillURL = [baseURL stringByAppendingString:url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 4.f;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:fillURL parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"%@ ----> %@", fillURL, responseObject);
             
             NSDictionary *data = [responseObject objectForKey:@"data"];
             NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
             NSString *message = [responseObject objectForKey:@"message"];
             
             if (data && code == 0) {
                 if (success) {
                     success(data);
                 }
             } else {
                 if (failure) {
                     failure(code, message);
                 }
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"%@ ----> %@", fillURL, error.description);
             if (failure) {
                 failure(error.code, error.description);
             }
         }];
}



@end
