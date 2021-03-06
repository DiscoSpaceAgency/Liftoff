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
@property (strong, nonatomic) IBOutlet UILabel *agencyLabel;
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

- (void)awakeFromNib
{
    [super awakeFromNib];
    [_missionNameLabel setFont:[UIFont fontWithName:@"Novecentosanswide-Light" size:19.0]];
    [_agencyLabel setFont:[UIFont fontWithName:@"Novecentosanswide-DemiBold" size:9.0]];
}

- (void)didMoveToWindow
{
    CGFloat y = [self.superview convertPoint:self.frame.origin toView:nil].y/self.window.frame.size.height;
    [_timelineStrip setBackgroundColor:[UIColor colorWithWhite:(1.0-y/3) alpha:1.0]];
}

- (void)setMission:(DSAMission *)mission
{
    _mission = mission;
    if (mission) {
        _missionNameLabel.text = _mission.name;
        _agencyLabel.text = _mission.agencyString;
        [_timelineStrip setFrame:CGRectMake(10 + [DSATimelineOffsetManager sharedInstance].offset + [DSATimelineWidthCalculator position:_mission.startDate], 0, [DSATimelineWidthCalculator widthForStart:_mission.startDate end:_mission.endDate], self.frame.size.height)];
//        [[DSATimelineWidthCalculator tickPositionsForYearsBetweenStart:_mission.startDate end:_mission.endDate] enumerateObjectsUsingBlock:^(NSNumber *tickPosition, NSUInteger idx, BOOL *stop) {
//            UIView *tick = [[UIView alloc] initWithFrame:CGRectMake([tickPosition integerValue] - [DSATimelineWidthCalculator position:_mission.startDate], 0, 1, self.frame.size.height)];
//            [tick setBackgroundColor:[UIColor colorWithRed:0.07 green:0.16 blue:0.25 alpha:1]];
//            [_timelineStrip addSubview:tick];
//        }];
        CGFloat labelMinX = MAX(-_timelineStrip.frame.origin.x + 10, 10);
        [_missionNameLabel setFrame:CGRectMake(labelMinX, 10, self.frame.size.width - 40, 30)];
        [_agencyLabel setFrame:CGRectMake(labelMinX, 35, self.frame.size.width - 40, 20)];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pan:) name:@"TimelinePan" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scroll:) name:@"TimelineScroll" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetOffset:) name:@"TimelineResetOffset" object:nil];
}

- (void)pan:(NSNotification *)notification
{
    NSInteger offset = [(NSNumber *)notification.userInfo[@"translate"] integerValue];
    CGFloat labelX = MAX(-offset - [DSATimelineWidthCalculator position:MIN(_mission.startDate,_mission.endDate)], 10);
    [UIView animateWithDuration:0.1 animations:^{
        [_timelineStrip setFrame:CGRectMake(10 + offset + [DSATimelineWidthCalculator position:_mission.startDate], 0, [DSATimelineWidthCalculator widthForStart:_mission.startDate end:_mission.endDate], self.frame.size.height)];
        [_missionNameLabel setFrame:CGRectMake(labelX, 10, self.frame.size.width - 40, 30)];
        [_agencyLabel setFrame:CGRectMake(labelX, 35, self.frame.size.width - 40, 20)];
    }];
}

- (void)scroll:(NSNotification *)notification
{
    CGFloat y = [self.superview convertPoint:self.frame.origin toView:nil].y/self.window.frame.size.height;
    [_timelineStrip setBackgroundColor:[UIColor colorWithWhite:(1.0-y/3) alpha:1.0]];
}

- (void)resetOffset:(NSNotification *)notification
{
    [UIView animateWithDuration:0.1 animations:^{
        [_timelineStrip setFrame:CGRectMake(10 + [DSATimelineOffsetManager sharedInstance].offset + [DSATimelineWidthCalculator position:_mission.startDate], 0, [DSATimelineWidthCalculator widthForStart:_mission.startDate end:_mission.endDate], self.frame.size.height)];
        CGFloat labelMinX = MAX(-_timelineStrip.frame.origin.x + 10, 10);
        [_missionNameLabel setFrame:CGRectMake(labelMinX, 10, self.frame.size.width - 40, 30)];
        [_agencyLabel setFrame:CGRectMake(labelMinX, 35, self.frame.size.width - 40, 20)];
    }];
}

- (void)prepareForReuse
{
    _mission = nil;
    _missionNameLabel.text = @"";
    [_timelineStrip setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGFloat labelMinX = MAX(-_timelineStrip.frame.origin.x + 10, 10);
    [_missionNameLabel setFrame:CGRectMake(labelMinX, 10, self.frame.size.width - 40, 30)];
    [_agencyLabel setFrame:CGRectMake(labelMinX, 35, self.frame.size.width - 40, 20)];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (CGRect)stripRect
{
    return _timelineStrip.frame;
}

@end
