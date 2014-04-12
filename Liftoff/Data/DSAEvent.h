//
//  DSAEvent.h
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSAMission.h"

@interface DSAEvent : NSObject

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *name;
@property (weak, nonatomic) DSAMission *mission;

@end
