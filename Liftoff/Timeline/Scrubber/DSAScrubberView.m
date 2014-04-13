//
//  DSAScrubberView.m
//  Liftoff
//
//  Created by Michael on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSAScrubberView.h"
#import "DSAScrubberManager.h"
#import "DSADataStore.h"

@interface DSAScrubberView ()

@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIView *dateMarker;
@property (strong, nonatomic) UIPanGestureRecognizer *panRecognizer;
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (readwrite, nonatomic) NSInteger maxX;
@property (readwrite, nonatomic) NSInteger minX;

@end

@implementation DSAScrubberView

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSInteger minYear = [DSADataStore sharedInstance].minYear;
    NSInteger maxYear = [DSADataStore sharedInstance].maxYear;
    NSDateComponents *todayDateComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger todayYear = todayDateComponents.year;

    CGFloat spacing = self.frame.size.width/MAX(maxYear-todayYear+1,todayYear-minYear+1)/2;
    CGFloat lineWidth = 2;
    _minX = self.frame.size.width/2+spacing*(minYear-todayYear);
    _maxX = self.frame.size.width/2+spacing*(maxYear-todayYear);

    UIView *todayView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-lineWidth, self.frame.size.height/4, lineWidth*2, self.frame.size.height/2)];
    [todayView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:todayView];
    for (NSInteger year = minYear; year <= maxYear; year++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2+spacing*(year-todayYear)-lineWidth/2, self.frame.size.height/4, lineWidth, self.frame.size.height/2)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:view];
    }

    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, self.frame.size.height/4 - 10)];
    _dateLabel.font = [UIFont fontWithName:@"NovecentosansWide-DemiBold" size:12.0];
    _dateLabel.textColor = [UIColor colorWithRed:0.56 green:0.09 blue:0.06 alpha:1];
    _dateLabel.text = [self textForDate:[NSDate date]];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_dateLabel];

    _dateMarker = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-lineWidth, self.frame.size.height/4, lineWidth*2, self.frame.size.height/2)];
    [_dateMarker setBackgroundColor:[UIColor colorWithRed:0.56 green:0.09 blue:0.06 alpha:1]];
    [self addSubview:_dateMarker];

    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:[DSAScrubberManager sharedInstance] action:@selector(panRecognized:)];
    [self addGestureRecognizer:_panRecognizer];
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:[DSAScrubberManager sharedInstance] action:@selector(panRecognized:)];
    [self addGestureRecognizer:_tapRecognizer];
    [[DSAScrubberManager sharedInstance] setScrubberView:self];
}

- (NSString *)textForDate:(NSDate *)date
{
    NSDateComponents *dateComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:date];
    NSInteger dateYear = dateComponents.year;
    NSInteger dateMonth = dateComponents.month;
    NSDateComponents *todayDateComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:[NSDate date]];
    NSInteger todayYear = todayDateComponents.year;
    NSInteger todayMonth = todayDateComponents.month;

    if (todayYear == dateYear && todayMonth == dateMonth) {
        return @"Today";
    }

    static NSArray *monthTexts = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monthTexts = @[@"ERR",@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec"];
    });
    return [NSString stringWithFormat:@"%@ %i",monthTexts[dateMonth],dateYear];
}

@end
