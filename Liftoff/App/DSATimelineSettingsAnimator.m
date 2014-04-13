//
//  DSATimelineSettingsAnimator.m
//  Liftoff
//
//  Created by Michael on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSATimelineSettingsAnimator.h"
#import "DSATimelineViewController.h"
#import "DSASettingsViewController.h"

@implementation DSATimelineSettingsAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if ([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isMemberOfClass:[DSASettingsViewController class]]) {
        [self animateTimelineToSettings:transitionContext];
    }
    else {
        [self animateSettingsToTimeline:transitionContext];
    }
}

- (void)animateTimelineToSettings:(id<UIViewControllerContextTransitioning>)transitionContext
{
    DSASettingsViewController *settingsViewController = (DSASettingsViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* mainViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:settingsViewController.view];
    settingsViewController.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
    settingsViewController.view.alpha = 0.8;
    [settingsViewController.view setCenter:CGPointMake(settingsViewController.view.center.x, settingsViewController.view.center.y + [[UIApplication sharedApplication] keyWindow].frame.size.height)];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        mainViewController.view.transform = CGAffineTransformMakeScale(0.95, 0.95);
        mainViewController.view.alpha = 0.5;
        settingsViewController.view.transform = CGAffineTransformIdentity;
        settingsViewController.view.alpha = 1;
        settingsViewController.view.center = mainViewController.view.center;
    } completion:^(BOOL finished) {
        mainViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)animateSettingsToTimeline:(id<UIViewControllerContextTransitioning>)transitionContext
{
    DSASettingsViewController *settingsEventController = (DSASettingsViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* mainViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:mainViewController.view];
    [[transitionContext containerView] bringSubviewToFront:settingsEventController.view];
    mainViewController.view.transform = CGAffineTransformMakeScale(0.95, 0.95);
    mainViewController.view.alpha = 0.5;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        settingsEventController.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
        settingsEventController.view.alpha = 0.8;
        mainViewController.view.transform = CGAffineTransformIdentity;
        mainViewController.view.alpha = 1;
        [settingsEventController.view setCenter:CGPointMake(settingsEventController.view.center.x, settingsEventController.view.center.y + [[UIApplication sharedApplication] keyWindow].frame.size.height)];
    } completion:^(BOOL finished) {
        settingsEventController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
