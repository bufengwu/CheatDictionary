//
//  NSObject+Runtime.m
//  CheatDictionary
//
//  Created by zzy on 2018/9/7.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)

static char associatedObjectNamesKey;

- (void)setAssociatedObjectNames:(NSMutableArray *)associatedObjectNames
{
    objc_setAssociatedObject(self, &associatedObjectNamesKey, associatedObjectNames,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)associatedObjectNames
{
    NSMutableArray *array = objc_getAssociatedObject(self, &associatedObjectNamesKey);
    if (!array) {
        array = [NSMutableArray array];
        [self setAssociatedObjectNames:array];
    }
    return array;
}

- (void)objc_setAssociatedObject:(NSString *)propertyName value:(id)value policy:(objc_AssociationPolicy)policy
{
    objc_setAssociatedObject(self, (__bridge objc_objectptr_t)propertyName, value, policy);
    [self.associatedObjectNames addObject:propertyName];
}

- (id)objc_getAssociatedObject:(NSString *)propertyName
{
    return objc_getAssociatedObject(self, (__bridge objc_objectptr_t)propertyName);
}

- (void)objc_removeAssociatedObjects
{
    [self.associatedObjectNames removeAllObjects];
    objc_removeAssociatedObjects(self);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"setValue %@ forUndefinedKey %@",value,key);
}

- (void)setNilValueForKey:(NSString *)key
{
    NSLog(@"setNilValue forKey %@",key);
}

/**
 * 获取对象的所有属性,包括父类的。可以一直遍历到JSONModel层。如果不是继承JSONMOdel,最上层为NSObject
 *
 *    @return Properties数组
 */
- (NSArray *)getProperties
{
    NSMutableArray *props = [NSMutableArray array];
    unsigned int outCount, i;
    Class targetClass = [self class];
    while (targetClass != [NSObject class]) {
        objc_property_t *properties = class_copyPropertyList(targetClass, &outCount);
        for (i = 0; i < outCount; i++)
        {
            objc_property_t property = properties[i];
            const char *char_f = property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            [props addObject:propertyName];
        }
        free(properties);
        targetClass = [targetClass superclass];
    }
    return props;
}

/* 获取对象的所有方法 */
- (void)printMothList
{
    unsigned int mothCout_f = 0;
    Method *mothList_f = class_copyMethodList([self class], &mothCout_f);
    for(int i = 0; i < mothCout_f; i++)
    {
        Method temp_f = mothList_f[i];
        //        IMP imp_f = method_getImplementation(temp_f);
        SEL name_f = method_getName(temp_f);
        const char* name_s = sel_getName(name_f);
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding = method_getTypeEncoding(temp_f);
        
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s], arguments, [NSString stringWithUTF8String:encoding]);
    }
    
    free(mothList_f);
}

#pragma mark -

+ (void)overrideInstanceMethod:(SEL)origSelector withInstanceMethod:(SEL)newSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);
    if (!originalMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(origSelector), [self class]);
        return;
    }
    
    Method overrideMethod = class_getInstanceMethod(class, newSelector);
    if (!overrideMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(newSelector), [self class]);
        return;
    }
    
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(overrideMethod),
                                        method_getTypeEncoding(overrideMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_setImplementation(originalMethod, class_getMethodImplementation(self, newSelector));
    }
}

+ (void)overrideClassMethod:(SEL)origSelector withClassMethod:(SEL)newSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getClassMethod(class, origSelector);
    Method overrideMethod = class_getClassMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(overrideMethod),
                                        method_getTypeEncoding(overrideMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_setImplementation(originalMethod, class_getMethodImplementation(self, newSelector));
    }
}


+ (void)exchangeInstanceMethod:(SEL)origSelector withInstanceMethod:(SEL)newSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)exchangeClassMethod:(SEL)origSelector withClassMethod:(SEL)newSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getClassMethod(class, origSelector);
    Method swizzledMethod = class_getClassMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
