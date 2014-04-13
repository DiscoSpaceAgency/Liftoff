//
//  DSANavigationControllerDelegate.m
//  Liftoff
//
//  Created by Michael on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSANavigationControllerDelegate.h"
#import "DSATimelineMissionAnimator.h"
#import "DSAMissionViewController.h"
#import "DSATimelineEventsAnimator.h"
#import "DSALaunchViewController.h"
#import "DSATimelineSettingsAnimator.h"
#import "DSASettingsViewController.h"

@interface DSANavigationControllerDelegate ()

@property (weak, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) DSATimelineMissionAnimator *timelineMissionAnimator;
@property (strong, nonatomic) DSATimelineEventsAnimator *timelineEventsAnimator;
@property (strong, nonatomic) DSATimelineSettingsAnimator *timelineSettingsAnimator;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;

@end

@implementation DSANavigationControllerDelegate

- (void)awakeFromNib
{
//    UIPanGestureRecognizer* navPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panNavigation:)];
//    [self.navigationController.view addGestureRecognizer:navPanRecognizer];

    self.timelineMissionAnimator = [[DSATimelineMissionAnimator alloc] init];
    self.timelineEventsAnimator = [[DSATimelineEventsAnimator alloc] init];
    self.timelineSettingsAnimator = [[DSATimelineSettingsAnimator alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if ([fromVC isMemberOfClass:[DSAMissionViewController class]] || [toVC isMemberOfClass:[DSAMissionViewController class]]) {
        return self.timelineMissionAnimator;
    }
    if ([fromVC isMemberOfClass:[DSASettingsViewController class]] || [toVC isMemberOfClass:[DSASettingsViewController class]]) {
        return self.timelineSettingsAnimator;
    }
    if ([fromVC isMemberOfClass:[DSALaunchViewController class]] || [toVC isMemberOfClass:[DSALaunchViewController class]]) {
        return self.timelineEventsAnimator;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}

- (void)panNavigation:(UIPanGestureRecognizer *)recognizer
{
    UIView* view = self.navigationController.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:view];
        if (location.y <  CGRectGetMidY(view.bounds) && self.navigationController.viewControllers.count > 1) { // top half
            self.interactionController = [UIPercentDrivenInteractiveTransition new];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.y / CGRectGetHeight(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].y > 0) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

@end
