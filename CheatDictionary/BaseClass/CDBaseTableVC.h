//
//  CDBaseTableVC.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/6/30.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDListBaseVM.h"
#import "CDBaseViewController.h"

@interface CDBaseTableVC : CDBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) UITableViewStyle tableViewStyle;

- (instancetype)initWithStyle:(UITableViewStyle)style;

@property (nonatomic, strong) CDListBaseVM *viewModel;

//tableview空白视图的刷新事件，子类赋值
@property (nonatomic, strong) dispatch_block_t refreshBlock;

@end
