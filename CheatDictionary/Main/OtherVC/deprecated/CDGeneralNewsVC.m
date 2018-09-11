//
//  CDGeneralNewsVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/28.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDGeneralNewsVC.h"
#import "CDBaseCellModel.h"
#import "CDBaseTableViewCell.h"
#import "CDNewsVM.h"


@interface CDGeneralNewsVC ()

@property (nonatomic, strong) CDNewsVM *viewModel;

@end

@implementation CDGeneralNewsVC
@dynamic viewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [CDNewsVM new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
