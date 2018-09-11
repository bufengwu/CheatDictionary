//
//  CDBarHeaderCell.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/9.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBarHeaderCell.h"
#import "CDBarHeaderModel.h"

@interface CDBarHeaderCell()

@property (nonatomic, strong) UIImageView *avatarBorderImageView;

@end

@implementation CDBarHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CDBarHeaderCell" owner:self options:nil].lastObject;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.coverImageView.layer.cornerRadius = self.coverImageView.tz_width/2.f;
        self.coverImageView.layer.masksToBounds = YES;
        
        [self.coverImageView addSubview:self.avatarBorderImageView];
    }
    return self;
}

- (void)installWithObject:(CDBarHeaderModel *)object {
    
    self.coverImageView.image = [UIImage imageNamed:@"maitian"];
    
    self.todayLabel.text = [NSString stringWithFormat:@"今日：%@", object.today];
    self.descLabel.text = [NSString stringWithFormat:@"主题：%@", object.all];
    
    self.masterLabel1.text = object.masters[0];
}

- (UIImageView *)avatarBorderImageView {
    if (!_avatarBorderImageView) {
        _avatarBorderImageView = [[UIImageView alloc] initWithFrame:self.coverImageView.bounds];
        _avatarBorderImageView.image = [UIImage imageNamed:@"circle_44x44_"];
    }
    return _avatarBorderImageView;
}

@end
