//
//  CDSearchVC.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/23.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDSearchVC.h"
#import "CDDragSortView.h"

@interface CDSearchVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) CDDragSortView *dragSortView;

@end

@implementation CDSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 302, 35)];

    self.cancelBtn = [UIButton new];
    [self.cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = NavbarColor;
    
    UIView *topBar = [UIView new];
    topBar.backgroundColor = NavbarColor;
    [self.view addSubview:topBar];
    [topBar addSubview:self.searchBar];
    [topBar addSubview:self.cancelBtn];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(topBar).offset(7);
        make.height.equalTo(@((30)));
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchBar.mas_right).offset(5);
        make.right.equalTo(topBar).offset(-5);
        make.width.equalTo(@(50));
        make.centerY.equalTo(self.searchBar.mas_centerY);
    }];
    
    [topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(STATUS_BAR_HEIGHT));
        make.left.and.right.width.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.backgroundColor = MainLightBrownColor;
    self.tableView.separatorColor = MainSeparatorColor;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.alwaysBounceVertical = YES;
    
    self.tableView.estimatedRowHeight = 80.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBar.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.dataArray = [NSMutableArray array];
    
    self.dragSortView = [[CDDragSortView alloc] init];
    
    [self.view addSubview:self.dragSortView];
    
    [self.dragSortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@250);
    }];
    
    [self.dragSortView installModel];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)close {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark -


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    return cell;
}


@end
