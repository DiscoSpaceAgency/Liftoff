//
//  DSANotificationController.m
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSANotificationController.h"

@implementation DSANotificationController

+ (instancetype)sharedInstance
{
    static DSANotificationController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DSANotificationController alloc] init];
    });
    return sharedInstance;
}

- (void)setNotificationWithLaunch:(DSALaunch *)launch {
    NSDate *alertTime = [[NSDate date] dateByAddingTimeInterval:10];
    UIApplication *app = [UIApplication sharedApplication];
    UILocalNotification *notifyAlarm = [[UILocalNotification alloc] init];
    
    if (notifyAlarm) {
        notifyAlarm.fireDate = alertTime;
        notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
        notifyAlarm.repeatInterval = 0;
        notifyAlarm.alertBody = @"Launch";
        [app scheduleLocalNotification:notifyAlarm];
    }
}
- (void)fakeNotificationIn:(NSTimeInterval)time {
    NSDate *alertTime = [[NSDate date] dateByAddingTimeInterval:time];
    UILocalNotification *notifyAlarm = [[UILocalNotification alloc] init];
    
    if (notifyAlarm) {
        notifyAlarm.fireDate = alertTime;
        notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
        notifyAlarm.repeatInterval = 0;
        notifyAlarm.alertBody = @"Launching in 5";
        [[UIApplication sharedApplication] scheduleLocalNotification:notifyAlarm];
    }
}

@end
