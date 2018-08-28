//
//  CDWebVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/7.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDWebViewController.h"
#import <WebKit/WebKit.h>

@interface CDWebViewController () <WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation CDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url = self.params[@"url"];
    self.title = url;
    
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:self.webView];
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 2)];
    self.progressView.progressTintColor = [UIColor greenColor];
    [self.view addSubview:self.progressView];
    
    // 给webview添加监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
}

// 监听事件处理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress  >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:YES];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
}

@end
