//
//  CDArticleDetailVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/15.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDArticleDetailVC.h"
#import <WebKit/WebKit.h>
#import <TYAttributedLabel/TYAttributedLabel.h>

#import "CDDiscussionDetailModel.h"
#import "CDDiscussionDetailCell.h"

#import "CDArticleDetailVM.h"

@interface CDArticleDetailVC ()<WKNavigationDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TYAttributedLabel *label;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *replyTableView;    //评论

@property (nonatomic, strong) CDArticleDetailVM *viewModel;

@end

@implementation CDArticleDetailVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [CDArticleDetailVM new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel loadData];
    
    self.scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        scrollView.backgroundColor = MainLightBrownColor;
        scrollView;
    });
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    self.label = [[TYAttributedLabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 100)];
    self.label.backgroundColor = MainLightBrownColor;
    [_scrollView addSubview:self.label];
    
    self.replyTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.label.frame.size.height, SCREEN_WIDTH, 400) style:UITableViewStylePlain];
        tableView.backgroundColor = MainLightBrownColor;
        tableView.estimatedRowHeight = 80;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        tableView;
    });
    
    [self.scrollView addSubview:self.replyTableView];
    
    @weakify(self)
    self.viewModel.completeLoadDataBlock = ^(BOOL success) {
        @strongify(self)
        if (success) {
            [self.replyTableView reloadData];
            [self transactionAttributedString:self.viewModel.atricleSourceArray];
            self.replyTableView.frame = CGRectMake(0, self.label.frame.size.height, SCREEN_WIDTH, self.replyTableView.contentSize.height);
            self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.label.bounds.size.height + self.replyTableView.bounds.size.height);
        } else {
            [CDToast showBottomToast:@"出错了呀"];
        }
    };
}

- (void)transactionAttributedString:(NSArray *)source {
    if (source.count < 1) {
        NSLog(@"出错了诶～");
        return;
    }
    
    NSString *title = [NSString stringWithFormat:@"\n%@\n\n", source[0]];
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithString:title
                                                                                      attributes:@{
                                                                                                   NSFontAttributeName : [UIFont boldSystemFontOfSize:17]
                                                                                                   }];
    [self.label appendTextAttributedString:mutableString];
    for (int i = 1; i < source.count; i++) {
        NSString *srcStr = source[i];
        if ([srcStr hasPrefix:@"![image]"]) {
            TYImageStorage *imageUrlStorage = [[TYImageStorage alloc] init];
            imageUrlStorage.imageURL = [NSURL URLWithString:[srcStr substringFromIndex:8]];
            imageUrlStorage.size = CGSizeMake(SCREEN_WIDTH - 20, 200);
            [self.label appendTextStorage:imageUrlStorage];
        } else {
            NSAttributedString *str = [[NSAttributedString alloc] initWithString:srcStr attributes:@{
                                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:12]
                                                                                                     }];
            [self.label appendTextAttributedString:str];
        }
    }
    [self.label sizeToFit];
}


#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDDiscussionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CDDiscussionDetailCell"];
    if (!cell) {
        cell = [[CDDiscussionDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CDDiscussionDetailCell"];
    }
    CDDiscussionDetailModel *model = self.viewModel.commentArray[indexPath.row];
    [cell installWithObject:model];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"评论";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"共%lu条评论", (unsigned long)self.viewModel.commentArray.count] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 25;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    ((UITableViewHeaderFooterView *)view).contentView.backgroundColor = MainDarkBrownColor;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    ((UITableViewHeaderFooterView *)view).textLabel.font = [UIFont systemFontOfSize:12];
    ((UITableViewHeaderFooterView *)view).contentView.backgroundColor = MainDarkBrownColor;
}

@end
