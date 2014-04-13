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
    return 10 * exp(- pow(((year + (month - 1)/12.0) - todayYear), 2) / (2*pow(9,2)));
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
    NSAssert(dateYear >= minYear, @"Given date (%i) is not in range of data (>= %i)",dateYear, minYear);

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
    return [self position:[[DSADataStore sharedInstance].missions valueForKeyPath:@"@max.startDate"]];
}

+ (NSInteger)widthForStart:(NSDate *)startDate end:(NSDate *)endDate
{
    return [self position:endDate] - [self position:startDate];
}

+ (NSArray *)tickPositionsForYearsBetweenStart:(NSDate *)startDate end:(NSDate *)endDate
{
    NSMutableArray *tickPositions = [NSMutableArray array];
    NSDateComponents *startDateComponents = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:startDate];
    NSInteger startYear = startDateComponents.year;
    NSInteger startMonth = startDateComponents.month;
    NSDateComponents *endDateComponents = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:endDate];
    NSInteger endYear = endDateComponents.year;
    NSInteger endMonth = endDateComponents.month;
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    for (NSInteger year = startYear + 1; year <= endYear; year++) {
        [dateComponents setYear:year];
        if (year == endYear && 1 >= endMonth) {
            break;
        }
        [tickPositions addObject:@([self position:[self.calendar dateFromComponents:dateComponents]])];
    }
    return tickPositions;
}

+ (NSDate *)startDateForPosition:(NSInteger)position
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = [DSADataStore sharedInstance].minYear - 1;
    dateComponents.month = 11;
    NSDate *date = [self.calendar dateFromComponents:dateComponents];
    const NSInteger maxYear = [DSADataStore sharedInstance].maxYear;
    for (NSInteger year = [DSADataStore sharedInstance].minYear; year <= maxYear; year++) {
        [dateComponents setYear:year];
        for (NSInteger month = 1; month <= 12; month++) {
            [dateComponents setMonth:month];
            NSInteger datePosition = [self position:[self.calendar dateFromComponents:dateComponents]];
            if (datePosition > position) {
                return date;
            }
            date = [self.calendar dateFromComponents:dateComponents];
        }
    }
    return date;
}

+ (NSDate *)endDateForPosition:(NSInteger)position
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = [DSADataStore sharedInstance].minYear - 1;
    dateComponents.month = 11;
    NSDate *date = [self.calendar dateFromComponents:dateComponents];
    const NSInteger maxYear = [DSADataStore sharedInstance].maxYear;
    for (NSInteger year = [DSADataStore sharedInstance].minYear; year <= maxYear; year++) {
        [dateComponents setYear:year];
        for (NSInteger month = 1; month <= 12; month++) {
            [dateComponents setMonth:month];
            date = [self.calendar dateFromComponents:dateComponents];
            NSInteger datePosition = [self position:date];
            if (datePosition > position) {
                return date;
            }
        }
    }
    return date;
}

@end
