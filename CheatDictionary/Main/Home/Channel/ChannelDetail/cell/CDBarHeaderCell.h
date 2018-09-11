//
//  CDBarHeaderCell.h
//  CheatDictionary
//
//  Created by zzy on 2018/8/9.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@interface CDBarHeaderCell : CDBaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *masterLabel1;

@end
