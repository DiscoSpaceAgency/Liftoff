//
//  DSATimelineOffsetManager.m
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSATimelineOffsetManager.h"
#import "DSATimelineWidthCalculator.h"

@interface DSATimelineOffsetManager ()

@property (readwrite, nonatomic) BOOL isTableScrolling;
@property (readwrite, nonatomic) NSInteger offset;
@property (readwrite, nonatomic) NSInteger maxOffset;

@end

@implementation DSATimelineOffsetManager

+ (instancetype)sharedInstance
{
    static DSATimelineOffsetManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DSATimelineOffsetManager alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _isTableScrolling = NO;
        _offset = -[DSATimelineWidthCalculator position:NSDate.date];
        _maxOffset = -[DSATimelineWidthCalculator maxPosition];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrub:) name:@"ScrubberPan" object:nil];
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (_isTableScrolling) {
        return NO;
    }
    CGPoint translation = [panGestureRecognizer translationInView:panGestureRecognizer.view];
    BOOL isHorizontalPan = fabs(translation.x) > fabs(translation.y);
    _timelineTable.scrollEnabled = !isHorizontalPan;
    return isHorizontalPan;
}

- (void)panRecognized:(UIPanGestureRecognizer *)gestureRecognizer
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TimelinePan" object:self userInfo:@{@"translate": @(_offset + (NSInteger)[gestureRecognizer translationInView:gestureRecognizer.view].x)}];

    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        _offset += [gestureRecognizer translationInView:gestureRecognizer.view].x;
        if (_offset > 0) {
            _offset = 0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TimelineResetOffset" object:self];
        }
        else if (_offset < _maxOffset + gestureRecognizer.view.frame.size.width - 20) {
            _offset = _maxOffset + gestureRecognizer.view.frame.size.width - 20;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TimelineResetOffset" object:self];
        }
        _timelineTable.scrollEnabled = YES;
        _isTableScrolling = NO;
    }
}

- (void)todayRecognized
{
    _offset = -[DSATimelineWidthCalculator position:NSDate.date];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TimelinePan" object:self userInfo:@{@"translate": @(_offset)}];
}

- (void)scrub:(NSNotification *)notification
{
    _offset = [notification.userInfo[@"translate"] integerValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TimelinePan" object:self userInfo:notification.userInfo];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isTableScrolling = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TimelineScroll" object:self userInfo:nil];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _isTableScrolling = decelerate;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _isTableScrolling = NO;
}

@end
