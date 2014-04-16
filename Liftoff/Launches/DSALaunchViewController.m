//
//  DSALaunchViewController.m
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSALaunchViewController.h"
#import "DSADateConverter.h"
#import "DSANextLaunchCell.h"
#import "DSALaunchCell.h"
#import "DSADataStore.h"
#import "DSALaunch.h"
#import "DSASettingsViewController.h"

@interface DSALaunchViewController ()

@end

@implementation DSALaunchViewController

@synthesize settingsButton;
@synthesize timelineButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    timelineButton.titleLabel.font = [UIFont fontWithName:@"Novecentosanswide-DemiBold" size:14.0];
    settingsButton.titleLabel.font = [UIFont fontWithName:@"Novecentosanswide-DemiBold" size:14.0];
    titleLabel.font = [UIFont fontWithName:@"Novecentosanswide-DemiBold" size:22.0];
    
    divider.frame = CGRectMake(divider.frame.origin.x, divider.frame.origin.y, divider.frame.size.width, .5);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 250;
    } else {
        return 80;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DSADataStore sharedInstance].launches.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        DSANextLaunchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nextEventCell"];
        
        DSALaunch *launch = [[DSADataStore sharedInstance].launches objectAtIndex:indexPath.row];
        
        cell.launchName.text = launch.payload;
        cell.date = launch.date;
        cell.timeLabel.text = [[DSADateConverter sharedInstance] timeUntilDate:launch.date];
        
        return cell;
    } else {
        DSALaunchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"launchCell"];
        
        DSALaunch *launch = [[DSADataStore sharedInstance].launches objectAtIndex:indexPath.row];
        
        cell.launchName.text = launch.payload;
        
        cell.dateLabel.text = [[DSADateConverter sharedInstance] dateStringFromDate:launch.date];
        cell.timeDetails.text = [[DSADateConverter sharedInstance] timeStringFromDate:launch.date];
        
        return cell;
    }
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LaunchScroll" object:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showSettings"]) {
        DSASettingsViewController *settingsViewController = [segue destinationViewController];
        settingsViewController.segueIdentifier = @"showEvents";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
