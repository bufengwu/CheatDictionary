//
//  CDCovergeItemModel.h
//  CheatDictionary
//
//  Created by zzy on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"
#import "CDPersonRecModel.h"

@interface CDCovergeItemModel : CDBaseCellModel

@property (nonatomic, strong) NSArray<CDPersonRecModel *> *items;

@end
