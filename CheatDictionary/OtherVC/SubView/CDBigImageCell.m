//
//  CDBigImageCell.m
//  ZYLab
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBigImageCell.h"
#import "CDBigImageModel.h"

@implementation CDBigImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDBigImageModel *)object {
//    self.coverImageView.image = object.imageUrl;
    self.coverImageView.image = [UIImage imageNamed:@"image_cell_default"];
}


+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/16.0*9.0);
}

#pragma mark -

- (void)configSubviews {
    [self.contentView addSubview:self.coverImageView];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.inset(10);
    }];
}

- (UIImageView *)coverImageView {
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc] init];
    }
    return _coverImageView;
}

@end
