//
//  DSATimelineViewController.m
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSATimelineViewController.h"
#import "DSATimelineDataSource.h"
#import "DSATimelineOffsetManager.h"
#import "DSAMissionViewController.h"
#import "DSATimelineMissionAnimator.h"
#import "DSATimelineViewCell.h"

@interface DSATimelineViewController ()

@property (strong, nonatomic) IBOutlet UIButton *liftoffButton;
@property (strong, nonatomic) IBOutlet UIButton *eventsButton;
@property (strong, nonatomic) IBOutlet UIButton *settingsButton;
@property (strong, nonatomic) IBOutlet UIView *scrubberView;
@property (strong, nonatomic) IBOutlet UITableView *timelineTable;
@property (strong, nonatomic) DSATimelineDataSource *dataSource;
@property (strong, nonatomic) UIPanGestureRecognizer *panRecognizer;

@end

@implementation DSATimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_liftoffButton.titleLabel setFont:[UIFont fontWithName:@"Novecentosanswide-DemiBold" size:24.0]];
    [_eventsButton.titleLabel setFont:[UIFont fontWithName:@"Novecentosanswide-DemiBold" size:14.0]];

    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:[DSATimelineOffsetManager sharedInstance] action:@selector(panRecognized:)];
    [_panRecognizer setDelegate:[DSATimelineOffsetManager sharedInstance]];
    [_timelineTable addGestureRecognizer:_panRecognizer];

    _dataSource = [[DSATimelineDataSource alloc] init];
    [_timelineTable setDataSource:_dataSource];
    [_timelineTable setDelegate:[DSATimelineOffsetManager sharedInstance]];
    [[DSATimelineOffsetManager sharedInstance] setTimelineTable:_timelineTable];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(segueForTimelineNotification:) name:@"TimelineSelect" object:nil];

    _selectedTimelineStripRect = CGRectZero;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)today {
    [[DSATimelineOffsetManager sharedInstance] todayRecognized];
}

- (void)segueForTimelineNotification:(NSNotification *)notification
{
    DSATimelineViewCell *cell = (DSATimelineViewCell *)[_dataSource tableView:_timelineTable cellForRowAtIndexPath:notification.userInfo[@"indexPath"]];
    [self performSegueWithIdentifier:@"showMission" sender:[_dataSource missionforIndexPath:notification.userInfo[@"indexPath"]]];
    _selectedTimelineStripRect = [_timelineTable convertRect:[_timelineTable rectForRowAtIndexPath:notification.userInfo[@"indexPath"]] toView:[_timelineTable superview]];
    CGRect cellRect = CGRectOffset(cell.stripRect, 0, _selectedTimelineStripRect.origin.y);
    _selectedTimelineStripRect = CGRectIntersection(_selectedTimelineStripRect, cellRect);
//    _selectedTimelineStripRect = cell.stripRect;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMission"]) {
        DSAMissionViewController *missionViewController = [segue destinationViewController];
        [missionViewController setMission:sender];
    }
}

@end
