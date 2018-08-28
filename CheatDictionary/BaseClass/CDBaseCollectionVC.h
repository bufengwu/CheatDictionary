//
//  CDBaseCollectionVC.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseViewController.h"
#import "CDListBaseVM.h"

@interface CDBaseCollectionVC : UICollectionViewController

@property (nonatomic, strong) CDListBaseVM *viewModel;

@end
