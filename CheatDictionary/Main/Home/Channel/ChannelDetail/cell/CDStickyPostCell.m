//
//  CDStickyPostCell.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/9.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDStickyPostCell.h"
#import "CDStickyPostModel.h"

@interface CDStickyPostCell()

@property (nonatomic, strong) UILabel *stickyLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CDStickyPostCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.stickyLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:11];
            label.layer.borderColor = [UIColor blackColor].CGColor;
            label.layer.borderWidth = 1;
            label.text = @"置顶";
            label;
        });
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        
        [self.contentView addSubview:self.stickyLabel];
        [self.contentView addSubview:self.titleLabel];
        
        [self.stickyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@32);
            make.height.equalTo(@15);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.stickyLabel.mas_right).offset(6);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        
    }
    return self;
}

- (void)installWithObject:(CDStickyPostModel *)object {
    self.titleLabel.text = object.title;
}

@end
