//
//  DSADataStore.m
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSADataStore.h"
#import "DSADataGrabber.h"
#import "DSAMission.h"
#import "DSAEvent.h"

@implementation DSADataStore

+ (instancetype)sharedInstance
{
    static DSADataStore *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DSADataStore alloc] init];
        [sharedInstance fetchData];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _missions = @[];
        _events = @[];
    }
    return self;
}

- (void)fetchData
{
    _missions = [[DSADataGrabber sharedInstance] getAllMissions];
    [_missions enumerateObjectsUsingBlock:^(DSAMission *mission, __unused NSUInteger idx, __unused BOOL *stop) {
        _events = [_events arrayByAddingObjectsFromArray:mission.events];
    }];

    _missions = [_missions sortedArrayUsingComparator:^NSComparisonResult(DSAMission *mission1, DSAMission *mission2) {
        return [mission1.startDate compare:mission2.startDate];
    }];
    _events = [_events sortedArrayUsingComparator:^NSComparisonResult(DSAEvent *event1, DSAEvent *event2) {
        return [event1.date compare:event2.date];
    }];
}

@end
