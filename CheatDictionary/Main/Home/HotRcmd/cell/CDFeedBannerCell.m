//
//  CDFeedBannerCell.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDFeedBannerCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "CDFeedBannerModel.h"

@interface CDFeedBannerCell()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleView;

@end

@implementation CDFeedBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDFeedBannerModel *)object {
    
    {   //测试用本地图
        NSArray *imageNames = @[@"banner1",
                                @"banner2.jpg",
                                @"banner3.jpg",
                                @"banner4.jpg",
                                @"banner5.jpg",
                                ];
        self.cycleView.localizationImageNamesGroup = imageNames;
    }
//    self.cycleView.imageURLStringsGroup = object.images;
    self.cycleView.titlesGroup = object.titles;
}

#pragma mark -

- (void)configSubviews {
    
    [self.contentView addSubview:self.cycleView];
    
    [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(ceil((SCREEN_WIDTH - 20)/3.20)).priorityHigh();
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
}

- (SDCycleScrollView *)cycleView {
    if (!_cycleView) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) delegate:self placeholderImage:[UIImage imageNamed:@"banner_json_err_2233"]];
        _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _cycleView;
}

@end
