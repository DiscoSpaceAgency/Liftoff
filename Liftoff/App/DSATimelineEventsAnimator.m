//
//  DSATimelineEventsAnimator.m
//  Liftoff
//
//  Created by Michael on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSATimelineEventsAnimator.h"
#import "DSATimelineViewController.h"
#import "DSALaunchViewController.h"

@implementation DSATimelineEventsAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if ([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isMemberOfClass:[DSALaunchViewController class]]) {
        [self animateTimelineToEvents:transitionContext];
    }
    else {
        [self animateEventsToTimeline:transitionContext];
    }
}

- (void)animateTimelineToEvents:(id<UIViewControllerContextTransitioning>)transitionContext
{
    DSALaunchViewController *eventsViewController = (DSALaunchViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    DSATimelineViewController* timelineViewController = (DSATimelineViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:eventsViewController.view];
    eventsViewController.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
    eventsViewController.view.alpha = 0.8;
    [eventsViewController.view setCenter:CGPointMake(eventsViewController.view.center.x, eventsViewController.view.center.y + [[UIApplication sharedApplication] keyWindow].frame.size.height)];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        timelineViewController.view.transform = CGAffineTransformMakeScale(0.95, 0.95);
        timelineViewController.view.alpha = 0.5;
        eventsViewController.view.transform = CGAffineTransformIdentity;
        eventsViewController.view.alpha = 1;
        eventsViewController.view.center = timelineViewController.view.center;
    } completion:^(BOOL finished) {
        timelineViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)animateEventsToTimeline:(id<UIViewControllerContextTransitioning>)transitionContext
{
    DSALaunchViewController *eventsViewController = (DSALaunchViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DSATimelineViewController* timelineViewController = (DSATimelineViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:timelineViewController.view];
    [[transitionContext containerView] bringSubviewToFront:eventsViewController.view];
    timelineViewController.view.transform = CGAffineTransformMakeScale(0.95, 0.95);
    timelineViewController.view.alpha = 0.5;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        eventsViewController.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
        eventsViewController.view.alpha = 0.8;
        timelineViewController.view.transform = CGAffineTransformIdentity;
        timelineViewController.view.alpha = 1;
        [eventsViewController.view setCenter:CGPointMake(eventsViewController.view.center.x, eventsViewController.view.center.y + [[UIApplication sharedApplication] keyWindow].frame.size.height)];
    } completion:^(BOOL finished) {
        eventsViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
