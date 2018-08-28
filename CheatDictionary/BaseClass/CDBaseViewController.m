//
//  CDBaseViewController.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/6/30.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseViewController.h"

@interface CDBaseViewController ()

@end

@implementation CDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CollectViewBG;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
