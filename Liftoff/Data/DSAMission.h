//
//  DSAMission.h
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

typedef NS_ENUM(NSUInteger, DSAAgency) {
    kDSAAgencyNASA,
    kDSAAgencyJAXA,
    kDSAAgencyESA,
    kDSAAgencyRSA,
    kDSAAgencyCSA,
    kDSAAgencyUnknown
};
typedef NS_ENUM(NSUInteger, DSAMissionType) {
    kDSAMissionTypeUndefined = 100,
    kDSAMissionTypeSatellite = 1,
    kDSAMissionTypeRover = 2,
    kDSAMissionTypeManned = 3,
    kDSAMissionTypeOther = 4
};

@interface DSAMission : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) NSArray *agencies;
@property (readwrite, nonatomic) DSAMissionType type;
@property (strong, nonatomic) NSURL *websiteURL;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSString *quickDescription;
@property (strong, nonatomic) NSString *longDescription;
@property (readwrite, nonatomic) NSInteger id;
@property (strong, nonatomic) NSArray *events;

+ (instancetype)missionFromJSON:(NSDictionary *)jsonDict;

@end
