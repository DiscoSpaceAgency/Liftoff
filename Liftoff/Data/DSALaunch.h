//
//  DSALaunch.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSALaunch : NSObject

@property (strong, nonatomic) NSString *launchVehicle;
@property (strong, nonatomic) NSString *payload;
@property (strong, nonatomic) NSString *vehicle;
@property (strong, nonatomic) NSDate *date;

+ (instancetype)launchFromDict:(NSDictionary *)keyDict;

@end