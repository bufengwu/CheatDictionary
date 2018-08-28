//
//  CDLeftItemModel.h
//  CheatDictionary
//
//  Created by zzy on 2018/8/22.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDLeftItemModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *uri;

@property (nonatomic, assign) BOOL isExpanded;
@property (nonatomic, strong) NSArray<NSString *> *items;

@end
