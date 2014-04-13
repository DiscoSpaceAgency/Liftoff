//
//  DSAScrubberManager.h
//  Liftoff
//
//  Created by Michael on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

@class DSAScrubberView;

@interface DSAScrubberManager : NSObject

@property (weak, nonatomic) DSAScrubberView *scrubberView;

+ (instancetype)sharedInstance;

- (void)panRecognized:(UIPanGestureRecognizer *)gestureRecognizer;

@end
