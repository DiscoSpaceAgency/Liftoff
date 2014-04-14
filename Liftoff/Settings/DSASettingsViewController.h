//
//  DSASettingsViewController.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

@protocol DSASettingsViewControllerDelegate <NSObject>

@end

@interface DSASettingsViewController : UIViewController {
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *doneButton;
    IBOutlet UILabel *description;
    IBOutlet UILabel *launchesLabel;
    IBOutlet UIButton *launchesAlert;
}

@property (copy, nonatomic) NSString *segueIdentifier;

- (IBAction)pressedLaunches:(id)sender;

- (IBAction)done:(id)sender;

@end
