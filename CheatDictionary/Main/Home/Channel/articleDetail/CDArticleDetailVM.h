//
//  CDArticleDetailVM.h
//  CheatDictionary
//
//  Created by zzy on 2018/9/6.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDListBaseVM.h"
#import "CDDiscussionDetailModel.h"

@interface CDArticleDetailVM : CDListBaseVM

@property (nonatomic, strong) NSArray<NSString *> *atricleSourceArray;

@property (nonatomic, strong) NSArray<CDDiscussionDetailModel *> *commentArray;

@end
