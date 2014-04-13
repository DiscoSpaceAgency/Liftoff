//
//  DSAScrubberView.h
//  Liftoff
//
//  Created by Michael on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSAScrubberView : UIView

@property (readonly, nonatomic) NSInteger maxX;
@property (readonly, nonatomic) NSInteger minX;
@property (readonly, nonatomic) UILabel *dateLabel;
@property (readonly, nonatomic) UIView *dateMarker;

- (NSString *)textForDate:(NSDate *)date;

@end
