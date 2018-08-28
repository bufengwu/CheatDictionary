//
//   YLDargSortCell.m
//
//
//  Created by HelloYeah on 2016/11/30.
//  Copyright © 2016年 YeLiang. All rights reserved.
//

#import "YLDargSortCell.h"

#define kDeleteBtnWH 10 * SCREEN_WIDTH_RATIO

@interface YLDargSortCell ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)  UILabel *label;

@property (nonatomic,strong) UIButton * deleteBtn;
@end
@implementation YLDargSortCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 4 * SCREEN_WIDTH_RATIO;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = RGBColorMake(110, 110, 110, 1).CGColor;
        self.layer.borderWidth = kLineHeight;
        
        
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = RGBColorMake(110, 110, 110, 1);
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"drag_delete"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(cancelSubscribe) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteBtn];
        
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(kDeleteBtnWH));
            make.centerY.equalTo(self);
            make.right.equalTo(self);
        }];
        
        //给每个cell添加一个长按手势
        UILongPressGestureRecognizer *longPress =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
        longPress.delegate = self;
        [self addGestureRecognizer:longPress];
        
        UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)cancelSubscribe {
    if (self.delegate && [self.delegate respondsToSelector:@selector(YLDargSortCellCancelSubscribe:)]) {
        [self.delegate YLDargSortCellCancelSubscribe:self.subscribe];
    }
}

- (void)showDeleteBtn {
    
    _deleteBtn.hidden = NO;
}

- (void)installWithModel:(YLDargSortItemModel *)model {
    _subscribe = model.title;
    _deleteBtn.hidden = !self.delegate.isEditing;
    _label.text = _subscribe;
    self.tz_size = model.size;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && !self.delegate.isEditing) {
        return NO;
    }
    return YES;
}

- (void)gestureAction:(UIGestureRecognizer *)gestureRecognizer{
    if (self.delegate && [self.delegate respondsToSelector:@selector(YLDargSortCellGestureAction:)]) {
        [self.delegate YLDargSortCellGestureAction:gestureRecognizer];
    }
}

@end
