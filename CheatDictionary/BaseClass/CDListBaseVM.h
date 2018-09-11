//
//  CDListBaseVM.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit/NSObject+YYModel.h>

@interface CDListBaseVM : NSObject

@property (nonatomic, copy) void (^completeLoadDataBlock)(BOOL);

@property (nonatomic, strong) NSArray *objects;

- (void)loadData;

- (NSDictionary<NSString *, Class> *)cellIdentifierMapping;

- (NSDictionary<NSString *, Class> *)headerIdentifierMapping;

@end
