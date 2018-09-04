//
//  SXImageCell.m
//  108 - 特殊布局
//
//  Created by 董 尚先 on 15/3/20.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import "SXImageCell.h"

@implementation SXImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.layer.borderWidth = 5;
        _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _imageView.layer.cornerRadius = 5;
        _imageView.clipsToBounds = YES;
        
        [self addSubview:self.imageView];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end
