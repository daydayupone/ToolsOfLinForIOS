//
//  TimesTool.m
//  SecondAndDate
//
//  Created by jiawei on 13-10-10.
//  Copyright (c) 2013年 GitomLJYU. All rights reserved.
//

#import "TimesTool.h"

@implementation TimesTool

#pragma mark -- 得到一天的开始时间值,如@"2012-6-10 00:00:00"，这一天的0点就是开始时间
+(long long int)getBeginDateTimeMsWithNSDate:(NSDate *)date
{
    long long int dtBegin = 0;
    NSDateFormatter * dateForma = [[NSDateFormatter alloc]init];
    [dateForma setDateFormat:@"yyyy-MM-dd"];
    NSString * strDate = [dateForma stringFromDate:date];
    NSString * strDtBegin = [NSString stringWithFormat:@"%@ 00:00:00",strDate];
    [dateForma setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * dateBegin = [dateForma dateFromString:strDtBegin];
    dtBegin = [dateBegin timeIntervalSince1970] * 1000;
    return dtBegin;
}

#pragma mark -- 得到一天的结束时间值,如@"2012-6-10 23:59:59"，这一天的24点前一秒就是结束时间
+(long long int)getEndDateTimeMsWithNSDate:(NSDate *)date
{
    long long int dtEnd = 0;
    NSDateFormatter * dateForma = [[NSDateFormatter alloc]init];
    [dateForma setDateFormat:@"yyyy-MM-dd"];
    NSString * strDate = [dateForma stringFromDate:date];
    NSString * strDtEnd = [NSString stringWithFormat:@"%@ 23:59:59",strDate];
    [dateForma setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * dateEnd = [dateForma dateFromString:strDtEnd];
    dtEnd = [dateEnd timeIntervalSince1970] * 1000;
    return dtEnd;
}

+(long long int)getEndDateTimeMsWithdtBeginMS:(long long int)dtBeginMS
{
    return dtBeginMS + 86400000 - 1000;
}


#pragma mark -- 得到时间的星期数
+(NSInteger)getWeekdayIntegerWithNSdate:(NSDate *)date
{
    NSInteger intWeekday = 0;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |NSWeekdayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit |NSSecondCalendarUnit;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    
    intWeekday = [comps weekday];

    return intWeekday;
}

+(NSDateComponents *)getDateComponentsWithDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |NSWeekdayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit |NSSecondCalendarUnit;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    return comps;
}


#pragma mark -- 由毫秒得到时间的星期显示
+(NSString *)getStrWeekdayWithNSdate:(NSDate *)date
{
    NSString * show = nil;
    NSInteger intWeekday = [[self class]getWeekdayIntegerWithNSdate:date];
    NSArray * arrStrWeekdays = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    show = arrStrWeekdays[intWeekday-1];
    return show;
}


#pragma mark -- 得到某个日期的毫秒级时间戳(只有小时、分钟、秒)
+(long long int)getTimeMsWithDtMS:(long long int)dtMS
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dtMS];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString * string =  [dateFormatter stringFromDate:date];
    NSDate * date2 = [dateFormatter dateFromString:string];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit|NSMonthCalendarUnit|  NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit) fromDate:date2];
    NSInteger seconds = [dateComponents second];
    NSInteger minutes = [dateComponents minute];
    NSInteger hours = [dateComponents hour];
    
    NSTimeInterval interval=[[NSTimeZone defaultTimeZone] secondsFromGMTForDate:[NSDate date]];
    long long ms = (seconds + 60 * minutes + hours * 60 * 60 - interval) * 1000;
    return ms;
}

#pragma mark -- 得到某个日期的毫秒级时间戳(只有小时、分钟、秒)
+(long long int)getTimeMsWithNSDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString * string =  [dateFormatter stringFromDate:date];
    NSDate * date2 = [dateFormatter dateFromString:string];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit|NSMonthCalendarUnit|  NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit) fromDate:date2];
    NSInteger seconds = [dateComponents second];
    NSInteger minutes = [dateComponents minute];
    NSInteger hours = [dateComponents hour];
    
    NSTimeInterval interval=[[NSTimeZone defaultTimeZone] secondsFromGMTForDate:[NSDate date]];
    long long ms = (seconds + 60 * minutes + hours * 60 * 60 - interval) * 1000;
    return ms;
}

#pragma mark -- 根据毫秒级时间戳来得到相应格式的时间字符串
+(NSString *)getStrDateTimeWithDateTimeMS:(long long int)dtMS DateTimeStyle:(NSString *)dateTimeStyle
{
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:(dtMS)/1000];
    NSDateFormatter  * dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:dateTimeStyle];
    NSString *  timeLocationString=[dateFormatter stringFromDate:date];
    return timeLocationString;
}


@end
