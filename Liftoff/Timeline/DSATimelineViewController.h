//
//  DSATimelineViewController.h
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSASettingsViewController.h"

@interface DSATimelineViewController : UIViewController <DSASettingsViewControllerDelegate>

@property (readonly, nonatomic) CGRect selectedTimelineStripRect;
@property (readonly, nonatomic) UIButton *settingsButton;
@property (readonly, nonatomic) UIButton *eventsButton;

@end
