//
//  DSANextLaunchCell.m
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSANextLaunchCell.h"
#import "DSADataGrabber.h"
#import "DSADateConverter.h"

@implementation DSANextLaunchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}
- (void)awakeFromNib {
    self.watchLive.layer.cornerRadius = 10;
    self.watchLive.layer.borderColor = [UIColor whiteColor].CGColor;
    self.watchLive.layer.borderWidth = 1;
    self.watchLive.layer.masksToBounds = YES;
    
    [_launchName setFont:[UIFont fontWithName:@"Novecentosanswide-DemiBold" size:20.0]];
    [_launchingIn setFont:[UIFont fontWithName:@"Novecentosanswide-Light" size:18.0]];
    
    [_timeLabel setFont:[UIFont fontWithName:@"Novecentosanswide-Light" size:60.0]];
    
    [_watchLive.titleLabel setFont:[UIFont fontWithName:@"Novecentosanswide-DemiBold" size:16.0]];
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountdown) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];
}

- (void)updateCountdown {
    self.timeLabel.text = [[DSADateConverter sharedInstance] timeUntilDate:self.date];
}

- (IBAction)showLiveStream:(id)sender {
    [SVProgressHUD showWithStatus:@"Finding Stream"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURL *link = [[DSADataGrabber sharedInstance] getCurrentLiveStream];
        dispatch_async( dispatch_get_main_queue(), ^{
            if (link) {
                [SVProgressHUD dismiss];
                [[UIApplication sharedApplication] openURL:link];
            } else {
                [SVProgressHUD showErrorWithStatus:@"Not Found"];
            }
        });
    });
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
