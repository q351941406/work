//
//  NSData+GZW.m
//  children
//
//  Created by sky33 on 15/9/17.
//  Copyright (c) 2015年 sky32. All rights reserved.
//

#import "NSDate+GZW.h"

@implementation NSDate (GZW)
+(NSDate*)gzw_convertDateFromString:(NSString*)uiDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date=[formatter dateFromString:uiDate];
    return date;
}
+(NSString *)compareDate:(NSDate *)date{
    // 以秒为单位的对象
    NSTimeInterval secondsPerDay = 24 * 60 * 60;// 算出一天有多少秒
    NSDate *today = [[NSDate alloc] init];// 获取当前时间
    NSDate *tomorrow, *yesterday;// 同时声明两个对象(少见)
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];// 初始化个date在加上多少秒,相当于明天的现在
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];// 初始化个date减去多少秒,相当于昨天的现在
    
    // 一直截取第10个字符串
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    
    // 返回当前系统所使用的时区。
    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    // 算出源日期与世界标准时间的偏移量
    NSInteger interval = [zone secondsFromGMTForDate: date];
    // 源时间＋时区时间＝上海时间
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    // 获得当前时间
    NSString * dateString = [[localeDate description] substringToIndex:10];
    // 判断是否为今天
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else
    {
        return dateString;
    }
}
+(NSTimeInterval)todayInitWithDate:(NSDate *)date
{
    // 获取当前时间
    NSDate *currenDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];// 设置时间格式
    NSString *dateString = [dateFormatter stringFromDate:currenDate];// 时间转字符串
    // 拼接个0点时间，就是凌晨了。。
    NSString *appendStr = [dateString stringByAppendingString:@" 00:00:00"];
    
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];// 设置时间格式(一定要，因为之前的格式不适用)
    //    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    //    [dateFormatter setTimeZone:zone];
    NSDate *timestamp = [dateFormatter dateFromString:appendStr];// 字符串转date
    return [timestamp timeIntervalSince1970];// date转时间时间戳
}
+(NSTimeInterval)monthInitWithDate:(NSDate *)date
{
    // 获取当前时间
    NSDate *currenDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-"];// 设置时间格式
    NSString *dateString = [dateFormatter stringFromDate:currenDate];// 时间转字符串
    // 拼接个0点时间，就是凌晨了。。
    NSString *appendStr = [dateString stringByAppendingString:@"01 00:00:00"];
    
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];// 设置时间格式(一定要，因为之前的格式不适用)
    //    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    //    [dateFormatter setTimeZone:zone];
    NSDate *timestamp = [dateFormatter dateFromString:appendStr];// 字符串转date
    return [timestamp timeIntervalSince1970];// date转时间时间戳
}
+(NSInteger)weeksToday:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];// 设置calendar的时区
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
    return week;
}
+(NSDate *)currentDateWithDate:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return [date  dateByAddingTimeInterval: interval];
}
+(NSTimeInterval)trackTimeInterval:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];// 设置时间格式(一定要，因为之前的格式不适用)
    //    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    //    [dateFormatter setTimeZone:zone];
    NSDate *timestamp = [dateFormatter dateFromString:dateStr];
    NSTimeInterval interval = [timestamp timeIntervalSince1970];// date转时间时间戳
    return  interval;
}
-(NSString*)getChineseCalendarWithDate:(NSDate *)date{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSLog(@"%zd_%zd_%zd",localeComp.year,localeComp.month,localeComp.day);
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@_%@_%@",y_str,m_str,d_str];
    
    return chineseCal_str;  
}
+(NSTimeInterval)gzw_getChinaTimestamp
{
    // 默认获取到的是世界标准时间UTC
    NSDate *date = [NSDate date];
    // 设置时区
    NSTimeZone * zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    // 设置格式，非常重要，转换哪个时区的时间戳就是根据这个计算的
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:zone];
    NSString *eee = [formatter stringFromDate:date];
    date = [formatter dateFromString:eee];
    return date.timeIntervalSince1970;
}

- (NSUInteger)gzw_day {
    return [NSDate gzw_day:self];
}

- (NSUInteger)gzw_month {
    return [NSDate gzw_month:self];
}

- (NSUInteger)gzw_year {
    return [NSDate gzw_year:self];
}

- (NSUInteger)gzw_hour {
    return [NSDate gzw_hour:self];
}

- (NSUInteger)gzw_minute {
    return [NSDate gzw_minute:self];
}

- (NSUInteger)gzw_second {
    return [NSDate gzw_second:self];
}

+ (NSUInteger)gzw_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)gzw_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)gzw_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)gzw_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)gzw_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)gzw_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)gzw_daysInYear {
    return [NSDate gzw_daysInYear:self];
}

+ (NSUInteger)gzw_daysInYear:(NSDate *)date {
    return [self gzw_isLeapYear:date] ? 366 : 365;
}

- (BOOL)gzw_isLeapYear {
    return [NSDate gzw_isLeapYear:self];
}

