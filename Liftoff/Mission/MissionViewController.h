//
//  MissionViewController.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MissionViewController : UIViewController {
    IBOutlet UIScrollView *content;
    
    IBOutlet UIImageView *missionImage;
    
    IBOutlet UIButton *backButton;
    
    IBOutlet UILabel *missionName;
    IBOutlet UILabel *agencyLabel;
    IBOutlet UILabel *statusLabel;
    
    IBOutlet UIButton *downButton;
}

@end
