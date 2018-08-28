//
//  CDBaseTableViewCell.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@implementation CDBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = CollectViewBG;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    return self;
}

- (void)installWithObject:(id)object {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
