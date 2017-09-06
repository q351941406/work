//
//  NSData+GZW.h
//  children
//
//  Created by sky33 on 15/9/17.
//  Copyright (c) 2015年 sky32. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GZW)
/**
 *  字符串转date
 *
 *  @param uiDate 字符串
 *
 *  @return <#return value description#>
 */
+(NSDate*)gzw_convertDateFromString:(NSString*)uiDate;
/**
 *  判断昨天，今天，明天
 *
 *  @param date 传个日期进来
 *
 *  @return 字符串
 */
+(NSString *)compareDate:(NSDate *)date;
/**
 *  获取今天00:00:00这个时间的时间戳
 *
 *  @param date
 *
 *  @return
 */
+(NSTimeInterval)todayInitWithDate:(NSDate *)date;
/**
 *  获取月初00:00:00这个时间的时间戳
 *
 *  @param date
 *
 *  @return
 */
+(NSTimeInterval)monthInitWithDate:(NSDate *)date;
/**
 *  // 判断今天是星期几
 *
 *  @param 需要判断的时间
 *
 *  @return 1 －－星期天 2－－星期一 3－－星期二 4－－星期三 5－－星期四 6－－星期五 7－－星期六
 */
+(NSInteger)weeksToday:(NSDate *)date;
/**
 *  将date转换为当前时区
 *
 *  @param date 需要转换的date
 *
 *  @return 当前时区的date
 */
+(NSDate *)currentDateWithDate:(NSDate *)date;
/**
 *  任意字符串时间转时间戳
 *
 *  @param dateStr 时间字符串
 *
 *  @return 时间戳
 */
+(NSTimeInterval)trackTimeInterval:(NSString *)dateStr;
/**
 *  判断日期的农历
 *
 *  @param date 指定日期
 *
 *  @return <#return value description#>
 */
-(NSString*)getChineseCalendarWithDate:(NSDate *)date;
/**
 *  获取北京时间的时间戳
 *
 *  @return 
 */
+(NSTimeInterval)gzw_getChinaTimestamp;


/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)gzw_day;
- (NSUInteger)gzw_month;
- (NSUInteger)gzw_year;
- (NSUInteger)gzw_hour;
- (NSUInteger)gzw_minute;
- (NSUInteger)gzw_second;
+ (NSUInteger)gzw_day:(NSDate *)date;
+ (NSUInteger)gzw_month:(NSDate *)date;
+ (NSUInteger)gzw_year:(NSDate *)date;
+ (NSUInteger)gzw_hour:(NSDate *)date;
+ (NSUInteger)gzw_minute:(NSDate *)date;
+ (NSUInteger)gzw_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)gzw_daysInYear;
+ (NSUInteger)gzw_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)gzw_isLeapYear;
+ (BOOL)gzw_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)gzw_weekOfYear;
+ (NSUInteger)gzw_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)gzw_formatYMD;
+ (NSString *)gzw_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)gzw_weeksOfMonth;
+ (NSUInteger)gzw_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)gzw_begindayOfMonth;
+ (NSDate *)gzw_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)gzw_lastdayOfMonth;
+ (NSDate *)gzw_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)gzw_dateAfterDay:(NSUInteger)day;
+ (NSDate *)gzw_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)gzw_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)gzw_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)gzw_offsetYears:(int)numYears;
+ (NSDate *)gzw_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)gzw_offsetMonths:(int)numMonths;
+ (NSDate *)gzw_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)gzw_offsetDays:(int)numDays;
+ (NSDate *)gzw_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)gzw_offsetHours:(int)hours;
+ (NSDate *)gzw_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)gzw_daysAgo;
+ (NSUInteger)gzw_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)gzw_weekday;
+ (NSInteger)gzw_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)gzw_dayFromWeekday;
+ (NSString *)gzw_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)gzw_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)gzw_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)gzw_dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)gzw_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)gzw_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)gzw_stringWithFormat:(NSString *)format;
+ (NSDate *)gzw_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)gzw_daysInMonth:(NSUInteger)month;
+ (NSUInteger)gzw_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)gzw_daysInMonth;
+ (NSUInteger)gzw_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)gzw_timeInfo;
+ (NSString *)gzw_timeInfoWithDate:(NSDate *)date;
+ (NSString *)gzw_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)gzw_ymdFormat;
- (NSString *)gzw_hmsFormat;
- (NSString *)gzw_ymdHmsFormat;
+ (NSString *)gzw_ymdFormat;
+ (NSString *)gzw_hmsFormat;
+ (NSString *)gzw_ymdHmsFormat;
@end
