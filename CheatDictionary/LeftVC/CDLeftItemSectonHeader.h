//
//  CDLeftItemSectonHeader.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/8/24.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDLeftItemModel.h"

typedef void(^CDLeftSectionItem)(CDLeftItemModel *);

@interface CDLeftItemSectonHeader : UIView

@property (nonatomic, strong) CDLeftSectionItem clickBlock;

- (void)installWithModel:(CDLeftItemModel *)model;

@end
