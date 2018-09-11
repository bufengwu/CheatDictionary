//
//  CDSegmentControl.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/29.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDSegmentControl.h"

@implementation CDSegmentControl {
    NSArray *_titleArray;
    CGFloat _itemWidth;
    UIView *_cursorView;
}

+ (instancetype)segmentWithFrame:(CGRect)frame titleArray:(NSArray<NSString *> *)titles {
    CDSegmentControl *segment = [[CDSegmentControl alloc] initWithFrame:frame titleArray:titles];
    
    return segment;
}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray<NSString *> *)titles {
    if (self = [super initWithFrame:frame]) {
        self->_titleArray = titles;
        
        _itemWidth = self.frame.size.width/titles.count;
        //循环创建按钮
        for (int i = 0; i < titles.count; i++) {
            UIButton *button  = [[UIButton alloc]initWithFrame:CGRectMake(i *_itemWidth, 0, _itemWidth, self.frame.size.height)];
            [self addSubview:button];
            [button setTitle:_titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:SecondaryNavbarSelectedRed forState:UIControlStateSelected];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.tag = 1000 + i;
            [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                button.selected = YES;
                button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            }
        }
        
        _cursorView = [[UIView alloc] initWithFrame:CGRectMake(_itemWidth/4, self.frame.size.height - 3, _itemWidth/2, 3)];
        _cursorView.backgroundColor = SecondaryNavbarSelectedRed;
        
        [self addSubview:_cursorView];
    }
    return self;
}

- (void)setSelectIndex:(NSUInteger)index {
    NSInteger tag = 1000 + index;
    UIButton *btn = [self viewWithTag:tag];
    [self onButtonClick:btn];
}

- (void)onButtonClick:(UIButton *)button {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *subButton = (UIButton*)view;
            subButton.selected = NO;
            subButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        }
    }
    button.selected = YES;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    NSInteger index = button.tag - 1000;
    [UIView animateWithDuration:0.3 animations:^{
        self->_cursorView.tz_centerX = button.tz_centerX;
    }];
    
    if (self.selectedHandler) {
        self.selectedHandler(index);
    }
}

@end
