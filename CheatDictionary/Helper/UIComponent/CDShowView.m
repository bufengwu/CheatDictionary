//
//  HHShowView.m
//  Alert
//
//  Created by 花花 on 2017/12/9.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "CDShowView.h"
#import "Masonry.h"
#define TagValue  1000
#define AlertTime 0.2 //弹出动画时间
#define showView_Width [UIScreen mainScreen].bounds.size.width * 0.8
#define showView_Height 225

#define kAlertWidth showView_Width - 10   //textContentView
#define kButtonSpace 10
#define kButtonTag 100
@interface CDShowView()

@property(nonatomic)UIView *textContentView;
@property(nonatomic)UIView *lineView;
@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)UILabel *messageLabel;
@property(nonatomic)UIView *buttonContentView;

@property(nonatomic)NSMutableArray *buttons;
@property(nonatomic)NSMutableArray *actions;

@end

@implementation CDShowView
#pragma mark - init Method
- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:CGRectMake(0, 0, showView_Width, showView_Height)]) {

        [self setupInit];
        [self setupSubView];
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message{
    if (self = [self init]) {
        _titleLabel.text = title;
        _messageLabel.text = message;
    }
    return self;
}
+ (instancetype)alertTitle:(NSString *)title message:(NSString *)message{
    
    return [[self alloc]initWithTitle:title message:message];
}

+ (instancetype)alertTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
        confirmButtonTitle:(NSString *)confirmButtonTitle
             cancelHandler:(dispatch_block_t)cancelHandler
            confirmHandler:(dispatch_block_t)confirmHandler {
    CDShowView *showView = [CDShowView alertTitle:title message:message];
    showView.butttonCancelBgColor = [UIColor orangeColor];
    if ([cancelButtonTitle length]) {
        [showView addAction:[CDAlertAction actionTitle:cancelButtonTitle style:HHAlertActionCancel handler:^(CDAlertAction *action) {
            if (cancelHandler) {
                cancelHandler();
            }
        }]];
    }
    if ([confirmButtonTitle length]) {
        [showView addAction:[CDAlertAction actionTitle:confirmButtonTitle style:HHAlertActionConfirm handler:^(CDAlertAction *action) {
            if (confirmHandler) {
                confirmHandler();
            }
        }]];
    }
    return showView;
}

#pragma mark - Custom Methods
- (void)addAction:(CDAlertAction *)action{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.clipsToBounds = YES;
    [btn setTitle:action.title forState:UIControlStateNormal];
    btn.layer.cornerRadius = 4.0;
    btn.backgroundColor = [self buttonBgColorWithStyle:action.style];
    btn.enabled = action.enabled;
    btn.tag = kButtonTag + _buttons.count;
    [btn addTarget:self action:@selector(actionButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonContentView addSubview:btn];
    [self.buttons addObject:btn];
    [self.actions addObject:action];
    
    if (_buttons.count == 1) {
        [self layoutContentViews];
        [self layoutTextLabels];
        
    }
    [self layoutButtons];
}
-(void)show{
    if (self.superview) {
        [self removeFromSuperview];
    }
    UIView *oldView = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    UIView *bgView = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    bgView.tag = TagValue;
    bgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [bgView addGestureRecognizer:tap];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.center = [UIApplication sharedApplication].keyWindow.center;
    self.alpha = 0;
    self.transform = CGAffineTransformScale(self.transform, 0.1, 0.1);
    
    [UIView animateWithDuration:AlertTime animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}
//隐藏
-(void)hide{
    
    if (self.superview) {
        [UIView animateWithDuration:AlertTime animations:^{
            self.transform  = CGAffineTransformScale(self.transform, 0.1, 0.1);
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            UIView *bgView = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
            if (bgView) {
                [bgView removeFromSuperview];
                [self removeFromSuperview];
            }
            [bgView removeFromSuperview];
            [self removeFromSuperview];
            
        }];
    }
}
- (UIColor *)buttonBgColorWithStyle:(HHAlertActionStyle )style{
    
    switch (style) {
        case HHAlertActionCancel:
            return _butttonCancelBgColor;
            break;
        case HHAlertActionConfirm:
            return _butttonConfirmBgColor;
            break;
        default:
            break;
    }
}

#pragma mark - setupInit Method
- (void)setupInit{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10.0;
    self.layer.masksToBounds = YES;
    _butttonCancelBgColor = [UIColor colorWithRed:127/255.0 green:140/255.0 blue:141/255.0 alpha:1];
    _butttonConfirmBgColor = [UIColor colorWithRed:231/255.0 green:76/255.0 blue:60/255.0 alpha:1];

}
#pragma mark - setupSubView Method
- (void)setupSubView{

    [self addSubview:self.textContentView];
    [self addSubview:self.buttonContentView];
    [self.textContentView addSubview:self.titleLabel];
    [self.textContentView addSubview:self.lineView];
    [self.textContentView addSubview:self.messageLabel];
}

#pragma mark - layout Method
- (void)didMoveToSuperview
{
    if (self.superview) {
        [self layoutContentViews];
        [self layoutTextLabels];
    }
}
- (void)layoutContentViews{

    [_textContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(kAlertWidth);
    }];
    [_buttonContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self->_textContentView.mas_bottom);
        make.left.mas_equalTo(kButtonSpace);
        make.right.mas_equalTo(-kButtonSpace);
        make.height.mas_equalTo(45);
    }];
}
- (void)layoutTextLabels{
    
     //title
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self->_textContentView);
        make.height.mas_equalTo(40);
    }];
     //lineView
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_titleLabel.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
      //message
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_lineView.mas_bottom);
        make.left.right.equalTo(self->_textContentView);
        make.centerY.equalTo(self->_textContentView.mas_centerY);
    }];
   
}
- (void)layoutButtons{
    
    UIButton *button =_buttons.lastObject;
    if (_buttons.count == 1) {
        [self.buttonContentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self->_buttonContentView);
        }];
    }else if (_buttons.count == 2){
        
        UIButton *firstButton = _buttons.firstObject;
        [firstButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self->_buttonContentView);
            make.right.equalTo(button.mas_left).offset(-kButtonSpace);
            
            make.width.mas_equalTo(button.mas_width);
        }];
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(firstButton.mas_right).offset(kButtonSpace);
            make.right.equalTo(self->_buttonContentView.mas_right);
            make.top.equalTo(self->_buttonContentView.mas_top);
            make.bottom.equalTo(self->_buttonContentView.mas_bottom);
        }];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
        }];
    }
}
#pragma mark - SEL Method
- (void)actionButtonOnClick:(UIButton *)sender{
    
    CDAlertAction *action = _actions[sender.tag - kButtonTag];
        [self hide];
    
    if (action.handler) {
        action.handler(action);
    }
}
#pragma mark - Setter && Getter Methods
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UILabel *)messageLabel{
    
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}
- (UIView *)lineView{
    
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    }
    return _lineView;
}

- (UIView *)textContentView{
    
    if (!_textContentView) {
        _textContentView = [[UIView alloc]init];
    }
    return _textContentView;
}
- (UIView *)buttonContentView{
    if (!_buttonContentView) {
        _buttonContentView = [[UIView alloc]init];
        _buttonContentView.userInteractionEnabled = YES;
    }
    return _buttonContentView;
}
- (NSMutableArray *)buttons{
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (NSMutableArray *)actions{
    
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}
- (void)dealloc{
    NSLog(@"deallocdealloc");
}
@end

#pragma mark -

@implementation CDAlertAction

- (instancetype)initWithTitle:(NSString *)title style:(HHAlertActionStyle)style handler:(void(^)(CDAlertAction *))hander{
    
    if (self = [super init]) {
        _title = title;
        _style = style;
        _handler = hander;
        _enabled = YES;
    }
    return self;
}

+ (instancetype)actionTitle:(NSString *)title style:(HHAlertActionStyle)style handler:(void(^)(CDAlertAction *action))handler{

    return [[self alloc]initWithTitle:title style:style handler:handler];
}

@end

         

