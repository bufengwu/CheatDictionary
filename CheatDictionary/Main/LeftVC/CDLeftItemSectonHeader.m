//
//  CDLeftItemSectonHeader.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/8/24.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDLeftItemSectonHeader.h"

@implementation CDLeftItemSectonHeader {
    UILabel *_titleLabel;
    UIImageView *_arrowImageView;
    UIView *_bottomLine;
    
    CDLeftItemModel *_model;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        
        [self addSubview:_titleLabel];
        [self addSubview:_arrowImageView];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
        
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.width.height.equalTo(@20);
            make.left.equalTo(self).offset(170);
        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)];
        [self addGestureRecognizer:tapGesture];
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = [UIColor brownColor];
        [self addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@.5);
        }];
    }
    return self;
}

- (void)installWithModel:(CDLeftItemModel *)model {
    _model = model;
    
    _titleLabel.text = model.title;
}


- (void)onClick:(UITapGestureRecognizer *)tap {
    if (self.clickBlock) {
        self.clickBlock(_model);
    }
}

@end
