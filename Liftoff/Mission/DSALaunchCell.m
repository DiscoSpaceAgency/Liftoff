//
//  DSALaunchCell.m
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSALaunchCell.h"

@implementation DSALaunchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scroll:) name:@"LaunchScroll" object:nil];
    
    [_launchName setFont:[UIFont fontWithName:@"Novecentosanswide-DemiBold" size:18.0]];
    [_timeLabel setFont:[UIFont fontWithName:@"Novecentosanswide-DemiBold" size:13.0]];
    [_dateLabel setFont:[UIFont fontWithName:@"Novecentosanswide-Light" size:17.0]];
    [_timeDetails setFont:[UIFont fontWithName:@"Novecentosanswide-Light" size:17.0]];
}

- (void)didMoveToWindow {
    CGFloat y = [self.superview convertPoint:self.frame.origin toView:nil].y/self.window.frame.size.height;
    [self setBackgroundColor:[UIColor colorWithWhite:(1.0-y/3) alpha:1.0]];
}
- (void)scroll:(NSNotification *)notification {
    CGFloat y = [self.superview convertPoint:self.frame.origin toView:nil].y/self.window.frame.size.height;
    [self setBackgroundColor:[UIColor colorWithWhite:(1.0-y/3) alpha:1.0]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
