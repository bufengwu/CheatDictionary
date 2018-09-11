//
//  CDLabel.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/7.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDLabel.h"

@implementation CDLabel

- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    self.textColor = [UIColor colorWithWhite:153.f / 255.f alpha:1.f];
    self.font = [UIFont systemFontOfSize:12.f];
    self.numberOfLines = 1;
    self.clipsToBounds = YES;
}

- (void)setText:(NSString *)text
{
    if (!self.lineSpace || !text.length) {
        [super setText:text];
    } else {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:self.lineSpace];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
        [attrStr addAttribute:NSParagraphStyleAttributeName
                        value:style
                        range:NSMakeRange(0, text.length)];
        self.attributedText = attrStr;
    }
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if (!self.lineSpace) {
        [super setAttributedText:attributedText];
    } else {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:self.lineSpace];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
        [attrStr addAttribute:NSParagraphStyleAttributeName
                        value:style
                        range:NSMakeRange(0, attributedText.length)];
        [super setAttributedText:attrStr];
    }
}

- (void)setFontSize:(int32_t)fontSize
{
    self.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setCDVerticalAlignment:(CDVerticalAlignment)verticalAlignment
{
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case CDVerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case CDVerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case CDVerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.f;
    }
    return textRect;
}

- (void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect
                         limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    size.width  += (self.insets.left + self.insets.right);
    size.height += (self.insets.top + self.insets.bottom);
    return size;
}

@end
