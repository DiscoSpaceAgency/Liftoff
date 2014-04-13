//
//  DSADataGrabber.m
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#define API_URL_PREFIX @"http://108.166.83.92/api/"

#import "DSADataGrabber.h"
#import "DSAMission.h"
#import "DSAEvent.h"

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
    NSString *url = [API_URL_PREFIX stringByAppendingFormat:@"missions"];
    NSArray *missions = [self responseFromURL:url];
    
    return missions;
}

- (NSArray *)responseFromURL:(NSString *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSError *errorDownload = nil;
    NSURLResponse *response = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&errorDownload];
    
    if (!errorDownload && data != nil) {
        NSError *error = nil;
        NSArray *JSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (![JSON isKindOfClass:[NSArray class]]) {
            return @[];
        }

        NSMutableArray *missions = [NSMutableArray arrayWithCapacity:JSON.count];
        [JSON enumerateObjectsUsingBlock:^(NSDictionary *object, NSUInteger idx, BOOL *stop) {
            [missions addObject:[DSAMission missionFromJSON:(NSDictionary *)object]];
        }];
        return missions;
    }
    else {
        // Problem...
        return @[];
    }
}

@end
