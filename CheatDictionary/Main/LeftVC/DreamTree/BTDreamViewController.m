//
//  BTDreamViewController.m
//  YourEye
//
//  Created by DevKK on 2017/9/4.
//  Copyright © 2017年 DevKK. All rights reserved.
//

#import "BTDreamViewController.h"
#import "XLSphereView.h"

@interface BTDreamViewController ()

@property (nonatomic,strong) XLSphereView *sphereView;


@property (nonatomic, strong) NSArray *dreams;

@property (nonatomic, strong) NSArray *dreamTitles;

@property (weak, nonatomic) IBOutlet UILabel *dreamTitleLabel;

@property (nonatomic, strong) UIViewController *dialogVC;

@end

@implementation BTDreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.dreamTitles = @[
                         @"你的眼睛里含着我的梦",
                         @"她的世界需要一双眼睛",
                         @"我带着眼睛走遍世界",
                         @"有一天你会来到我的世界里吗",
                         @"心怀一梦，踏遍天涯",
                         ];
    

    
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(seekHelp:)];
    
    self.navigationItem.rightBarButtonItem = myButton;
    
    //右按钮   发出梦想
    
    //点击梦，实现他的梦，关注这个梦
    self.dreams = @[
                    @"北海道",
                    @"国家光电实验室",
                    @"草原",
                    @"北京西站",
                    @"南城",
                    @"鹿儿岛",
                    @"河南",
                    @"雪山",
                    @"意大利",
                    @"核电站",
                    @"落差60米",
                    @"外卖小哥的一天",
                    @"游戏工作室",
                    @"珠穆朗玛峰",
                    @"南极",
                    ];

    [self initDream];
    
}

- (void) initDream {
    CGFloat sphereViewW = SCREEN_WIDTH - 30 * 2;
    CGFloat sphereViewH = sphereViewW;
    _sphereView = [[XLSphereView alloc] initWithFrame:CGRectMake(0, 0, sphereViewW, sphereViewH)];
    
    _sphereView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-100);
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *dream in self.dreams) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:dream forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255. green:arc4random_uniform(255)/255. blue:arc4random_uniform(255)/255. alpha:1.];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIFont *font = [UIFont systemFontOfSize:18.];
        btn.titleLabel.font = font;
        CGSize size = [CDUIHelper sizeWithText:dream font:font maxSize:CGSizeMake(300, 300)];
        
        btn.frame = CGRectMake(0, 0, size.width+10, size.height+10);
        btn.layer.cornerRadius = 3;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:btn];
        [_sphereView addSubview:btn];
    }
    [_sphereView setItems:array];
    [self.view addSubview:_sphereView];
}


- (void)buttonPressed:(UIButton *)btn {

}

- (void) seekHelp:(UIBarButtonItem *)sender {
    
}

- (IBAction)refresh:(id)sender {
    
    self.dreamTitleLabel.text = self.dreamTitles[arc4random()%self.dreamTitles.count];
    
    [_sphereView removeFromSuperview];
    _sphereView = nil;
    [self initDream];
}

@end
