//
//  CDCardPool.h
//  CheatDictionary
//
//  Created by zzy on 2018/9/11.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDCardPool : NSObject

+ (Class)modelFoyCardType:(NSString *)cardType;

+ (Class)cellForCardType:(NSString *)cardType;

@end
