//
//  DSANextLaunchCell.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSANextLaunchCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *launchName;
@property (nonatomic, strong) IBOutlet UILabel *launchingIn;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UIButton *watchLive;
@property (nonatomic, strong) NSDate *date;

@end
