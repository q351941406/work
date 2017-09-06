//
//  HJBRegexTool.h
//  鸿金宝
//
//  Created by leinian on 15/7/8.
//  Copyright (c) 2015年 linhai&benjieming. All rights reserved.
//  正则表达式的工具类

#import <Foundation/Foundation.h>

@interface GzwRegexTool : NSObject
/**
 *  正则表达式方法
 *
 *  @param textString 传需要判断的字符串
 *  @param Predicate  表达式语句
 */
+(BOOL)validateNumber:(NSString *)textString  Predicate:(NSString *)Predicate;
/**
 *  将字符串里的空格全去掉
 *
 *  @param str 需要去空格的字符串
 */
+(NSString *)replaceWithStr:(NSString *)str;
/**
 *  判断字符串里是否有表情
 *
 *  @param str 需要判断的字符串
 *  return 0:没有
 */
+ (BOOL)isContainsEmoji:(NSString *)string;

/**
 *  指定字符串的长度范围
 *
 *  @param range  8～16的范围 [GzwRegexTool limitRange:NSMakeRange(8, 16) string:@"12345678"]
 *  @param string 限制对象
 *
 *  @return YES ＝在范围内 ， NO ＝不在指定范围
 */
+(BOOL)limitRange:(NSRange)range string:(NSString *)string;



// 是否为URL
+(BOOL)gzw_isUrl:(NSString *)str;
// 是否为手机号码
+(BOOL)isPhoneNumber:(NSString *)phone;
// 邮箱
+ (BOOL)validateEmail:(NSString *)email;
//车牌号验证
+ (BOOL)validateCarNo:(NSString *)carNo;
//车型
+ (BOOL)validateCarType:(NSString *)CarType;
//用户名
+ (BOOL)validateUserName:(NSString *)name;
//密码
+ (BOOL)validatePassword:(NSString *)passWord;
//昵称
+ (BOOL)validateNickname:(NSString *)nickname;
//身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard;
@end
