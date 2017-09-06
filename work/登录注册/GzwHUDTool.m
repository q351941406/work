//
//  GzwHUDTool.m
//  children
//
//  Created by sky33 on 15/10/22.
//  Copyright (c) 2015年 sky32. All rights reserved.
//

#import "GzwHUDTool.h"
#import "SVProgressHUD.h"
@implementation GzwHUDTool

+(void)showErrorWithStatus:(NSString *)string
{
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];// 弹窗黑
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];// 窗口变黑
    [SVProgressHUD showErrorWithStatus:string];
}
+(void)showSuccessWithStatus:(NSString *)string
{
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];// 弹窗黑底
    [SVProgressHUD showSuccessWithStatus:string];
}
+(void)showWithStatus:(NSString *)string
{
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];// 不允许用户交互
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];// 弹窗黑底
    [SVProgressHUD showWithStatus:string];
}
+(void)showInfoWithStatus:(NSString *)string
{
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];// 不允许用户交互
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];// 弹窗黑底
    [SVProgressHUD showInfoWithStatus:string];
}
+(BOOL)isVisible
{
    return [SVProgressHUD isVisible];
}
+(void)dismiss
{
    [SVProgressHUD dismiss];
}
@end
