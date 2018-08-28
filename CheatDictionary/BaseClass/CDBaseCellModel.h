//
//  CDBaseCellModel.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDBaseCollectionViewCell.h"

@interface CDBaseCellModel : NSObject

@property (nonatomic, strong) NSString  *uri;   //跳转链接

- (Class)cellClass;

@end
