//
//  CDFeedBannerCell.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDFeedBannerCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

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

- (void)installWithObject:(id )object {

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
        NSArray *imageNames = @[@"banner1",
                                @"banner2.jpg",
                                @"banner3.jpg",
                                @"banner4.jpg",
                                @"banner5.jpg",
                                ];
        NSArray *titles = @[@"记我在新疆夜里画圈圈的日子",
                            @"夏の落基山班芙二回目",
                            @"欧洲",
                            @"Love Star Sunshine彩虹天堂金秋行摄",
                            @"女汉子与小汉子从东北到西南",
                            ];
        
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
        _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleView.titlesGroup = titles;
        
//        NSArray *imagesURLStrings = @[
//                                      @"http://i0.hdslb.com/bfs/archive/69737852c0e5316a2f0e5f81e0100d9156f0ae46.jpg",
//                                      @"http://i0.hdslb.com/bfs/archive/dce8a95afe99f66ec54b67e8694fe89fffa9cdf8.png",
//                                      @"http://i0.hdslb.com/bfs/archive/2805e6d3d131d7980cadab237568d98eb78f5dee.jpg"
//                                      ];
//        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner_json_err_2233"]];
//        _cycleView.imageURLStringsGroup = imagesURLStrings;
        
    }
    return _cycleView;
}


@end
