//
//  FNHotTopicHeaderModel.m
//  CheatDictionary
//
//  Created by zhengyi on 2019/3/2.
//  Copyright © 2019 朱正毅. All rights reserved.
//

#import "FNHotTopicHeaderModel.h"

@implementation FNHotTopicHeaderModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"items":[CDChannelCoverModel class]};
}

@end
