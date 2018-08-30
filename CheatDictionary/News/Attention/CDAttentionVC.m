//
//  CDAttentionVC.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/12.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDAttentionVC.h"
#import "CDAttentionVM.h"

#import "CDSectionModel.h"
#import "CDBaseCellModel.h"

#import "CDBaseTableViewCell.h"
#import "CDShowMoreHeaderView.h"

#import "CDFlowEditView.h"

@interface CDAttentionVC ()

@end

@implementation CDAttentionVC

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.viewModel = [CDAttentionVM new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionFooterHeight = 0;
    
    [self.viewModel loadData];
    
    CDFlowEditView *flowEditView = [CDFlowEditView new];
    [self.view addSubview:flowEditView];
    [flowEditView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-60);
        make.width.height.mas_equalTo(60);
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CDSectionModel *model = self.viewModel.objects[section];
    if ([model isKindOfClass:[CDSectionModel class]]) {
        if ([model headerModel]) {
            CDShowMoreHeaderView *view = [[CDShowMoreHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
            [view installWithObject:model.headerModel];
            return view;
        }
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.objects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id model = self.viewModel.objects[section];
    if ([model isKindOfClass:[CDSectionModel class]]) {
        return ((CDSectionModel *)model).objects.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = self.viewModel.objects[indexPath.section];
    CDBaseCellModel *curModel;
    if ([model isKindOfClass:[CDSectionModel class]]) {
        curModel = ((CDSectionModel *)model).objects[indexPath.row];
    } else {
        curModel = model;
    }
    CDBaseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([curModel cellClass]) forIndexPath:indexPath];
    [cell installWithObject:curModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = self.viewModel.objects[indexPath.section];
    CDBaseCellModel *curModel;
    if ([model isKindOfClass:[CDSectionModel class]]) {
        curModel = ((CDSectionModel *)model).objects[indexPath.row];
    } else {
        curModel = model;
    }
    [[CDRouter shared] pushUrl:curModel.uri animated:YES];
}

@end
