//
//  CDArticleCell.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCollectionViewCell.h"

@interface CDArticleCoverCell : CDBaseCollectionViewCell

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;


@end
