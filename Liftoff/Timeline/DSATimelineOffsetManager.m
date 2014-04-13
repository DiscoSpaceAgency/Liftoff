//
//  DSATimelineOffsetManager.m
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSATimelineOffsetManager.h"

@interface DSATimelineOffsetManager ()

@property (readwrite, nonatomic) BOOL isTableScrolling;
@property (readwrite, nonatomic) NSInteger offset;

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
        _offset = 0;
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
        _timelineTable.scrollEnabled = YES;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isTableScrolling = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _isTableScrolling = NO;
}

@end
