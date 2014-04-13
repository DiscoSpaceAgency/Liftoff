//
//  DSADateConverter.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/13/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSADateConverter : NSObject

+ (instancetype)sharedInstance;

- (NSString *)timeUntilDate:(NSDate *)date;
- (NSString *)dateStringFromDate:(NSDate *)date;
- (NSString *)timeStringFromDate:(NSDate *)date;

@end
