//
//  YLDargSortItemModel.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/23.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "YLDargSortItemModel.h"

@implementation YLDargSortItemModel

- (void)setTitle:(NSString *)title {
    _title = title;

    if (!_size.width) {
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}];
        _size = CGSizeMake(size.width + 20, 20);
    }    
}

@end
