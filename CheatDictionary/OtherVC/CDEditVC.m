//
//  CDEditVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/14.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDEditVC.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <YYKit/YYKit.h>
#import "TZImagePickerController.h"
#import <BlocksKit/BlocksKit+UIKit.h>

#define getRectNavAndStatusHight  (self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height)


@interface CDEditVC ()<YYTextViewDelegate,TZImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton * publishBtn;

@property (nonatomic, strong) YYTextView *titleTextView;

@property (nonatomic, strong) UIView *splitLine;

@property (nonatomic, strong) YYTextView *contentTextView;

@property (nonatomic ,strong) TZImagePickerController *imagePickerVc;

@property (nonatomic ,strong) NSMutableArray * imagesArr;    //存放图片
@property (nonatomic ,strong) NSMutableArray * imageUrlsArr; // 存放图片url
@property (nonatomic ,strong) NSMutableArray * desArr;       //存放图片描述
@property (nonatomic ,strong) NSString * contentStr;       // 带有标签的文章内容

@end

@implementation CDEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布图文";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self setupSubViews];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 获取键盘高度
 */
- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    CGFloat keyboardHeight = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.contentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-keyboardHeight);
        }];
    }];
    [self.view layoutIfNeeded];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    
    NSDictionary *userInfo = [aNotification userInfo];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.contentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
        }];
    }];
    [self.view layoutIfNeeded];
}

/**
 设置UI布局
 */
- (void)setupSubViews {
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.publishBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.titleTextView];
    [self.view addSubview:self.contentTextView];
    
    self.splitLine = [UIView new];
    self.splitLine.backgroundColor = [UIColor brownColor];
    [self.view addSubview:self.splitLine];
    
    [self.titleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@0);
        make.height.equalTo(@38);
    }];
    
    [self.splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.titleTextView.mas_bottom);
        make.height.equalTo(@(.5f));
    }];
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.splitLine.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
}

/**
 插入图片
 
 @param image 图片image
 */
- (void)setupImage:(UIImage *)image {
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.contentTextView.attributedText];
    UIFont *font = [UIFont systemFontOfSize:15];
    
    NSData *imgData = UIImageJPEGRepresentation(image, 0.9);
    YYImage *img = [YYImage imageWithData:imgData];
    img.preloadAllAnimatedImageFrames = YES;
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    imageView.autoPlayAnimatedImage = NO;
    imageView.clipsToBounds = YES;
    [imageView startAnimating];
    CGSize size = imageView.size;
    CGFloat textViewWidth = kScreenWidth - 32.0;
    size = CGSizeMake(textViewWidth, size.height * textViewWidth / size.width);
    NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleAspectFit attachmentSize:size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    
    
    YYTextView * desTextView = [YYTextView new];
    desTextView.delegate = self;
    desTextView.contentInset = UIEdgeInsetsMake(5, 50, -5, -50);
    desTextView.text = @"可在此编辑图片描述信息";
    desTextView.bounds = CGRectMake(0, 0, kScreenWidth - 32, 50);
    desTextView.font = [UIFont systemFontOfSize:12];
    desTextView.textAlignment = NSTextAlignmentCenter;
    desTextView.textColor = [UIColor grayColor];
    desTextView.scrollEnabled = NO;
    NSMutableAttributedString *attachText2 = [NSMutableAttributedString attachmentStringWithContent:desTextView contentMode:UIViewContentModeCenter attachmentSize:desTextView.size alignToFont:[UIFont systemFontOfSize:12] alignment:YYTextVerticalAlignmentCenter];
    [attachText appendAttributedString:attachText2];
    
    //绑定图片和描述输入框
    [attachText setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:attachText.rangeOfAll];
    
    [text insertAttributedString:attachText atIndex:self.contentTextView.selectedRange.location];
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    
    text.font = font;
    self.contentTextView.attributedText = text;
    [self.contentTextView becomeFirstResponder];
    self.contentTextView.selectedRange = NSMakeRange(self.contentTextView.text.length, 0);
}

#pragma mark -

