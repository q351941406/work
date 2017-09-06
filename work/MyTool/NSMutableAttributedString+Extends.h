//
//  NSMutableAttributedString+Extends.h
//  pjh365
//
//  Created by Summer on 16/9/21.
//  Copyright © 2016年 SmileForever. All rights reserved.
//


@import UIKit;
@import Foundation;
//self.titleLabel.attributedText = text;

@interface NSMutableAttributedString (Extends)
/**
 *  创建一个属性文本默认的属性(系统字体)
  *  @param string 需要显示的文本

 *  @return 一个属性文本
 */
+ (instancetype)mutableString:(NSString *)string fontSize:(NSInteger )fontSize fontColor:(UIColor *)fontColor;

/**
 *  创建一个属性文本默认的属性(第三方字体)
 *  @param string 需要显示的文本
 */
+ (instancetype)mutableString:(NSString *)string custFontName:(NSString *)fontName fontSize:(NSInteger )fontSize fontColor:(UIColor *)fontColor;


/**
 *  单独设置不一样的字符串以及属性
 *
 */
- (instancetype)setString:(NSString *)setString fontSize:(NSInteger )fontSize fontColor:(UIColor *)fontColor;

@end
