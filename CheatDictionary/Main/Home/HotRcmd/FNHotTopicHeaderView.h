//
//  FNHotTopicHeaderView.h
//  CheatDictionary
//
//  Created by zhengyi on 2019/3/2.
//  Copyright © 2019 朱正毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNHotTopicHeaderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNHotTopicHeaderViewCell : UIView
@end

@interface FNHotTopicHeaderView : UIView

- (void)bindViewModel:(FNHotTopicHeaderModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
