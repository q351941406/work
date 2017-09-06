//
//  GzwThemeTool.m
//  彩票
//
//  Created by mac on 2017/6/10.
//  Copyright © 2017年 彩票. All rights reserved.
//

#import "GzwThemeTool.h"
#import "Chameleon.h"
static NSArray *colorComplementary;
static NSArray *colorTriadic;
static NSArray *colorAnalogous;
static NSArray *colorForText;
@implementation GzwThemeTool
+(void)setup
{
    colorComplementary = [NSArray arrayOfColorsWithColorScheme:ColorSchemeComplementary usingColor:[GzwThemeTool theme] withFlatScheme:YES];
    colorTriadic = [NSArray arrayOfColorsWithColorScheme:ColorSchemeTriadic usingColor:[GzwThemeTool theme] withFlatScheme:YES];
    colorAnalogous = [NSArray arrayOfColorsWithColorScheme:ColorSchemeAnalogous usingColor:[GzwThemeTool theme] withFlatScheme:YES];
    
    
    colorForText = [NSArray arrayOfColorsWithColorScheme:ColorSchemeAnalogous usingColor:FlatBlackDark withFlatScheme:YES];
    [Chameleon setGlobalThemeUsingPrimaryColor:[GzwThemeTool theme] withSecondaryColor:nil andContentStyle:UIContentStyleContrast];
    [[UIButton appearanceWhenContainedInInstancesOfClasses:@[[UITableView class]]] setBackgroundColor:[UIColor clearColor]];
    
    
    
}
+(UIColor *)theme
{
    return FlatYellow;
}
+(UIColor *)backgroudTheme
{
    return colorComplementary[1];
}
+(UIColor *)cellBackgroudTheme
{
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
}
+(UIColor *)tabBarBackgroudTheme
{
    return [GzwThemeTool theme];
}
+(UIColor *)titleTextTheme;
{
    return colorAnalogous[1];
}
+(UIColor *)cellIconFirstTheme
{
    return colorAnalogous[4];
}
+(UIColor *)cellSeparatorTheme
{
    return [UIColor colorWithRed:52.0f/255.0f green:53.0f/255.0f blue:61.0f/255.0f alpha:1];
}
+(UIColor *)subTitleTextTheme
{
    return FlatWhite;
}
+(UIColor *)currentPageColor
{
    return RandomFlatColor;
}
+(UIColor *)pageColor
{
    return RandomFlatColor;
}
+(UIColor *)progressColor
{
    return colorAnalogous[0];
}
+(UIColor *)random
{
    return RandomFlatColor;
}
+(UIColor *)subTitleTextSecondTheme
{
    return FlatGrayDark;
}
+(UIColor *)complementaryFlatColor
{
    return ComplementaryFlatColor([GzwThemeTool theme]);
}
@end
