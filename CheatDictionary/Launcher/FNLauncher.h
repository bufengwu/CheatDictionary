//
//  FNLauncher.h
//  CheatDictionary
//
//  Created by zzy on 2019/2/28.
//  Copyright © 2019 朱正毅. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNLauncher : NSObject

+ (void)tryShowSplashWithDismissBlock:(dispatch_block_t)completionBlock;

@end

NS_ASSUME_NONNULL_END
