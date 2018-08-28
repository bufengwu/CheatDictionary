//
//  CDBaseCollectionHeaderView.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/4.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDBaseCollectionHeaderView : UICollectionReusableView

- (void)installWithObject:(id)object;

+ (CGSize)getSizeWithObject:(id)object;

@end
