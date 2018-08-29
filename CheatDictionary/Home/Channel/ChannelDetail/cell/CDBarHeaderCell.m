//
//  CDBarHeaderCell.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/9.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBarHeaderCell.h"
#import "CDBarHeaderModel.h"

@implementation CDBarHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CDBarHeaderCell" owner:self options:nil].lastObject;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)installWithObject:(CDBarHeaderModel *)object {
    self.todayLabel.text = [NSString stringWithFormat:@"今日：%@", object.today];
    self.descLabel.text = [NSString stringWithFormat:@"主题：%@", object.all];
    
    self.masterLabel1.text = object.masters[0];
}

@end
