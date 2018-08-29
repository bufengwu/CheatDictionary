//
//  CDSegmentControl.h
//  CheatDictionary
//
//  Created by zzy on 2018/8/29.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CDSegmentControlHandler)(NSUInteger index);

@interface CDSegmentControl : UIView

@property(nonatomic, copy) CDSegmentControlHandler selectedHandler;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray<NSString *> *)titles;

- (void)setSelectIndex:(NSUInteger)index;

@end
