//
//  DSAMissionViewController.m
//  Liftoff
//
//  Created by Harry Slotwiner on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSAMissionViewController.h"

@interface DSAMissionViewController ()

@end

@implementation DSAMissionViewController

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
    
    downButton.layer.cornerRadius = downButton.frame.size.width;
    
    nameLabel.text = self.mission.name;
    agencyLabel.text = [self.mission.agencies objectAtIndex:0];
    //statusLabel.text = ?
    
    
}

- (IBAction)done:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
