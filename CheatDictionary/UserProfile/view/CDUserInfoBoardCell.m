//
//  CDUserInfoBoardCell.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/14.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDUserInfoBoardCell.h"
#import "HACursor.h"

#import "CDArticleCell.h"
#import "CDMomentCell.h"
#import "CDArticleModel.h"
#import "CDMomentModel.h"

@interface CDUserInfoBoardCell() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) UITableView *tableView3;

@end


@implementation CDUserInfoBoardCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(id)object {
    
}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 44 - STATUS_BAR_HEIGHT);
}

#pragma mark -

- (void)configSubviews {
    
    self.tableView1 = ({
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
        tableView;
    });
    
    self.tableView2 = ({
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
        tableView;
    });
    
    self.tableView3 = ({
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
        tableView;
    });
    
    
    self.titles = @[@"证书",@"文章",@"动态"];
    HACursor *cursor = [[HACursor alloc]init];
    cursor.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
    cursor.titles = self.titles;
    //每个子视图显示的内容
    cursor.pageViews = [self createPageViews];//此方法必需使用，pageView需要展示的内容按按照需求自定义
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
}


- (NSMutableArray *)createPageViews{
    NSMutableArray *pageViews = [NSMutableArray arrayWithObjects:self.tableView1, self.tableView2, self.tableView3, nil];
    
    return pageViews;
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView1) {
        return 3;
    }
    if (tableView == self.tableView2) {
        return 5;
    }
    if (tableView == self.tableView3) {
        return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView1) {

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.backgroundColor = MainLightBrownColor;
        }
        cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
        cell.textLabel.text = @"打铁 10🌟";
        return cell;
    }
    if (tableView == self.tableView2) {

        CDArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CDArticleCell"];
        if (!cell) {
            cell = [[CDArticleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CDArticleCell"];
        }
        CDArticleModel *model = [CDArticleModel new];
        model.title = @"iOS6的系统API结合autolayout";
        model.desc = @"控件的约束和第一个方法的一样，下面列出的代码是和第一个方法不同的地方。该方法的demo和第一个方法的demo是同一个，每个方法独立使用到的代码我会特别注明，没有注明就是所有方法共有的";
        model.cover = @"article_image_default";
        
        model.uri = @"CDArticleDetailVC";
        [cell installWithObject:model];
        return cell;
    }
    if (tableView == self.tableView3) {

        CDMomentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CDMomentCell"];
        if (!cell) {
            cell = [[CDMomentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CDMomentCell"];
        }
        CDMomentModel *model = [CDMomentModel new];
        model.avatarImage = @"icon_avatar_default";
        model.name = @"窃 格瓦拉";
        model.time = @"7月5日";
        model.action = @"发表文章";
        model.momentTitle = @"打工这方面......打工是不可能打工的 这辈子不可能打工的，做生意又不会做，就是偷这种东西，才能维持得了生活这样子.";
        [cell installWithObject:model];
        return cell;
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
}

@end
