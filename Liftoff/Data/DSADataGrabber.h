//
//  DSADataGrabber.h
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

@interface DSADataGrabber : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)getAllMissions;
- (NSArray *)getAllLaunches;
- (NSURL *)getCurrentLiveStream;

@end
