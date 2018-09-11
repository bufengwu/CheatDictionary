//
//  CDSectionModel.h
//  ZYLab
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDShowMoreHeaderModel.h"

@interface CDSectionModel : NSObject

@property (nonatomic, strong) CDShowMoreHeaderModel *headerModel;
@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, assign) UIEdgeInsets sectionEdges;

@end
