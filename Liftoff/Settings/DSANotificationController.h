//
//  DSANotificationController.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSALaunch.h"

@interface DSANotificationController : NSObject

+ (instancetype)sharedInstance;

- (void)setNotificationWithLaunch:(DSALaunch *)launch;
- (void)fakeNotificationIn:(NSTimeInterval)time;

@end
