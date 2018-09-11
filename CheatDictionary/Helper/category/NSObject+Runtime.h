//
//  NSObject+Runtime.h
//  CheatDictionary
//
//  Created by zzy on 2018/9/7.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Runtime)

@property (nonatomic, strong, readonly) NSMutableArray *associatedObjectNames;

/**
 *  为当前object动态增加分类
 *
 *  @param propertyName   分类名称
 *  @param value  分类值
 *  @param policy 分类内存管理类型
 */
- (void)objc_setAssociatedObject:(NSString *)propertyName value:(id)value policy:(objc_AssociationPolicy)policy;
/**
 *  获取当前object某个动态增加的分类
 *
 *  @param propertyName 分类名称
 *
 *  @return 值
 */
- (id)objc_getAssociatedObject:(NSString *)propertyName;
/**
 *  删除动态增加的所有分类
 */
- (void)objc_removeAssociatedObjects;

/**
 *  获取对象的所有属性
 *
 *  @return 属性dict
 */
- (NSArray *)getProperties;

#pragma mark -

//覆盖实例方法
+ (void)overrideInstanceMethod:(SEL)origSelector withInstanceMethod:(SEL)newSelector;

//覆盖类方法
+ (void)overrideClassMethod:(SEL)origSelector withClassMethod:(SEL)newSelector;


//拦截实例方法
+ (void)exchangeInstanceMethod:(SEL)origSelector withInstanceMethod:(SEL)newSelector;

//拦截类方法
+ (void)exchangeClassMethod:(SEL)origSelector withClassMethod:(SEL)newSelector;

@end
