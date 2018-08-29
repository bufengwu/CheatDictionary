//
//  CDChallengeCell.h
//  ZYLab
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseTableViewCell.h"
#import "CDCustomTagLabel.h"

@interface CDTopActivityCell : CDBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) CDCustomTagLabel *challengeNumberLabel;


@end
