//
//  CDUserInfoCell.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDUserInfoCell.h"
#import <JYRadarChart/JYRadarChart.h>
#import "JYWaveView.h"

#import "CDUserInfoModel.h"

@interface CDUserInfoCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansLabel;

@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

@property (nonatomic, strong) JYWaveView *doubleWaveView;
@property (nonatomic, strong) JYRadarChart *radarChartView;

@end

@implementation CDUserInfoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CDUserInfoCell" owner:self options:nil].lastObject;
        
        
        _doubleWaveView = [[JYWaveView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30)];
        _doubleWaveView.frontColor = MainDarkBrownColor;
        _doubleWaveView.insideColor = MainLightBrownColor;
        _doubleWaveView.directionType = WaveDirectionTypeFoward;
        [self addSubview:_doubleWaveView];
        
        _radarChartView = [[JYRadarChart alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
        _radarChartView.backgroundColor = [UIColor clearColor];
        [self addSubview:_radarChartView];
        
        [_doubleWaveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.width.equalTo(self);
            make.height.equalTo(@20);
        }];
        
        [_radarChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-30);
            make.width.height.equalTo(@140);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = MainDarkBrownColor;
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
    
    
    [self.radarChartView setTitles:@[@"上次", @"现在" ]];
    self.radarChartView.attributes = @[@"魅力 100", @"口才", @"领导力", @"文笔", @"财富"];
    NSArray *b1 = @[@(30), @(14), @(27), @(10), @(35)];
    NSArray *b2 = @[@(69), @(54), @(43), @(37), @(48)];
    self.radarChartView.dataSeries = @[b1, b2];
}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeMake(SCREEN_WIDTH, 250);
}

@end
