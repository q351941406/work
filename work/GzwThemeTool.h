//
//  GzwThemeTool.h
//  彩票
//
//  Created by mac on 2017/6/10.
//  Copyright © 2017年 彩票. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chameleon.h"
@import UIKit;
@interface GzwThemeTool : NSObject
+(void)setup;

+(UIColor *)theme;
+(UIColor *)backgroudTheme;
+(UIColor *)tabBarBackgroudTheme;

+(UIColor *)cellBackgroudTheme;
+(UIColor *)cellSeparatorTheme;// cell分割线
+(UIColor *)cellIconFirstTheme;

+(UIColor *)tintTheme;
+(UIColor *)textTheme;
+(UIColor *)titleTextTheme;
+(UIColor *)subTitleTextTheme;// 一级子标题
+(UIColor *)subTitleTextSecondTheme; // 二级子标题
+(UIColor *)titleTheme;
+(UIColor *)positiveTheme;
+(UIColor *)negativeTheme;
+(UIColor *)clearTheme;

+(UIColor *)progressColor;
+(UIColor *)pageColor;
+(UIColor *)currentPageColor;

+(UIColor *)random;
+(UIColor *)complementaryFlatColor;// 获取一个跟主题色相对比的颜色
@end
