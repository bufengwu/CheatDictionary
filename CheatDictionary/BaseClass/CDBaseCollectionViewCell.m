//
//  CDBaseCell.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCollectionViewCell.h"

@implementation CDBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = CollectCellBG;
    }
    return self;
}

- (void)installWithObject:(id)object {
    
}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeZero;
}

@end
