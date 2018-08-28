//
//  CDFlowEditView.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/16.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDFlowEditView.h"

@implementation CDFlowEditView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [btn setImage:[[UIImage imageNamed:@"flow_edit_btn"] tintImageWithColor:RGB(235, 198, 119)] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        btn.backgroundColor = RGB(77, 55, 52);
        [btn addTarget:self action:@selector(showEditVC) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 22;
        btn.clipsToBounds = YES;
        [self addSubview:btn];
    }
    return self;
}

- (void)showEditVC {
    [[CDRouter shared] pushUrl:@"CDEditVC" animated:YES];
}


@end
