//
//  CDChannelDetailVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/14.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDChannelDetailVC.h"
#import "CDBaseCellModel.h"
#import "CDBaseTableViewCell.h"
#import "CDSectionModel.h"
#import "CDFlowEditView.h"

#import "CDChannelDetailVM.h"

@interface CDChannelDetailVC ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation CDChannelDetailVC

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.viewModel = [CDChannelDetailVM new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.params[@"type"];
    
    self.tableView.sectionFooterHeight = 0;

    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CGFLOAT_MIN)];
    testView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = testView;
    
    [self.viewModel loadData];
    
    
    CDFlowEditView *flowEditView = [CDFlowEditView new];
    [self.view addSubview:flowEditView];
    [flowEditView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-60);
        make.width.height.mas_equalTo(60);
    }];  
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
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
