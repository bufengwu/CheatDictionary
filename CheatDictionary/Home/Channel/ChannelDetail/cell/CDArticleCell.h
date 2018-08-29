//
//  CDArticleCell.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDBaseTableViewCell.h"

@interface CDArticleCell : CDBaseTableViewCell

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end
