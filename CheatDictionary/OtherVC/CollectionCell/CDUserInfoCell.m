//
//  CDUserInfoCell.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDUserInfoCell.h"
#import "CDUserInfoModel.h"

@interface CDUserInfoCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansLabel;

@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

@end

@implementation CDUserInfoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CDUserInfoCell" owner:self options:nil].lastObject;
//        self.contentView.backgroundColor = mainBgColor;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = CollectCellBG;
//    [self.contentView addSubview:self.itemView1 = [CDUserFaceItemView new]];
//    [self.contentView addSubview:self.itemView2 = [CDUserFaceItemView new]];
//    [self.contentView addSubview:self.itemView3 = [CDUserFaceItemView new]];
//    [self.contentView addSubview:self.itemView4 = [CDUserFaceItemView new]];
//
//    [self.itemView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.avatarView.mas_bottom).offset(10);
//        make.left.equalTo(self.contentView);
//        make.width.equalTo(self.contentView).dividedBy(4);
//        make.height.equalTo(@(50));
//    }];
//
//    [self.itemView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.itemView1.mas_right);
//        make.top.height.width.equalTo(self.itemView1);
//    }];
//
//    [self.itemView3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.itemView2.mas_right);
//        make.top.height.width.equalTo(self.itemView1);
//    }];
//
//    [self.itemView4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.itemView3.mas_right);
//        make.top.height.width.equalTo(self.itemView1);
//    }];
//
}

- (void)installWithObject:(CDUserInfoModel *)object {
    self.avatarView.image = [UIImage imageNamed:object.avatar];
    self.nameLabel.text = object.name;
    self.descLabel.text = object.desc;
}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeMake(SCREEN_WIDTH, 130);
}

@end
