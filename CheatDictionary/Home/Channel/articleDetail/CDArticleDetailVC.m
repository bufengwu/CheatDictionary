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


@interface CDArticleDetailVC ()<WKNavigationDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *atricleSourceArray;

@property (nonatomic, strong) TYAttributedLabel *label;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *replyTableView;    //评论

@end

@implementation CDArticleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    self.atricleSourceArray = @[
                                @"孤岛生存最重要的三种装备",
                                @"一、刀\n\n刀，无论在什么样的环境中，都是最常见也是最重要的生存装备。我们可以利用刀做很多事情，比如获取食物做饭、保护自身的安全、建造庇护所，或者是利用刀做成我们想要的工具：把木棍削成带尖的长矛、做成孤岛上用得到的捕鱼工具鱼叉等等。",
                                @"![image]http://i0.hdslb.com/bfs/archive/69737852c0e5316a2f0e5f81e0100d9156f0ae46.jpg",
                                @"二、打火器材\n\n说到火，这是我们人类进化的起点，在很久很久以前，人类还没有发现火的时候过着茹毛饮血、担惊受怕的生活，后来人类发现了火就像拥有了一切，他们从此可以利用火来取暖，烘焙食物，驱赶生物等等。所以，打火器材是孤岛生存装备中的保命必需品。在孤岛上，很难找到非流动的淡水资源，不怕饿死而怕是会渴死，就算找到积水洼之类的水源，也必须过滤加热消毒，因此，火既能帮助对海水进行加热蒸馏成淡水，又能对水进行消毒，可以极大程度的降低感染几率。可以直接点击文字参考：野外取火的方法。"
                                ];
    [self transactionAttributedString:self.atricleSourceArray];
    
    
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
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.label.bounds.size.height + self.replyTableView.bounds.size.height);
    
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDDiscussionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CDDiscussionDetailCell"];
    if (!cell) {
        cell = [[CDDiscussionDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CDDiscussionDetailCell"];
    }
    CDDiscussionDetailModel *model = [CDDiscussionDetailModel new];
    model.avatar = @"icon_avatar_default";
    model.name = @"食草驴之神";
    model.time = @"14:23";
    model.content = @"颤抖吧！僵尸来临之时，本座君临世界";
    [cell installWithObject:model];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"评论";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"共10条评论";
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