+ (BOOL)gzw_isLeapYear:(NSDate *)date {
    NSUInteger year = [date gzw_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)gzw_formatYMD {
    return [NSDate gzw_formatYMD:self];
}

+ (NSString *)gzw_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",[date gzw_year],[date gzw_month], [date gzw_day]];
}

- (NSUInteger)gzw_weeksOfMonth {
    return [NSDate gzw_weeksOfMonth:self];
}

+ (NSUInteger)gzw_weeksOfMonth:(NSDate *)date {
    return [[date gzw_lastdayOfMonth] gzw_weekOfYear] - [[date gzw_begindayOfMonth] gzw_weekOfYear] + 1;
}

- (NSUInteger)gzw_weekOfYear {
    return [NSDate gzw_weekOfYear:self];
}

+ (NSUInteger)gzw_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date gzw_year];
    
    NSDate *lastdate = [date gzw_lastdayOfMonth];
    
    for (i = 1;[[lastdate gzw_dateAfterDay:-7 * i] gzw_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)gzw_dateAfterDay:(NSUInteger)day {
    return [NSDate gzw_dateAfterDate:self day:day];
}

+ (NSDate *)gzw_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)gzw_dateAfterMonth:(NSUInteger)month {
    return [NSDate gzw_dateAfterDate:self month:month];
}

+ (NSDate *)gzw_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)gzw_begindayOfMonth {
    return [NSDate gzw_begindayOfMonth:self];
}

+ (NSDate *)gzw_begindayOfMonth:(NSDate *)date {
    return [self gzw_dateAfterDate:date day:-[date gzw_day] + 1];
}

- (NSDate *)gzw_lastdayOfMonth {
    return [NSDate gzw_lastdayOfMonth:self];
}

+ (NSDate *)gzw_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self gzw_begindayOfMonth:date];
    return [[lastDate gzw_dateAfterMonth:1] gzw_dateAfterDay:-1];
}

- (NSUInteger)gzw_daysAgo {
    return [NSDate gzw_daysAgo:self];
}

+ (NSUInteger)gzw_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)gzw_weekday {
    return [NSDate gzw_weekday:self];
}

+ (NSInteger)gzw_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)gzw_dayFromWeekday {
    return [NSDate gzw_dayFromWeekday:self];
}

+ (NSString *)gzw_dayFromWeekday:(NSDate *)date {
    switch([date gzw_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)gzw_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)gzw_isToday {
    return [self gzw_isSameDay:[NSDate date]];
}

- (NSDate *)gzw_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

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
+ (NSString *)gzw_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)gzw_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date gzw_stringWithFormat:format];
}

- (NSString *)gzw_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)gzw_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)gzw_daysInMonth:(NSUInteger)month {
    return [NSDate gzw_daysInMonth:self month:month];
}

+ (NSUInteger)gzw_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date gzw_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)gzw_daysInMonth {
    return [NSDate gzw_daysInMonth:self];
}

+ (NSUInteger)gzw_daysInMonth:(NSDate *)date {
    return [self gzw_daysInMonth:date month:[date gzw_month]];
}

- (NSString *)gzw_timeInfo {
    return [NSDate gzw_timeInfoWithDate:self];
}

+ (NSString *)gzw_timeInfoWithDate:(NSDate *)date {
    return [self gzw_timeInfoWithDateString:[self gzw_stringWithDate:date format:[self gzw_ymdHmsFormat]]];
}

+ (NSString *)gzw_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self gzw_dateWithString:dateString format:[self gzw_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate gzw_month] - [date gzw_month]);
    int year = (int)([curDate gzw_year] - [date gzw_year]);
    int day = (int)([curDate gzw_day] - [date gzw_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate gzw_month] == 1 && [date gzw_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self gzw_daysInMonth:date month:[date gzw_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate gzw_day] + (totalDays - (int)[date gzw_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate gzw_month];
            int preMonth = (int)[date gzw_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)gzw_ymdFormat {
    return [NSDate gzw_ymdFormat];
}

- (NSString *)gzw_hmsFormat {
    return [NSDate gzw_hmsFormat];
}

- (NSString *)gzw_ymdHmsFormat {
    return [NSDate gzw_ymdHmsFormat];
}

+ (NSString *)gzw_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)gzw_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)gzw_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self gzw_ymdFormat], [self gzw_hmsFormat]];
}

- (NSDate *)gzw_offsetYears:(int)numYears {
    return [NSDate gzw_offsetYears:numYears fromDate:self];
}

+ (NSDate *)gzw_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)gzw_offsetMonths:(int)numMonths {
    return [NSDate gzw_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)gzw_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)gzw_offsetDays:(int)numDays {
    return [NSDate gzw_offsetDays:numDays fromDate:self];
}

+ (NSDate *)gzw_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)gzw_offsetHours:(int)hours {
    return [NSDate gzw_offsetHours:hours fromDate:self];
}

+ (NSDate *)gzw_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}
@end
