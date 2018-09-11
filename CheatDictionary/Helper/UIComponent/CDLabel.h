//
//  CDLabel.h
//  CheatDictionary
//
//  Created by zzy on 2018/8/7.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CDVerticalAlignment) {
    CDVerticalAlignmentTop        = 0,
    CDVerticalAlignmentMiddle     = 1,
    CDVerticalAlignmentBottom     = 2,
};

@interface CDLabel : UILabel

@property (nonatomic, assign) CDVerticalAlignment verticalAlignment;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) CGFloat lineSpace;

- (void)setFontSize:(int32_t)fontSize;

@end
