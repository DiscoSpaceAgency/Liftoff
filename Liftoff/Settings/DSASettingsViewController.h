//
//  DSASettingsViewController.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

@interface DSASettingsViewController : UIViewController {
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *doneButton;
    IBOutlet UILabel *description;
    IBOutlet UILabel *launchesLabel;
    IBOutlet UIButton *launchesAlert;
}

- (IBAction)pressedLaunches:(id)sender;

@end
