//
//  DSATimelineMissionAnimator.m
//  Liftoff
//
//  Created by Michael on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSATimelineMissionAnimator.h"
#import "EGOImageView.h"
#import "DSATimelineViewController.h"
#import "DSAMissionViewController.h"

@implementation DSATimelineMissionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if ([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isMemberOfClass:[DSAMissionViewController class]]) {
        [self animateTimelineToMission:transitionContext];
    }
    else {
        [self animateMissionToTimeline:transitionContext];
    }
}

- (void)animateTimelineToMission:(id<UIViewControllerContextTransitioning>)transitionContext
{
    DSAMissionViewController *missionViewController = (DSAMissionViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    DSATimelineViewController* timelineViewController = (DSATimelineViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:missionViewController.view];
    missionViewController.view.alpha = 0;
    missionViewController.view.transform = CGAffineTransformMakeScale(1.1, 1.1);
    missionViewController.missionImage.alpha = 0;
    UIColor *toBackgroundColor = missionViewController.view.backgroundColor;
    missionViewController.view.backgroundColor = [UIColor clearColor];

    CGPoint toOrigin = [missionViewController.view.superview convertPoint:missionViewController.missionImage.frame.origin toView:transitionContext.containerView];
    CGRect toFrame = CGRectMake(toOrigin.x, toOrigin.y, missionViewController.missionImage.frame.size.width, missionViewController.missionImage.frame.size.height);
    
    UIView *transitionView = [[UIView alloc] initWithFrame:timelineViewController.selectedTimelineStripRect];
    transitionView.clipsToBounds = YES;
    UIView *timelineStrip = [[UIView alloc] initWithFrame:CGRectMake(0, 0, transitionView.frame.size.width, transitionView.frame.size.height)];
    [timelineStrip setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    CGFloat y = transitionView.frame.origin.y/transitionContext.containerView.frame.size.height;
    [timelineStrip setBackgroundColor:[UIColor colorWithWhite:(1.0-y/3) alpha:1.0]];
    [transitionView addSubview:timelineStrip];
    EGOImageView *missionImage = [[EGOImageView alloc] initWithFrame:CGRectMake(toOrigin.x - transitionView.frame.origin.x, toOrigin.y - transitionView.frame.origin.y, toFrame.size.width, toFrame.size.height)];
    [missionImage setImageURL:missionViewController.mission.imageURL];
    [missionImage setBackgroundColor:[UIColor lightGrayColor]];
    [missionImage setContentMode:UIViewContentModeScaleAspectFill];
    [transitionView addSubview:missionImage];
    [transitionView bringSubviewToFront:timelineStrip];
    [[transitionContext containerView] addSubview:transitionView];
    [[transitionContext containerView] bringSubviewToFront:transitionView];
    [[transitionContext containerView] bringSubviewToFront:missionViewController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        timelineViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
        timelineViewController.view.alpha = 0;
        missionViewController.view.transform = CGAffineTransformIdentity;
        missionViewController.view.alpha = 1;
        timelineStrip.alpha = 0;
        [transitionView setFrame:toFrame];
        [missionImage setFrame:CGRectMake(0, 0, toFrame.size.width, toFrame.size.height)];
    } completion:^(BOOL finished) {
        timelineViewController.view.transform = CGAffineTransformIdentity;
        missionViewController.missionImage.alpha = 1;
        missionViewController.view.backgroundColor = toBackgroundColor;
        [transitionView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

    }];
}

- (void)animateMissionToTimeline:(id<UIViewControllerContextTransitioning>)transitionContext
{
    DSAMissionViewController *missionViewController = (DSAMissionViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DSATimelineViewController* timelineViewController = (DSATimelineViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:timelineViewController.view];
    timelineViewController.view.alpha = 0;
    timelineViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
    missionViewController.missionImage.alpha = 1;
    UIColor *toBackgroundColor = missionViewController.view.backgroundColor;
    missionViewController.view.backgroundColor = [UIColor clearColor];

    CGPoint fromOrigin = [missionViewController.view.superview convertPoint:missionViewController.missionImage.frame.origin toView:transitionContext.containerView];
    CGRect fromFrame = CGRectMake(fromOrigin.x, fromOrigin.y, missionViewController.missionImage.frame.size.width, missionViewController.missionImage.frame.size.height);
    UIView *transitionView = [[UIView alloc] initWithFrame:fromFrame];
    transitionView.clipsToBounds = YES;
    UIView *timelineStrip = [[UIView alloc] initWithFrame:CGRectMake(0, 0, transitionView.frame.size.width, transitionView.frame.size.height)];
    [timelineStrip setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    CGFloat y = timelineViewController.selectedTimelineStripRect.origin.y/transitionContext.containerView.frame.size.height;
    [timelineStrip setBackgroundColor:[UIColor colorWithWhite:(1.0-y/3) alpha:1.0]];
    timelineStrip.alpha = 0;
    [transitionView addSubview:timelineStrip];
    EGOImageView *missionImage = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, fromFrame.size.width, fromFrame.size.height)];
    [missionImage setImageURL:missionViewController.mission.imageURL];
    [missionImage setBackgroundColor:[UIColor lightGrayColor]];
    [missionImage setContentMode:UIViewContentModeScaleAspectFill];
    [transitionView addSubview:missionImage];
    [transitionView bringSubviewToFront:timelineStrip];
    [[transitionContext containerView] addSubview:transitionView];
    [[transitionContext containerView] bringSubviewToFront:transitionView];
    [[transitionContext containerView] bringSubviewToFront:missionViewController.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        missionViewController.view.transform = CGAffineTransformMakeScale(1.1,1.1);
        missionViewController.view.alpha = 0;
        timelineViewController.view.transform = CGAffineTransformIdentity;
        timelineViewController.view.alpha = 1;
        timelineStrip.alpha = 1;
        [transitionView setFrame:timelineViewController.selectedTimelineStripRect];
        [missionImage setFrame:CGRectMake(fromOrigin.x - transitionView.frame.origin.x, fromOrigin.y - transitionView.frame.origin.y, fromFrame.size.width, fromFrame.size.height)];
    } completion:^(BOOL finished) {
        missionViewController.view.transform = CGAffineTransformIdentity;
        missionViewController.missionImage.alpha = 1;
        missionViewController.view.backgroundColor = toBackgroundColor;
        [transitionView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

    }];
}

@end
