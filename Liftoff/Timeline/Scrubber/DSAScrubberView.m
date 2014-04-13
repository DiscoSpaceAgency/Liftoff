//
//  DSAScrubberView.m
//  Liftoff
//
//  Created by Michael on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSAScrubberView.h"

@interface DSAScrubberView ()

@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIView *dateMarker;

@end

@implementation DSAScrubberView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    CGFloat spacing = self.frame.size.width/20.0;
    CGFloat lineWidth = 4;
    for (NSInteger year = 1994; year <= 2024; year++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(spacing*(year-1993)-lineWidth/2, self.frame.size.height*3/4, lineWidth, self.frame.size.height/2)];
        [self addSubview:view];
    }
    UIView *todayView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-lineWidth, self.frame.size.height*3/4, lineWidth*2, self.frame.size.height/2)];
    [self addSubview:todayView];

    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/4)];
    _dateLabel.font = [UIFont fontWithName:@"NovecentosansWide-DemiBold" size:9.0];
    _dateLabel.textColor = [UIColor colorWithRed:0.56 green:0.09 blue:0.06 alpha:1];
    _dateLabel.text = [self textForDate:[NSDate date]];
}

- (NSString *)textForDate:(NSDate *)date
{
    NSDateComponents *dateComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:date];
    NSInteger dateYear = dateComponents.year;
    NSInteger dateMonth = dateComponents.month;

    static NSArray *monthTexts = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monthTexts = @[@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec"];
    });
    return [NSString stringWithFormat:@"%@ %i",monthTexts[dateMonth],dateYear];
}

@end
