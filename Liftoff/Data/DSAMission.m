//
//  DSAMission.m
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSAMission.h"

@implementation DSAMission

id nilForReal(id arg) { return ((arg == [NSNull null]) ? nil : arg); }

+ (instancetype)missionFromJSON:(NSDictionary *)jsonDict
{
    DSAMission *mission = [[DSAMission alloc] init];
    mission.name = jsonDict[@"name"];
    mission.startDate = [mission datefromJSON:jsonDict[@"start_date"]];
    mission.endDate = [mission datefromJSON:jsonDict[@"end_date"]];
    NSMutableArray *mutableAgencies = [NSMutableArray array];
    [[((NSString *)jsonDict[@"agency"]) componentsSeparatedByString:@","] enumerateObjectsUsingBlock:^(NSString *agency, NSUInteger idx, BOOL *stop) {
        if ([agency isEqualToString:@"NASA"]) {
            [mutableAgencies addObject:@(kDSAAgencyNASA)];
        }
        else if ([agency isEqualToString:@"JAXA"]) {
            [mutableAgencies addObject:@(kDSAAgencyJAXA)];
        }
        else if ([agency isEqualToString:@"ESA"]) {
            [mutableAgencies addObject:@(kDSAAgencyESA)];
        }
        else if ([agency isEqualToString:@"Roscosmos"]) {
            [mutableAgencies addObject:@(kDSAAgencyRSA)];
        }
        else if ([agency isEqualToString:@"JAXA"]) {
            [mutableAgencies addObject:@(kDSAAgencyJAXA)];
        }
        else {
            [mutableAgencies addObject:@(kDSAAgencyUnknown)];
        }
    }];
    mission.agencies = [NSArray arrayWithArray:mutableAgencies];
    mission.agencyString = [((NSString *)jsonDict[@"agency"]) stringByReplacingOccurrencesOfString:@"," withString:@" - "];
    mission.type = [jsonDict[@"type"] integerValue];
    mission.websiteURL = [NSURL URLWithString:jsonDict[@"link"]];
    mission.imageURL = [NSURL URLWithString:jsonDict[@"image_link"]];
    mission.quickDescription = nilForReal(jsonDict[@"quick_desc"]);
    mission.longDescription = nilForReal(jsonDict[@"long_desc"]);
    mission.id = [jsonDict[@"id"] integerValue];
    return mission;
}

- (id)init
{
    self = [super init];
    if (self) {
        _agencies = @[];
        _type = kDSAMissionTypeUndefined;
        _id = -1;
        _events = @[];
    }
    return self;
}

- (NSDate *)datefromJSON:(NSString *)jsonString
{
    if (!jsonString) {
        return nil;
    }
    NSArray *dateParts = [jsonString componentsSeparatedByString:@"-"];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = [dateParts[0] integerValue];
    dateComponents.month = [dateParts[1] integerValue];
    return [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] dateFromComponents:dateComponents];
}

@end