- (void)clickToPublish {
    [self.imagesArr removeAllObjects];
    [self.desArr removeAllObjects];
    [self.imageUrlsArr removeAllObjects];
    
    NSAttributedString *content = self.contentTextView.attributedText;
    NSString *text = [self.contentTextView.text copy];
    
    [content enumerateAttributesInRange:NSMakeRange(0, text.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        YYTextAttachment *att = attrs[@"YYTextAttachment"];
        if (att) {
            if ([att.content isKindOfClass:[YYTextView class]]) {
                YYTextView * textView = att.content;
                [self.desArr addObject:textView.text];
            }else{
                YYAnimatedImageView *imgView = att.content;
                [self.imagesArr addObject:imgView.image];
                [self.imageUrlsArr addObject:@"http://www.baidu.com"];
            }
        }
    }];
    self.contentStr = [text stringByReplacingOccurrencesOfString:@"\U0000fffc\U0000fffc" withString:@"<我是图片>"];
    [self makeHtmlString:_imageUrlsArr desArr:_desArr contentStr:_contentStr];
}

- (NSString *)makeHtmlString:(NSMutableArray *)imageUrlArr desArr:(NSMutableArray *)desArr contentStr:(NSString *)contentStr {
    NSString * htmlStr = @"";
    //组装图片标签
    NSMutableArray * imgTagArr = [NSMutableArray array];
    for (int i = 0; i < imageUrlArr.count; i ++) {
        NSString * urlStr = imageUrlArr[i];
        NSString * imgTag  = [@"<img>\n" stringByAppendingString:[[@"<url>" stringByAppendingString:urlStr] stringByAppendingString:@"</url>\n"]];
        for (int j = 0; j < desArr.count; j ++) {
            if (i == j) {
                NSString * desStr = desArr[j];
                imgTag = [[imgTag stringByAppendingString:[[@"<des>" stringByAppendingString:desStr] stringByAppendingString:@"</des>\n"]] stringByAppendingString:@"</img>\n"];
            }
        }
        [imgTagArr addObject:imgTag];
    }
    
    //组装文字标签 和图片标签
    NSArray * textArr = [contentStr componentsSeparatedByString:@"<我是图片>"];
    for (int i= 0; i < textArr.count; i ++) {
        NSString * pTag = [[@"<p>" stringByAppendingString:textArr[i]]stringByAppendingString:@"</p>\n"];
        htmlStr = [NSString stringWithFormat:@"%@%@",htmlStr,pTag];
        for (int j = 0; j < imgTagArr.count; j ++) {
            if (i == j) {
                htmlStr = [NSString stringWithFormat:@"%@%@",htmlStr,imgTagArr[j]];
            }
        }
    }
    
    htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"<p>\n</p>" withString:@""];
    htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"<p></p>" withString:@""];
    NSLog(@"这是转化后的html格式的图文内容----%@",htmlStr);
    return htmlStr;
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    CGFloat scale = [UIScreen mainScreen].scale;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    /** 遍历选择的所有图片*/
    for (NSInteger i = 0; i < assets.count; i++) {
        PHAsset *asset = assets[i];
        CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
        
        /** 获取图片*/
        [[PHImageManager defaultManager] requestImageForAsset:asset
                                                   targetSize:size
                                                  contentMode:PHImageContentModeDefault
                                                      options:options
                                                resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                    /** 刷新*/
                                                    [self setupImage:result];
                                                }];
    }
}

#pragma mark YYTextViewDelegate

- (void)textViewDidChange:(YYTextView *)textView {
    if (textView.text.length > 100 && textView.tag != 1000) {
        textView.text = [textView.text substringToIndex:100];
    }
    
    if (textView == self.titleTextView) {
        if (textView.text.length > 60) {
            textView.text = [textView.text substringToIndex:60];
        }
        [self.titleTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            float height = self.titleTextView.contentSize.height;
            make.height.equalTo(@(MAX(height, 38)));
        }];
    }
    
}

- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView == self.titleTextView) {
        if ([text isEqualToString:@"\n"]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - setter

- (YYTextView *)titleTextView {
    if (!_titleTextView) {
        YYTextView *textView = [[YYTextView alloc] initWithFrame:CGRectMake(0, getRectNavAndStatusHight, self.view.width, 38)];
        textView.backgroundColor = CollectViewBG;
        textView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 10);
        textView.contentInset = UIEdgeInsetsZero;
        textView.scrollIndicatorInsets = textView.contentInset;
        textView.delegate = self;
        textView.placeholderText = @"请输入标题（选填）";
        textView.font = [UIFont systemFontOfSize:15];
        textView.placeholderFont = [UIFont systemFontOfSize:15];
        textView.selectedRange = NSMakeRange(textView.text.length, 0);
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        textView.allowsPasteImage = YES;
        textView.allowsPasteAttributedString = YES;
        textView.typingAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
        textView.inputAccessoryView = [self titleFieldBar];
        
        
        _titleTextView = textView;
    }
    return _titleTextView;
}

- (YYTextView *)contentTextView {
    if (!_contentTextView) {
        YYTextView *textView = [[YYTextView alloc] initWithFrame:CGRectMake(0, getRectNavAndStatusHight + 45, self.view.width, self.view.height - 45)];
        textView.backgroundColor = CollectViewBG;
        textView.tag = 1000;
        textView.textContainerInset = UIEdgeInsetsMake(20, 16, 20, 16);
        textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        textView.scrollIndicatorInsets = textView.contentInset;
        textView.delegate = self;
        textView.placeholderText = @"写下您的见闻";
        textView.font = [UIFont systemFontOfSize:15];
        textView.placeholderFont = [UIFont systemFontOfSize:15];
        textView.selectedRange = NSMakeRange(textView.text.length, 0);
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        textView.allowsPasteImage = YES;
        textView.allowsPasteAttributedString = YES;
        textView.typingAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
        textView.inputAccessoryView = [self textViewBar];
        
        _contentTextView = textView;
    }
    return _contentTextView;
}

- (UIToolbar *)textViewBar {
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    // 空白格
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    // 关闭箭头
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 19, 11);
    [btn setImage:[UIImage imageNamed:@"icon_down2"] forState:UIControlStateNormal];
    [btn bk_addEventHandler:^(id sender) {
        [self.view endEditing:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:btn];
    // 添加图片
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 20, 18);
    [btn1 setImage:[UIImage imageNamed:@"icon_addphoto"] forState:UIControlStateNormal];
    [btn1 bk_addEventHandler:^(id sender) {
        [self presentViewController:self.imagePickerVc animated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    bar.items = @[left, space, right];
    return bar;
}

- (UIToolbar *)titleFieldBar {
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    // 空白格
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    // 关闭箭头
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 19, 11);
    
    [btn setImage:[UIImage imageNamed:@"icon_down2"] forState:UIControlStateNormal];
    [btn bk_addEventHandler:^(id sender) {
        [self.view endEditing:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:btn];
    bar.items = @[left, space];
    
    return bar;
}

-(TZImagePickerController *)imagePickerVc
{
    _imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    _imagePickerVc.allowPickingOriginalPhoto = YES;
    _imagePickerVc.naviBgColor = [UIColor whiteColor];
    _imagePickerVc.naviTitleColor = [UIColor blueColor];
    _imagePickerVc.barItemTextColor = [UIColor blueColor];
    _imagePickerVc.statusBarStyle = UIStatusBarStyleDefault;
    _imagePickerVc.delegate = self;
    _imagePickerVc.allowTakePicture = NO;
    _imagePickerVc.allowPickingVideo = NO;
    _imagePickerVc.allowPickingGif = NO;
    return _imagePickerVc;
}

-(UIButton *)publishBtn
{
    if (!_publishBtn) {
        _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _publishBtn.bounds = CGRectMake(0, 0, 40, 44);
        [_publishBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_publishBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        _publishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_publishBtn bk_addEventHandler:^(id sender) {
            [self clickToPublish];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishBtn;
}

-(NSMutableArray *)imageUrlsArr{
    if (!_imageUrlsArr) {
        _imageUrlsArr = [NSMutableArray array];
    }
    return _imageUrlsArr;
}
-(NSMutableArray *)imagesArr{
    if (!_imagesArr) {
        _imagesArr = [NSMutableArray array];
    }
    return _imagesArr;
}
-(NSMutableArray *)desArr{
    if (!_desArr) {
        _desArr = [NSMutableArray array];
    }
    return _desArr;
}

@end
