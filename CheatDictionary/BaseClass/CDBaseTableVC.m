//
//  CDBaseTableVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/6/30.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseTableVC.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface CDBaseTableVC () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation CDBaseTableVC

- (instancetype)initWithStyle:(UITableViewStyle)tableViewStyle
{
    if (self = [super init]) {
        self.tableViewStyle = tableViewStyle;
    }
    return self;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.backgroundColor = MainLightBrownColor;
        _tableView.separatorColor = MainSeparatorColor;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.alwaysBounceVertical = YES;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.tableView.estimatedRowHeight = 80.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [[self.viewModel cellIdentifierMapping] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, Class  _Nonnull cls, BOOL * _Nonnull stop) {
        [self.tableView registerClass:cls forCellReuseIdentifier:key];
    }];
    
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;

}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

#pragma mark -

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"什么都没有啊";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

@end
