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

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = @"网络不给力，请点击重试哦~";
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 设置所有字体大小为 #15
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:15.0]
                   range:NSMakeRange(0, text.length)];
    // 设置所有字体颜色为浅灰色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:[UIColor lightGrayColor]
                   range:NSMakeRange(0, text.length)];
    // 设置指定4个字体为蓝色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:HEXCOLOR(0x007EE5)
                   range:NSMakeRange(7, 4)];
    return attStr;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}

@end
