//
//  DSATimelineWidthCalculator.m
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSATimelineWidthCalculator.h"

@implementation DSATimelineWidthCalculator

+ (NSMutableDictionary *)memos
{
    static NSMutableDictionary *memos = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        memos = [NSMutableDictionary dictionaryWithCapacity:1212];
    });
    return memos;
}

+ (NSCalendar *)calendar
{
    static NSCalendar *calendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    });
    return calendar;
}

float monthWidth(int month, int year)
{
    return 160 * exp(- pow(((year + (month - 1) / 12.0) - 2014),2) / (2*pow(1,2)));
}

+ (NSInteger)position:(NSDate *)date
{
    NSDateComponents *dateComponents = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:date];
    NSInteger dateYear = dateComponents.year;
    NSInteger dateMonth = dateComponents.month;

    NSDateComponents *memoDateComponents = [[NSDateComponents alloc] init];
    memoDateComponents.year = dateYear;
    memoDateComponents.month = dateMonth;
    NSDate *originalDate = [self.calendar dateFromComponents:memoDateComponents];

    if ([self memos][originalDate]) {
        return [[self memos][originalDate] integerValue];
    }

    NSInteger position = 0;
    for (NSInteger year = 1996; year <= dateYear; year++) {
        [memoDateComponents setYear:year];
        for (NSInteger month = 1; month <= 12; month++) {
            if (year == dateYear && month > dateMonth) {
                break;
            }
            [memoDateComponents setMonth:month];
            position += monthWidth(month, year);
            [self memos][[self.calendar dateFromComponents:memoDateComponents]] = @(position);
        }
    }
    return position;
}

+ (NSInteger)maxPosition
{
    NSDateComponents *maxDateComponents = [[NSDateComponents alloc] init];
    maxDateComponents.year = 2024;
    maxDateComponents.month = 4;
    NSDate *maxDate = [self.calendar dateFromComponents:maxDateComponents];
    return [self position:maxDate];
}

+ (NSInteger)widthForStart:(NSDate *)startDate end:(NSDate *)endDate
{
    return [self position:endDate] - [self position:startDate];
}

@end
