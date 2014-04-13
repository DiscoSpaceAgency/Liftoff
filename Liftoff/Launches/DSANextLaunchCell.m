//
//  DSANextLaunchCell.m
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSANextLaunchCell.h"
#import "DSADateConverter.h"

@implementation DSANextLaunchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.watchLive.layer.cornerRadius = 10;
        self.watchLive.layer.borderColor = [UIColor whiteColor].CGColor;
        self.watchLive.layer.borderWidth = 1;
        self.watchLive.layer.masksToBounds = YES;
        
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountdown) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)updateCountdown {
    self.timeLabel.text = [[DSADateConverter sharedInstance] timeUntilDate:self.date];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
