//
//  DSAEventCell.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSAEventCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *eventIcon;
@property (nonatomic, strong) IBOutlet UIImageView *timeline;
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *description;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSIndexPath *index;

@end
