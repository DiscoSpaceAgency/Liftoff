//
//  DSADataGrabber.m
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSADataGrabber.h"

@implementation DSADataGrabber

+ (instancetype)sharedInstance
{
    static DSADataGrabber *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DSADataGrabber alloc] init];
    });
    return sharedInstance;
}

- (NSArray *)getAllMissions
{
    return @[];
}

@end
