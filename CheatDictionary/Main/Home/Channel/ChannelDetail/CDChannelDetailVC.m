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

#import "CDShowMoreHeaderView.h"
#import "CDSegmentControl.h"
#import <SVPullToRefresh/SVPullToRefresh.h>

@interface CDChannelDetailVC ()

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) CDChannelDetailVM *viewModel;

@end

@implementation CDChannelDetailVC {
    NSUInteger _currentIndex;
}
@dynamic viewModel;

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
    
    [self.tableView.pullToRefreshView setTitle:@"下拉以刷新" forState:SVPullToRefreshStateTriggered];
    [self.tableView.pullToRefreshView setTitle:@"刷新完了呀" forState:SVPullToRefreshStateStopped];
    [self.tableView.pullToRefreshView setTitle:@"努力加载中..." forState:SVPullToRefreshStateLoading];
    
    @weakify(self)
    self.viewModel.completeLoadDataBlock = ^(BOOL success) {
        @strongify(self)
        if (success) {
            [self.tableView reloadData];
        } else {
            [CDToast showBottomToast:@"出错了呀"];
        }
        [self.tableView.pullToRefreshView stopAnimating];
    };
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        @strongify(self)
        [self.viewModel loadData];
    }];
    
    self.refreshBlock = ^{
        @strongify(self)
        [self.tableView triggerPullToRefresh];
    };
    
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
    CDSectionModel *model = self.viewModel.objects[section];
    if ([model isKindOfClass:[CDSectionModel class]]) {
        if ([model headerModel]) {
            return 44;
        }
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CDSectionModel *model = self.viewModel.objects[section];
    if ([model isKindOfClass:[CDSectionModel class]]) {
        if ([model headerModel]) {
            
            CDSegmentControl *view = [[CDSegmentControl alloc] initWithFrame:CGRectMake(0, 0, 160, 44) titleArray:@[@"帖子", @"博文"]];
            [view setSelectIndex:_currentIndex];
            
            view.selectedHandler = ^(NSUInteger index) {
                if (index != self->_currentIndex) {
                    self->_currentIndex = index;
                    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:section];
                    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            };
            return view;
        }
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2 && _currentIndex == 1) {
        return self.viewModel.articles.count;
    }
    
    id model = self.viewModel.objects[section];
    if ([model isKindOfClass:[CDSectionModel class]]) {
        return ((CDSectionModel *)model).objects.count;
    } else {
        return 0;
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
    
    //TODO: 切换帖子/博文，需要优化
    if (indexPath.section == 2 && _currentIndex == 1) {
        CDBaseCellModel *curModel = self.viewModel.articles[indexPath.row];
        cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([curModel cellClass]) forIndexPath:indexPath];
        [cell installWithObject:curModel];
    }
    
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
    
    //TODO: 切换帖子/博文，需要优化
    if (indexPath.section == 2 && _currentIndex == 1) {
        curModel = self.viewModel.articles[indexPath.row];
    }
    
    [[CDRouter shared] pushUrl:curModel.uri animated:YES];
}

@end
