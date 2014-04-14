//
//  DSAMissionViewController.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DSAAstronautCell.h"
#import "DSAEventCell.h"
#import "DSAMission.h"
#import "DSAEvent.h"

@interface DSAMissionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIScrollView *content;
    
    IBOutlet UIImageView *topBar;
    
    IBOutlet EGOImageView *missionImage;
    IBOutlet UIImageView *faderImage;
    
    IBOutlet UIButton *backButton;
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *agencyLabel;
    IBOutlet UILabel *statusLabel;
    
    IBOutlet UILabel *missionTitle;
    IBOutlet UILabel *summaryTitle;
    
    IBOutlet UIButton *downButton;
    IBOutlet UIImageView *downShadow;
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UIImageView *contentDivider;
    
    IBOutlet UILabel *missionDescription;
    
    IBOutlet UIImageView *dateImage;
    IBOutlet UIImageView *typeImage;
    IBOutlet UILabel *dateTitle;
    IBOutlet UILabel *typeTitle;
    IBOutlet UILabel *dateData;
    IBOutlet UILabel *typeData;
    
    IBOutlet UILabel *eventTitle;
    IBOutlet UIImageView *eventDivider;
    IBOutlet UITableView *eventTable;
    IBOutlet UIImageView *eventTimeline;
}

@property (nonatomic, strong) DSAMission *mission;
@property (nonatomic, readonly, strong) IBOutlet EGOImageView *missionImage;

- (IBAction)done:(id)sender;

@end
