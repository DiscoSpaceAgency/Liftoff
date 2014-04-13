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
        mission.quickDescription = @"CHAMP generated, for the first time, simultaneously highly precise gravity and magnetic field measurements over a 10 year period.";
        
        self.mission = mission;
    }
    
    downButton.layer.cornerRadius = downButton.frame.size.width/2;
    downShadow.layer.cornerRadius = downButton.frame.size.width/2;
    
    nameLabel.text = self.mission.name;
    agencyLabel.text = @"NASA, ESA, JAXA, CSA, RSA"; //?
    statusLabel.text = @"In low earth orbit"; //?
    
    missionDescription.text = self.mission.quickDescription;
    
    missionImage.imageURL = self.mission.imageURL;
    
    content.contentSize = CGSizeMake(self.view.frame.size.width, 2000);
    
    {
        NSInteger maxHeight = 200;
        CGSize maximumLabelSize = CGSizeMake(agencyLabel.frame.size.width, maxHeight);
        CGRect frame = [agencyLabel.text boundingRectWithSize:maximumLabelSize options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObjectsAndKeys: agencyLabel.font, NSFontAttributeName, nil] context:nil];
        
        agencyLabel.frame = CGRectMake(agencyLabel.frame.origin.x, agencyLabel.frame.origin.y, agencyLabel.frame.size.width, frame.size.height);
        
        NSInteger offset = agencyLabel.frame.size.height-31;
        statusLabel.center = CGPointMake(statusLabel.center.x, statusLabel.center.y+offset);
    }
    {
        NSInteger maxHeight = 400;
        CGSize maximumLabelSize = CGSizeMake(missionDescription.frame.size.width, maxHeight);
        CGRect frame = [missionDescription.text boundingRectWithSize:maximumLabelSize options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObjectsAndKeys: missionDescription.font, NSFontAttributeName, nil] context:nil];
        
        missionDescription.frame = CGRectMake(missionDescription.frame.origin.x, missionDescription.frame.origin.y, missionDescription.frame.size.width, frame.size.height);
        
        NSInteger offset = missionDescription.frame.size.height-160;
        NSLog(@"%ld", (long)offset);
        
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, content.contentSize.height)];
        [content insertSubview:container atIndex:0];
        
        container.frame = CGRectMake(0, offset, container.frame.size.width, container.frame.size.height);
        
        [container addSubview:dateImage];
        [container addSubview:typeImage];
        [container addSubview:dateTitle];
        [container addSubview:typeTitle];
        [container addSubview:dateData];
        [container addSubview:typeData];
        
        [container addSubview:eventDivider];
        [container addSubview:eventTitle];
        [container addSubview:eventTable];
        [container addSubview:eventTimeline];
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == eventTable) {
        return 3;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == eventTable) {
        DSAEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell"];
        
        if (indexPath.row == 0) {
            cell.name.text = @"Launch";
        } else if (indexPath.row == 1) {
            cell.name.text = @"Arrival";
        } else if (indexPath.row == 2) {
            cell.name.text = @"Death";
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
