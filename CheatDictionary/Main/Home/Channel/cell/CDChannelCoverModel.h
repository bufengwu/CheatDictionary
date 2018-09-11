//
//  CDChannelCoverModel.h
//  ZYLab
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"

@interface CDChannelCoverModel : CDBaseCellModel

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;
@property(nonatomic, assign) int badge;
@property(nonatomic, copy) NSString *icon;

@end
