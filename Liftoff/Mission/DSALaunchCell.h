//
//  DSALaunchCell.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSALaunchCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *launchName;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeDetails;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;

@end
