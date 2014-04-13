//
//  DSADataStore.h
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

@interface DSADataStore : NSObject

@property (strong, readonly, nonatomic) NSArray *missions;
@property (strong, readonly, nonatomic) NSArray *events;
@property (strong, readonly, nonatomic) NSArray *launches;

@property (readonly, nonatomic) NSInteger minYear;
@property (readonly, nonatomic) NSInteger maxYear;
@property (readonly, nonatomic) NSInteger todayYear;

+ (instancetype)sharedInstance;

- (void)fetchLaunches;

@end
