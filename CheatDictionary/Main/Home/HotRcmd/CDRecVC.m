//
//  CDRecVC.m
//  ZYLab
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDRecVC.h"
#import "CDRecVM.h"
#import "CDBaseCellModel.h"
#import "CDBaseTableViewCell.h"

#import "CDTabBarController.h"

#import <SVPullToRefresh/SVPullToRefresh.h>

@interface CDRecVC () 

@property (nonatomic, strong) CDRecVM *viewModel;

@end

@implementation CDRecVC
@dynamic viewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [CDRecVM new];        
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
        [self refresh];
    };
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:CDTabBarDidClickNotification object:nil];
}

//点击tabbar刷新
- (void)refresh {
    if ([self.view isShowingOnKeyWindow]) { // 判断一个view是否显示在根窗口上
        [self.tableView setContentOffset:CGPointMake(0, -55) animated:YES];
        //给0.3秒延时是等setContentOffset的动画完成，否则triggerPullToRefresh会走wasTriggeredByUser = yes的方法，导致下拉控件不会回到顶部
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView triggerPullToRefresh];
        });
    }
}

#pragma mark -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
    UIPanGestureRecognizer* pan = scrollView.panGestureRecognizer;
    //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
    CGFloat velocity = [pan velocityInView:scrollView].y;
    if (velocity<-5) {
        //向上拖动，隐藏导航栏
        [self.navigationController setNavigationBarHidden:true animated:true];
    }
    else if (velocity>5) {
        //向下拖动，显示导航栏
        [self.navigationController setNavigationBarHidden:false animated:true];
    }
    else if(velocity==0){
        //停止拖拽
    }
}

//view将要消失的时候，显示导航栏，这样跳转到其他界面的时候，才能看到导航栏，否则，看不到导航栏
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark -

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
