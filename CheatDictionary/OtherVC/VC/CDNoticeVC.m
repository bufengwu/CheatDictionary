//
//  CDNoticeVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/12.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDNoticeVC.h"
#import "CDNoticeListVM.h"
#import "CDBaseCellModel.h"
#import "CDBaseTableViewCell.h"

@interface CDNoticeVC ()

@property (nonatomic, strong) CDNoticeListVM *viewModel;

@end

@implementation CDNoticeVC
@dynamic viewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [CDNoticeListVM new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    [self.viewModel loadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDBaseCellModel *model = self.viewModel.objects[indexPath.row];
    CDBaseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([model cellClass]) forIndexPath:indexPath];
    [cell installWithObject:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CDBaseCellModel *model = self.viewModel.objects[indexPath.row];
    [[CDRouter shared] pushUrl:model.uri animated:YES];
}

@end
