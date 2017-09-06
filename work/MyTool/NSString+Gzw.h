//
//  NSString+Gzw.h
//  跑腿
//
//  Created by mac on 16/1/21.
//  Copyright © 2016年 paotui. All rights reserved.
//


@import UIKit;
@import Foundation;
@interface NSString (Gzw)
/**
 *  数字转中文大写
 *
 *  @param money 需要转的数字
 *
 *  @return 中文大写
 */
-(NSString *)digitUppercaseWithMoney:(NSString *)money;
/**
 *  从一个字符串中街区数字部分出来
 *
 *  @param str 目标字符串
 *
 *  @return 数字
 */
+(NSString *)gzw_getNumber:(NSString *)str;
/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)gzw_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)gzw_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)gzw_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)gzw_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)gzw_reverseString:(NSString *)strSrc;
/**
 *  @brief  清除html标签
 *
 *  @return 清除后的结果
 */
- (NSString *)gzw_stringByStrippingHTML;
/**
 *  @brief  清除js脚本
 *
 *  @return 清楚js后的结果
 */
- (NSString *)gzw_stringByRemovingScriptsAndStrippingHTML;
/**
 *  @brief  去除空格
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)gzw_trimmingWhitespace;
/**
 *  @brief  去除字符串与空行
 *
 *  @return 去除字符串与空行的字符串
 */
- (NSString *)gzw_trimmingWhitespaceAndNewlines;

/**
 Returns a NSString in which any occurrences that match the cheat codes
 from Emoji Cheat Sheet <http://www.emoji-cheat-sheet.com> are replaced by the
 corresponding unicode characters.
 
 Example:
 "This is a smiley face :smiley:"
 
 Will be replaced with:
 "This is a smiley face \U0001F604"
 */
- (NSString *)gzw_stringByReplacingEmojiCheatCodesWithUnicode;

/**
 Returns a NSString in which any occurrences that match the unicode characters
 of the emoji emoticons are replaced by the corresponding cheat codes from
 Emoji Cheat Sheet <http://www.emoji-cheat-sheet.com>.
 
 Example:
 "This is a smiley face \U0001F604"
 
 Will be replaced with:
 "This is a smiley face :smiley:"
 */
- (NSString *)gzw_stringByReplacingEmojiUnicodeWithCheatCodes;
/**
 *  @brief  是否包含emoji
 *
 *  @return 是否包含emoji
 */
- (BOOL)gzw_isIncludingEmoji;

/**
 *  @brief  删除掉包含的emoji
 *
 *  @return 清除后的string
 */
- (instancetype)gzw_removedEmojiString;
/**
 *  将数字转成内存大小
 *
 *  @param working 数字
 */
+(NSString *)getMPSize:(unsigned long long int )working;
@end
