//
//  CDPersonListVM.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/14.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDPersonListVM.h"
#import "CDPersonRecModel.h"
#import "CDPersonRecCell.h"

@implementation CDPersonListVM

- (void)loadData {
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < 13; i++) {
        CDPersonRecModel *roomModel = [CDPersonRecModel new];
        roomModel.icon = @"icon_avatar_default";
        roomModel.name = @"贝爷2号";
        roomModel.desc1 = @"擅长摸鱼、划水";
        roomModel.desc2 = @"粉丝 10W+";
        roomModel.uri = @"CDUserCenterVC";
        [mutableArray addObject:roomModel];
    }
    self.objects = mutableArray;
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDPersonRecCell"      : [CDPersonRecCell class],
             };
}

@end
