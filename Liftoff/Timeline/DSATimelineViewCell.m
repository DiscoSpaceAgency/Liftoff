//
//  DSATimelineViewCell.m
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSATimelineViewCell.h"
#import "DSAMission.h"
#import "DSATimelineWidthCalculator.h"
#import "DSATimelineOffsetManager.h"

@interface DSATimelineViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *missionNameLabel;
@property (strong, nonatomic) IBOutlet UIView *timelineStrip;

@end

@implementation DSATimelineViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setMission:(DSAMission *)mission
{
    _mission = mission;
    if (mission) {
        _missionNameLabel.text = _mission.name;
        [_timelineStrip setFrame:CGRectMake(10 + [DSATimelineOffsetManager sharedInstance].offset + [DSATimelineWidthCalculator position:_mission.startDate], 22, [DSATimelineWidthCalculator widthForStart:_mission.startDate end:_mission.endDate], 22)];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"TimelinePan" object:nil];
}

- (void)receiveNotification:(NSNotification *) notification
{
    NSInteger offset = [(NSNumber *)notification.userInfo[@"translate"] integerValue];
    [_timelineStrip setFrame:CGRectMake(10 + offset + [DSATimelineWidthCalculator position:_mission.startDate], 22, [DSATimelineWidthCalculator widthForStart:_mission.startDate end:_mission.endDate], 22)];
}

- (void)prepareForReuse
{
    _mission = nil;
    _missionNameLabel.text = @"";
    [_timelineStrip setFrame:CGRectMake(0, 22, self.frame.size.width, 22)];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
