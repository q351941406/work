//
//  GzwHUDTool.h
//  children
//
//  Created by sky33 on 15/10/22.
//  Copyright (c) 2015年 sky32. All rights reserved.
//  封装的HUD弹窗工具类

#import <Foundation/Foundation.h>

@interface GzwHUDTool : NSObject
/**
 *  提示错误
 *
 *  @param string 错误文字
 */
+(void)showErrorWithStatus:(NSString *)string;
/**
 *  提示成功
 *
 *  @param string 错误文字
 */
+(void)showSuccessWithStatus:(NSString *)string;
/**
 *  提示等待
 *
 *  @param string 等待文字
 */
+(void)showWithStatus:(NSString *)string;
/**
 *  提示警告
 *
 *  @param string 警告文字
 */
+(void)showInfoWithStatus:(NSString *)string;
/**
 *  是否可见
 *
 *  @return <#return value description#>
 */
+(BOOL)isVisible;
/**
 *  隐藏HUD
 *
 *  @param string 等待文字
 */
+(void)dismiss;
@end
