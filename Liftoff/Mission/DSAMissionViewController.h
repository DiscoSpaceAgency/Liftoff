//
//  DSAMissionViewController.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

#import "DSAAstronautCell.h"
#import "DSAMission.h"
#import "DSAEvent.h"

@interface DSAMissionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIScrollView *content;
    
    IBOutlet EGOImageView *missionImage;
    IBOutlet UIImageView *topBarImage;
    
    IBOutlet UIButton *backButton;
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *agencyLabel;
    IBOutlet UILabel *statusLabel;
    
    IBOutlet UIButton *downButton;
    IBOutlet UIImageView *downShadow;
    
    IBOutlet UITableView *astronautTable;
    
    IBOutlet UILabel *eventTitle;
    IBOutlet UIImageView *eventDivider;
    IBOutlet UITableView *eventTable;
}
@property (nonatomic, strong) DSAMission *mission;

- (IBAction)done:(id)sender;

@end
