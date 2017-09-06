//
//  NSObject+Gzw.h
//  pjh365
//
//  Created by 嗨购 on 16/8/19.
//  Copyright © 2016年 bigkoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Gzw)
/**
 *  浅复制目标的所有属性
 *
 *  @param instance 目标对象
 *
 *  @return BOOL—YES:复制成功,NO:复制失败
 */
- (BOOL)gzw_easyShallowCopy:(NSObject *)instance;

/**
 *  深复制目标的所有属性
 *
 *  @param instance 目标对象
 *
 *  @return BOOL—YES:复制成功,NO:复制失败
 */
- (BOOL)gzw_easyDeepCopy:(NSObject *)instance;
/**
 *  @brief  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)gzw_performAsynchronous:(void(^)(void))block;
/**
 *  @brief  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param wait  是否同步请求
 */
- (void)gzw_performOnMainThread:(void(^)(void))block wait:(BOOL)wait;

/**
 *  @brief  延迟执行代码块
 *
 *  @param seconds 延迟时间 秒
 *  @param block   代码块
 */
- (void)gzw_performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;
//类名
- (NSString *)gzw_className;
+ (NSString *)gzw_className;
//父类名称
- (NSString *)gzw_superClassName;
+ (NSString *)gzw_superClassName;

//实例属性字典
-(NSDictionary *)gzw_propertyDictionary;

//属性名称列表
- (NSArray*)gzw_propertyKeys;
+ (NSArray *)gzw_propertyKeys;

//属性详细信息列表
- (NSArray *)gzw_propertiesInfo;
+ (NSArray *)gzw_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)gzw_propertiesWithCodeFormat;

//方法列表
-(NSArray*)gzw_methodList;
+(NSArray*)gzw_methodList;

-(NSArray*)gzw_methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)gzw_registedClassList;
//实例变量
+ (NSArray *)gzw_instanceVariable;

//协议列表
-(NSDictionary *)gzw_protocolList;
+ (NSDictionary *)gzw_protocolList;


- (BOOL)gzw_hasPropertyForKey:(NSString*)key;
- (BOOL)gzw_hasIvarForKey:(NSString*)key;
/**
 Exchange methods' implementations.
 
 @param originalMethod Method to exchange.
 @param newMethod Method to exchange.
 */
+ (void)gzw_swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod;

/**
 Append a new method to an object.
 
 @param newMethod Method to exchange.
 @param klass Host class.
 */
+ (void)gzw_appendMethod:(SEL)newMethod fromClass:(Class)klass;

/**
 Replace a method in an object.
 
 @param method Method to exchange.
 @param klass Host class.
 */
+ (void)gzw_replaceMethod:(SEL)method fromClass:(Class)klass;

/**
 Check whether the receiver implements or inherits a specified method up to and exluding a particular class in hierarchy.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)gzw_respondsToSelector:(SEL)selector untilClass:(Class)stopClass;

/**
 Check whether a superclass implements or inherits a specified method.
 
 @param selector A selector that identifies a method.
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)gzw_superRespondsToSelector:(SEL)selector;

/**
 Check whether a superclass implements or inherits a specified method.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)gzw_superRespondsToSelector:(SEL)selector untilClass:(Class)stopClass;

/**
 Check whether the receiver's instances implement or inherit a specified method up to and exluding a particular class in hierarchy.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
+ (BOOL)gzw_instancesRespondToSelector:(SEL)selector untilClass:(Class)stopClass;
@end
