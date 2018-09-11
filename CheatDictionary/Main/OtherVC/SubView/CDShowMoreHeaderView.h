//
//  CDShowMoreHeaderView.h
//  CheatDictionary
//
//  Created by zzy on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDShowMoreHeaderModel.h"

@interface CDShowMoreHeaderView : UIView

@property (nonatomic, strong) CDShowMoreHeaderModel *model;

- (void)installWithObject:(CDShowMoreHeaderModel *)object;

@end
