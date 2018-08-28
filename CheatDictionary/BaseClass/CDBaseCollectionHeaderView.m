//
//  CDBaseCollectionHeaderView.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/4.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCollectionHeaderView.h"

@implementation CDBaseCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = mainBgColor;
    }
    return self;
}

- (void)installWithObject:(id)object {
    
}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeZero;
}

@end
