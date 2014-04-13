//
//  DSATimelineWidthCalculator.m
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSATimelineWidthCalculator.h"
#import "DSADataStore.h"

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
    const NSInteger todayYear = [DSADataStore sharedInstance].todayYear;
    return 160 * exp(- pow(((year + (month - 1)/12.0) - todayYear), 2) / (2*pow(1,2)));
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

    const NSInteger minYear = [DSADataStore sharedInstance].minYear;
    NSAssert(dateYear >= minYear, @"Given date is not in range of data");

    NSInteger position = 0;
    for (NSInteger year = minYear; year <= dateYear; year++) {
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
    return [self position:[[DSADataStore sharedInstance].missions valueForKeyPath:@"@max.endDate"]];
}

+ (NSInteger)widthForStart:(NSDate *)startDate end:(NSDate *)endDate
{
    return [self position:endDate] - [self position:startDate];
}

@end
