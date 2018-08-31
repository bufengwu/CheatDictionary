//
//  CDLoginVC.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/16.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDLoginVC.h"

#import "CDUserCenterVC.h"

@interface CDLoginVC ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftCloseButton;
@property (weak, nonatomic) IBOutlet UITextField *telInput;
@property (weak, nonatomic) IBOutlet UITextField *safeCodeInput;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation CDLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NavbarColor;
    self.containerView.backgroundColor = MainLightBrownColor;
}

- (IBAction)closeLoginView:(id)sender {
    if ([self.navigationController.viewControllers indexOfObject:self] == 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)fetchIdentifyCode:(id)sender {
    
}

- (IBAction)login:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
    [[CDRouter shared] pushUrl:@"CDUserCenterVC" animated:NO];
    
}
- (IBAction)transPasswordInput:(id)sender {
    
}


@end
