//
//  CDPhotoFlowNewsModel.h
//  CheatDictionary
//
//  Created by zzy on 2018/8/21.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"

@interface CDPhotoFlowNewsModel : CDBaseCellModel

@property (nonatomic, copy) NSString *cover;
@property (nonatomic, assign) NSUInteger cover_w;
@property (nonatomic, assign) NSUInteger cover_h;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *author;

@end
