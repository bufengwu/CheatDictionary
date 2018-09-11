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

//tableview空白视图的刷新事件，子类赋值
@property (nonatomic, strong) dispatch_block_t refreshBlock;

@end
