//
//  DSASettingsViewController.m
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSASettingsViewController.h"
#import "DSANotificationController.h"

@interface DSASettingsViewController ()

@end

@implementation DSASettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    titleLabel.font = [UIFont fontWithName:@"Novecentosanswide-DemiBold" size:24.0];
    description.font = [UIFont fontWithName:@"Novecentosanswide-DemiBold" size:15.0];
    launchesLabel.font = [UIFont fontWithName:@"Novecentosanswide-Light" size:16.0];
    doneButton.titleLabel.font = [UIFont fontWithName:@"Novecentosanswide-DemiBold" size:14.0];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"launchesNotifications"]) {
        [launchesAlert setImage:[UIImage imageNamed:@"icon_alert_active.png"] forState:UIControlStateNormal];
        launchesAlert.alpha = 1;
    } else {
        [launchesAlert setImage:[UIImage imageNamed:@"icon_alert_inactive.png"] forState:UIControlStateNormal];
        launchesAlert.alpha = .5;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showEvent) name:@"showEvents" object:nil];
}
- (void)showEvent {
    [self done:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)pressedLaunches:(id)sender {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"launchesNotifications"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"launchesNotifications"];
        [launchesAlert setImage:[UIImage imageNamed:@"icon_alert_inactive.png"] forState:UIControlStateNormal];
        launchesAlert.alpha = .5;
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"launchesNotifications"];
        [launchesAlert setImage:[UIImage imageNamed:@"icon_alert_active.png"] forState:UIControlStateNormal];
        launchesAlert.alpha = 1;
        [[DSANotificationController sharedInstance] fakeNotificationIn:10];
    }
}

- (IBAction)done:(id)sender {
    [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
