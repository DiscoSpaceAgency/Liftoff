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
    });
    return sharedInstance;
}

- (void)panRecognized:(UIGestureRecognizer *)gestureRecognizer
{
    NSInteger dateX = (NSInteger)[gestureRecognizer locationInView:gestureRecognizer.view].x;
    dateX = MAX(MIN(dateX, _scrubberView.maxX), _scrubberView.minX);
    CGFloat dateFloat = ((CGFloat)dateX - (CGFloat)_scrubberView.minX)/((CGFloat)_scrubberView.maxX - (CGFloat)_scrubberView.minX)*((CGFloat)[DSADataStore sharedInstance].maxYear - (CGFloat)[DSADataStore sharedInstance].minYear);
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = (NSInteger)floorf(dateFloat) + [DSADataStore sharedInstance].minYear;
    dateComponents.month = (NSInteger)ceilf((dateFloat - dateComponents.year + [DSADataStore sharedInstance].minYear)*12.0);
    NSDate *date = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] dateFromComponents:dateComponents];

    [_scrubberView.dateMarker setCenter:CGPointMake(dateX, _scrubberView.dateMarker.center.y)];
    _scrubberView.dateLabel.text = [_scrubberView textForDate:date];
    [_scrubberView.dateLabel sizeToFit];
    dateX = MAX(MIN(dateX, _scrubberView.maxX-_scrubberView.dateLabel.frame.size.width/2), _scrubberView.minX+_scrubberView.dateLabel.frame.size.width/2);
    [_scrubberView.dateLabel setCenter:CGPointMake(dateX, _scrubberView.dateLabel.center.y)];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScrubberPan" object:self userInfo:@{@"translate": @(-[DSATimelineWidthCalculator position:date])}];
}

@end
