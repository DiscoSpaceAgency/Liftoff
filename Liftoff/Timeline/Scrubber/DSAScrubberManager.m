//
//  DSAScrubberManager.m
//  Liftoff
//
//  Created by Michael on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSAScrubberManager.h"
#import "DSATimelineOffsetManager.h"
#import "DSAScrubberView.h"
#import "DSADataStore.h"
#import "DSATimelineWidthCalculator.h"

@implementation DSAScrubberManager

+ (instancetype)sharedInstance
{
    static DSAScrubberManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DSAScrubberManager alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(pan:) name:@"TimelinePan" object:nil];
    });
    return sharedInstance;
}

- (NSCalendar *)calendar
{
    static NSCalendar *calendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    });
    return calendar;
}

- (void)panRecognized:(UIGestureRecognizer *)gestureRecognizer
{
    NSInteger dateX = (NSInteger)[gestureRecognizer locationInView:gestureRecognizer.view].x;
    dateX = MAX(MIN(dateX, _scrubberView.maxX), _scrubberView.minX);
    CGFloat dateFloat = ((CGFloat)dateX - (CGFloat)_scrubberView.minX)/((CGFloat)_scrubberView.maxX - (CGFloat)_scrubberView.minX)*((CGFloat)[DSADataStore sharedInstance].maxYear - (CGFloat)[DSADataStore sharedInstance].minYear);
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = (NSInteger)floorf(dateFloat) + [DSADataStore sharedInstance].minYear;
    dateComponents.month = (NSInteger)ceilf((dateFloat - dateComponents.year + [DSADataStore sharedInstance].minYear)*12.0);
    NSDate *date = [self.calendar dateFromComponents:dateComponents];

    [_scrubberView.dateMarker setCenter:CGPointMake(dateX, _scrubberView.dateMarker.center.y)];
    _scrubberView.dateLabel.text = [_scrubberView textForDate:date];
    [_scrubberView.dateLabel sizeToFit];
    dateX = MAX(MIN(dateX, _scrubberView.maxX-_scrubberView.dateLabel.frame.size.width/2), _scrubberView.minX+_scrubberView.dateLabel.frame.size.width/2);
    [_scrubberView.dateLabel setCenter:CGPointMake(dateX, _scrubberView.dateLabel.center.y)];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScrubberPan" object:self userInfo:@{@"translate": @(-[DSATimelineWidthCalculator position:date])}];
}

- (void)pan:(NSNotification *)notification
{
    NSDate *date = [DSATimelineWidthCalculator startDateForPosition:(-[notification.userInfo[@"translate"] integerValue])];
    NSDateComponents *dateComponents = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:date];
    NSInteger dateYear = dateComponents.year;
    NSInteger dateMonth = dateComponents.month;
    NSInteger dateX = ((CGFloat)(dateYear - [DSADataStore sharedInstance].minYear) + dateMonth/12.0)/((CGFloat)[DSADataStore sharedInstance].maxYear - (CGFloat)[DSADataStore sharedInstance].minYear)*((CGFloat)_scrubberView.maxX - (CGFloat)_scrubberView.minX) + _scrubberView.minX;

    [_scrubberView.dateMarker setCenter:CGPointMake(dateX, _scrubberView.dateMarker.center.y)];
    _scrubberView.dateLabel.text = [_scrubberView textForDate:date];
    [_scrubberView.dateLabel sizeToFit];
    dateX = MAX(MIN(dateX, _scrubberView.maxX-_scrubberView.dateLabel.frame.size.width/2), _scrubberView.minX+_scrubberView.dateLabel.frame.size.width/2);
    [_scrubberView.dateLabel setCenter:CGPointMake(dateX, _scrubberView.dateLabel.center.y)];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
