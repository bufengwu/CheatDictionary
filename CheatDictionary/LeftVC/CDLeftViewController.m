//
//  CDLeftVC.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/22.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDLeftViewController.h"
#import "UIViewController+MMDrawerController.h"

#import "CDLeftItemModel.h"
#import "CDLeftItemSectonHeader.h"

@interface CDLeftViewController ()

@end

@implementation CDLeftViewController {
    NSMutableArray *_dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = MainLightBrownColor;
    self.tableView.separatorColor = MainSeparatorColor;
    
    NSArray *groups = @[
                        @{
                            @"title" : @"个人中心",
                            @"uri" : @"CDLoginVC",
                            },
                        @{
                            @"title" : @"我的帖子",
                            @"uri" : @"",
                            },
                        @{
                            @"title" : @"我的文章",
                            @"uri" : @"",
                            },
                        @{
                            @"title" : @"我的回复",
                            @"uri" : @"",
                            },
                        @{
                            @"title" : @"我的收藏",
                            @"uri" : @"",
                            },
                        @{
                            @"title" : @"稍后再看",
                            @"uri" : @"",
                            },
                        @{
                            @"title" : @"小游戏",
                            @"items" : @[
                                    @{
                                        @"title" : @"许愿树",
                                        @"uri" : @"BTDreamViewController",
                                        },
                                    @{
                                        @"title" : @"康威生命游戏",
                                        @"uri" : @"FarmLandViewController",
                                        },
                                    @{
                                        @"title" : @"五维",
                                        @"uri" : @"RadarChartVC",
                                        },
                                    @{
                                        @"title" : @"下拉筛选",
                                        @"uri" : @"CDComboBoxViewController",
                                        },
                                    @{
                                        @"title" : @"地图定位",
                                        @"uri" : @"",
                                        },
                                    @{
                                        @"title" : @"音乐视频相机",
                                        @"uri" : @"",
                                        },
                                    @{
                                        @"title" : @"聊天，socket，蓝牙",
                                        @"uri" : @"",
                                        }
                                    ]
                            }
                        ];
    
    _dataArray = [NSMutableArray array];
    for (id object in groups) {
        CDLeftItemModel *item = [[CDLeftItemModel alloc] init];
        item.uri = object[@"uri"];
        item.title = object[@"title"];
        item.items = object[@"items"];

        [_dataArray addObject:item];
    }
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CDLeftItemModel *item = _dataArray[section];
    return item.isExpanded ? item.items.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.backgroundColor = MainLightBrownColor;
    }
    
    CDLeftItemModel *item = _dataArray[indexPath.section];
    NSArray *items = item.items;
    NSDictionary *dic = items[indexPath.row];
    
    cell.textLabel.text = dic[@"title"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CDLeftItemSectonHeader *view = [[CDLeftItemSectonHeader alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    CDLeftItemModel *model = _dataArray[section];
    [view installWithModel:model];
    
    view.clickBlock = ^(CDLeftItemModel *item) {
        if (item.items) {
            item.isExpanded = !item.isExpanded;
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:section];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            
            if ([item.uri isEqualToString:@"CDLoginVC"]) {
                [[CDRouter shared] presentUrl:item.uri animated:YES];
                
            } else {
                [[CDRouter shared] pushUrl:item.uri animated:YES];
            }
            
            [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
                //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
                [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            }];
        }
    };
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 100;
    }
    return 40;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CDLeftItemModel *item = _dataArray[indexPath.section];
    NSArray *items = item.items;
    NSDictionary *dic = items[indexPath.row];
    
    [[CDRouter shared] pushUrl:dic[@"uri"] animated:YES];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        
    }];
}

@end
