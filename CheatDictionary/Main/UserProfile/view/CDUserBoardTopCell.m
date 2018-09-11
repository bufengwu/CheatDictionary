//
//  CDUserInfoCell.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDUserBoardTopCell.h"
#import <JYRadarChart/JYRadarChart.h>
#import "JYWaveView.h"

#import "CDUserInfoModel.h"

@interface CDUserBoardTopCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansLabel;

@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;

@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

@property (nonatomic, strong) JYWaveView *doubleWaveView;
@property (nonatomic, strong) JYRadarChart *radarChartView;

@end

@implementation CDUserBoardTopCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CDUserBoardTopCell" owner:self options:nil].lastObject;
        
        
        _doubleWaveView = [[JYWaveView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 30, SCREEN_WIDTH, 30)];
        _doubleWaveView.frontColor = MainDarkBrownColor;
        _doubleWaveView.insideColor = MainLightBrownColor;
        _doubleWaveView.directionType = WaveDirectionTypeFoward;
        [self addSubview:_doubleWaveView];
        
        _radarChartView = [[JYRadarChart alloc] initWithFrame:CGRectMake(0, 0, 180, 140)];
        _radarChartView.backgroundColor = [UIColor clearColor];
        _radarChartView.backgroundFillColor = MainLightBrownColor;
        _radarChartView.backgroundLineColorRadial = MainDarkBrownColor;
        [self addSubview:_radarChartView];
        
        [_doubleWaveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.width.equalTo(self);
            make.height.equalTo(@20);
        }];
        
        [_radarChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-30);
            make.width.equalTo(@180);
            make.height.equalTo(@140);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = MainDarkBrownColor;
}

- (void)installWithObject:(CDUserInfoModel *)object {
    
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:object.avatar] placeholderImage:[UIImage imageNamed:@"icon_avatar_default"]];
    
    self.nameLabel.text = object.name;
    
    self.fansLabel.text = object.fans;
    self.pointsLabel.text = object.coins;
    
    self.descLabel.text = object.desc;
    
    [self.radarChartView setTitles:@[@"当前技能" ]];
    self.radarChartView.attributes = object.ponit_attributes;
    self.radarChartView.dataSeries = @[object.ponit_series];
}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeMake(SCREEN_WIDTH, 250);
}

@end
