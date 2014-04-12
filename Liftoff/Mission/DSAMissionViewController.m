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
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    
    if (!self.mission) {
        DSAMission *mission = [[DSAMission alloc] init];
        mission.name = @"ISS";
        mission.imageURL = [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/6/60/ISSFinalConfigEnd2006.jpg"];
        
        self.mission = mission;
    }
    
    downButton.layer.cornerRadius = downButton.frame.size.width/2;
    downShadow.layer.cornerRadius = downButton.frame.size.width/2;
    
    nameLabel.text = self.mission.name;
    agencyLabel.text = @"NASA, ESA, JAXA, CSA, RSA"; //?
    statusLabel.text = @"In low earth orbit"; //?
    
    missionImage.imageURL = self.mission.imageURL;
    
    NSInteger astronauts = 2;
    astronautTable.frame = CGRectMake(astronautTable.frame.origin.x, astronautTable.frame.origin.y, astronautTable.frame.size.width, (astronauts *100));
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLayoutSubviews {
    content.contentSize = CGSizeMake(self.view.frame.size.width, 2000);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == astronautTable) {
        return 2;
    } else if (tableView == eventTable) {
        return 3;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == astronautTable) {
        DSAAstronautCell *cell = [tableView dequeueReusableCellWithIdentifier:@"astronautCell"];
        
        if (indexPath.row == 0) {
            cell.astronautName.text = @"Douglas Wheelock";
            cell.profile.imageURL = [NSURL URLWithString:@"http://www.jsc.nasa.gov/Bios/portraits/wheelock-thumbnail.jpg"];
            cell.role.text = @"Person...";
        } else if (indexPath.row == 1) {
            cell.astronautName.text = @"Don Pettit";
            cell.profile.imageURL = [NSURL URLWithString:@"http://www.jsc.nasa.gov/Bios/portraits/pettit-thumbnail.jpg"];
            cell.role.text = @"Person...";
        }
        
        return cell;
    } else if (tableView == eventTable) {
        DSAAstronautCell *cell = [tableView dequeueReusableCellWithIdentifier:@"astronautCell"];
        
        if (indexPath.row == 0) {
            cell.astronautName.text = @"Douglas Wheelock";
            cell.profile.imageURL = [NSURL URLWithString:@"http://www.jsc.nasa.gov/Bios/portraits/wheelock-thumbnail.jpg"];
            cell.role.text = @"Person...";
        } else if (indexPath.row == 1) {
            cell.astronautName.text = @"Don Pettit";
            cell.profile.imageURL = [NSURL URLWithString:@"http://www.jsc.nasa.gov/Bios/portraits/pettit-thumbnail.jpg"];
            cell.role.text = @"Person...";
        }
        
        return cell;
    }
    
    return nil;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (IBAction)done:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
