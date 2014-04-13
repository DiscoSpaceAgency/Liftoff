//
//  DSATimelineSettingsAnimator.m
//  Liftoff
//
//  Created by Michael on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSATimelineSettingsAnimator.h"
#import "DSATimelineViewController.h"

@implementation DSATimelineSettingsAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if ([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isMemberOfClass:[DSATimelineViewController class]]) {
//        [self animateTimelineToMission:transitionContext];
    }
    else {
//        [self animateMissionToTimeline:transitionContext];
    }
}

@end
