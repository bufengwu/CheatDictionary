//
//  FNHotTopicHeaderModel.h
//  CheatDictionary
//
//  Created by zhengyi on 2019/3/2.
//  Copyright © 2019 朱正毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDChannelCoverModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNHotTopicHeaderModel : NSObject

@property (nonatomic, strong) NSString  *uri;   //跳转链接
@property (nonatomic, strong) NSArray <CDChannelCoverModel *>*items;

@end

NS_ASSUME_NONNULL_END
