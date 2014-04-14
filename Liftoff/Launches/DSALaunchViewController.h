//
//  DSALaunchViewController.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSALaunchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIButton *settingsButton;
    IBOutlet UIButton *timelineButton;
    
    IBOutlet UILabel *titleLabel;
    
    IBOutlet UITableView *launchesTable;
    
    IBOutlet UIImageView *divider;
}

@property (strong, nonatomic) IBOutlet UIButton *settingsButton;
@property (strong, nonatomic) IBOutlet UIButton *timelineButton;

@end
