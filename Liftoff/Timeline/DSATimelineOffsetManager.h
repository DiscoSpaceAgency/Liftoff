//
//  DSATimelineOffsetManager.h
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

@interface DSATimelineOffsetManager : NSObject <UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) UITableView *timelineTable;
@property (readonly, nonatomic) NSInteger offset;

+ (instancetype)sharedInstance;

- (void)panRecognized:(UIPanGestureRecognizer *)gestureRecognizer;
- (void)todayRecognized;

@end
