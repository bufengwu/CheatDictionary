//
//  RadarChartVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/8/25.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "RadarChartVC.h"
#import <JYRadarChart/JYRadarChart.h>

@interface RadarChartVC ()

@end

@implementation RadarChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    JYRadarChart *p2 = [[JYRadarChart alloc] initWithFrame:CGRectMake(10, 220, 280, 200)];
    [p2 setTitles:@[@"上次", @"现在" ]];
    p2.attributes = @[@"魅力 100", @"口才", @"领导力", @"文笔", @"财富"];
    NSArray *b1 = @[@(30), @(14), @(27), @(10), @(35)];
    NSArray *b2 = @[@(69), @(54), @(43), @(37), @(48)];
    p2.dataSeries = @[b1, b2];
    [self.view addSubview:p2];
}

@end
