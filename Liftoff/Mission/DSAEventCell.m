//
//  DSAEventCell.m
//  Liftoff
//
//  Created by Harry Slotwiner on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSAEventCell.h"

@implementation DSAEventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.eventIcon.layer.cornerRadius = self.eventIcon.frame.size.width/2;
    }
    return self;
}

- (void)awakeFromNib
{
    [_name setFont:[UIFont fontWithName:@"Novecentosanswide-DemiBold" size:16.0]];
    [_description setFont:[UIFont fontWithName:@"Novecentosanswide-Light" size:15.0]];
    
    self.eventIcon.layer.masksToBounds = YES;
    self.eventIcon.layer.borderColor = [UIColor colorWithWhite:.9 alpha:1].CGColor;
    self.eventIcon.layer.borderWidth = 1;
    self.eventIcon.layer.cornerRadius = self.eventIcon.frame.size.width/2;
}

- (void)layoutSubviews {
    if (self.index.row == 0) {
        self.timeline.frame = CGRectMake(self.timeline.frame.origin.x, self.frame.size.height/2, 2, self.frame.size.height/2);
    } else if (self.index.row == 2) {
        self.timeline.frame = CGRectMake(self.timeline.frame.origin.x, 0, 2, self.frame.size.height/2);
    } else {
        self.timeline.frame = CGRectMake(self.timeline.frame.origin.x, 0, 2, self.frame.size.height);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
