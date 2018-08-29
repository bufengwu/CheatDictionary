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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel loadData];
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
