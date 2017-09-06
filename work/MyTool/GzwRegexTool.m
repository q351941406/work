//
//  HJBRegexTool.m
//  鸿金宝
//
//  Created by leinian on 15/7/8.
//  Copyright (c) 2015年 linhai&benjieming. All rights reserved.
//

#import "GzwRegexTool.h"

@implementation GzwRegexTool
+(BOOL)limitRange:(NSRange)range string:(NSString *)string
{
    NSString *str = [NSString stringWithFormat:@"^.{%ld,%ld}$",range.location,range.length
];
    if ([GzwRegexTool validateNumber:string Predicate:str]) return YES;
    return NO;
}
+ (BOOL)validateNumber:(NSString *)textString  Predicate:(NSString *)Predicate
{
    NSString *number       = Predicate;
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}

+(NSString *)replaceWithStr:(NSString *)str
{
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}
+(BOOL)isPhoneNumber:(NSString *)phone
{
    if ([GzwRegexTool validateNumber:phone Predicate:@"^1[3|4|5|7|8][0-9]\\d{8}$"]) return YES;
    return NO;
}
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex   = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    if ([GzwRegexTool validateNumber:email Predicate:emailRegex]) return YES;
    return NO;
}
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex   = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    if ([GzwRegexTool validateNumber:carNo Predicate:carRegex]) return YES;
    return NO;
}
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    if ([GzwRegexTool validateNumber:CarType Predicate:CarTypeRegex]) return YES;
    return NO;
}
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex        = @"^[A-Za-z0-9]{6,20}+$";
    if ([GzwRegexTool validateNumber:name Predicate:userNameRegex]) return YES;
    return NO;
}
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex        = @"^[a-zA-Z0-9]{6,20}+$";
    if ([GzwRegexTool validateNumber:passWord Predicate:passWordRegex]) return YES;
    return NO;
}
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex        = @"^[\u4e00-\u9fa5]{2,8}$";
    if ([GzwRegexTool validateNumber:nickname Predicate:nicknameRegex]) return YES;
    return NO;
}
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2                   = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    if ([GzwRegexTool validateNumber:identityCard Predicate:regex2]) return YES;
    return NO;
}
+(BOOL)gzw_isUrl:(NSString *)str
{
    if ([GzwRegexTool validateNumber:str Predicate:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"]) return YES;
    return NO;
}
@end
