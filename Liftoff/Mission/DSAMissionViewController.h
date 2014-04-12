//
//  DSAMissionViewController.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSAMission.h"
#import "DSAEvent.h"

@interface DSAMissionViewController : UIViewController {
    IBOutlet UIScrollView *content;
    
    IBOutlet UIImageView *missionImage;
    
    IBOutlet UIButton *backButton;
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *agencyLabel;
    IBOutlet UILabel *statusLabel;
    
    IBOutlet UIButton *downButton;
}
@property (nonatomic, strong) DSAMission *mission;

- (IBAction)done:(id)sender;

@end
