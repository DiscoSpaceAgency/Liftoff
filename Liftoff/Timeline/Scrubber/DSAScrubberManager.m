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

- (void)panRecognized:(UIPanGestureRecognizer *)gestureRecognizer
{
    NSInteger dateX = (NSInteger)[gestureRecognizer locationInView:gestureRecognizer.view].x;
    dateX = MAX(MIN(dateX, _scrubberView.maxX), _scrubberView.minX);
    [_scrubberView.dateMarker setCenter:CGPointMake(dateX, _scrubberView.dateMarker.center.y)];
//    _scrubberView.dateLabel.text = [_scrubberView textForDate:<#(NSDate *)#>]
    [_scrubberView.dateLabel sizeToFit];
    dateX = MAX(MIN(dateX, _scrubberView.maxX-_scrubberView.dateLabel.frame.size.width/2), _scrubberView.minX+_scrubberView.dateLabel.frame.size.width/2);
    [_scrubberView.dateLabel setCenter:CGPointMake(dateX, _scrubberView.dateLabel.center.y)];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"TimelinePan" object:self userInfo:@{@"translate": @(_offset + (NSInteger)[gestureRecognizer translationInView:gestureRecognizer.view].x)}];
}

@end
