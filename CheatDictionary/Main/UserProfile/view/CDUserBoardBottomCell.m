//
//  CDUserInfoBoardCell.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/14.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDUserBoardBottomCell.h"
#import "HACursor.h"

#import "CDArticleCell.h"
#import "CDMomentCell.h"
#import "CDArticleModel.h"
#import "CDMomentModel.h"

#import "CDUserInfoModel.h"

@interface CDUserBoardBottomCell() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) UITableView *tableView3;

@property (nonatomic, strong) CDUserInfoModel *userInfoModel;

@end


@implementation CDUserBoardBottomCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDUserInfoModel *)object {
    self.userInfoModel = object;
}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 44 - STATUS_BAR_HEIGHT);
}

#pragma mark -

- (void)configSubviews {
    
    self.tableView1 = [self createTableView];
    
    self.tableView2 = [self createTableView];
    
    self.tableView3 = [self createTableView];
    
    HACursor *cursor = [[HACursor alloc] init];
    cursor.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
    //设置根滚动视图的高度
    cursor.rootScrollViewHeight = SCREEN_HEIGHT - 44 - STATUS_BAR_HEIGHT- 45;
    //默认值是白色
    cursor.titleNormalColor = [UIColor whiteColor];
    //默认值是白色
    cursor.titleSelectedColor = [UIColor redColor];
    cursor.showSortbutton = NO;
    //默认的最小值是5，小于默认值的话按默认值设置
    cursor.minFontSize = 6;
    [self addSubview:cursor];
    
    cursor.titles = @[@"证书",@"文章",@"动态"];
    //每个子视图显示的内容
    cursor.pageViews = [NSMutableArray arrayWithArray:@[self.tableView1, self.tableView2, self.tableView3]];//此方法必需使用，pageView需要展示的内容按按照需求自定义
}

#pragma mark -

- (UITableView *)createTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.bounces = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.alwaysBounceVertical = YES;
    tableView.estimatedRowHeight = 80.0f;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.backgroundColor = MainLightBrownColor;
    tableView.separatorColor = MainSeparatorColor;
    return tableView;
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView1) {
        return self.userInfoModel.certificate.count;
    }
    if (tableView == self.tableView2) {
        return self.userInfoModel.article.count;
    }
    if (tableView == self.tableView3) {
        return self.userInfoModel.dynamic.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView1) {

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.backgroundColor = MainLightBrownColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
        cell.textLabel.text = self.userInfoModel.certificate[indexPath.row];
        return cell;
    }
    if (tableView == self.tableView2) {

        CDArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CDArticleCell"];
        if (!cell) {
            cell = [[CDArticleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CDArticleCell"];
        }
        CDArticleModel *model = self.userInfoModel.article[indexPath.row];
        [cell installWithObject:model];
        return cell;
    }
    if (tableView == self.tableView3) {

        CDMomentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CDMomentCell"];
        if (!cell) {
            cell = [[CDMomentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CDMomentCell"];
        }
        CDMomentModel *model = self.userInfoModel.dynamic[indexPath.row];
        [cell installWithObject:model];
        return cell;
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
}

@end
