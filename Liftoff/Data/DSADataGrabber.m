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
#import "DSALaunch.h"

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

- (NSArray *)getAllLaunches
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM-yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    
    NSString *url = [NSString stringWithFormat:@"http://www.spaceflight101.com/launch-calendar-%@.html", yearString];
    NSString *rawData = [self stringFromURL:url];
    NSString *table = [self getStringWithStart:@"<tr height=21 style='mso-height-source:userset;height:15.75pt'>" endString:@"<!----------------------------->" fromData:rawData];
    
    NSMutableArray *launches = [[NSMutableArray alloc] init];
    
    [[table componentsSeparatedByString:@"</tr>"] enumerateObjectsUsingBlock:^(NSString *row, NSUInteger idx, BOOL *stop) {
        if ([row rangeOfString:@"x:num>20"].location != NSNotFound) {
            DSALaunch *launch = [[DSALaunch alloc] init];
            __block NSString *year;
            __block NSString *date;
            __block NSString *time = @"00:00";
            
            [[row componentsSeparatedByString:@"\n"] enumerateObjectsUsingBlock:^(NSString *line, NSUInteger idx, BOOL *stop) {
                
                if (idx == 2) {
                    year = [self getStringWithStart:@">" endString:@"</td>" fromData:line];
                } else if (idx == 3) {
                    date = [self getStringWithStart:@">" endString:@"</td>" fromData:line];
                } else if (idx == 4) {
                    if ([line rangeOfString:@"UTC"].location != NSNotFound) {
                        time = [self getStringWithStart:@">" endString:@"</td>" fromData:line];
                        time = [time stringByReplacingOccurrencesOfString:@" UTC" withString:@""];
                        if (time.length > 6 || time.length == 6) {
                            time = [time substringToIndex:5];
                        }
                    }
                } else if (idx == 6) {
                    NSString *vehicle = [self getStringWithStart:@">" endString:@"</td>" fromData:line];
                    launch.vehicle = vehicle;
                } else if (idx == 7) {
                    NSString *payload = [self getStringWithStart:@">" endString:@"</td>" fromData:line];
                    launch.payload = payload;
                }
                
            }];
            
            if (time.length > 0) {
                NSString *dateString = [NSString stringWithFormat:@"%@ %@ %@", time, date, year];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
                [dateFormatter setTimeZone:timeZone];
                [dateFormatter setDateFormat:@"HH:mm MM dd yyyy"];
                NSDate *myDate = [dateFormatter dateFromString: dateString];
                
                launch.date = myDate;
            } else {
                NSString *dateString = [NSString stringWithFormat:@"%@ %@", date, year];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
                [dateFormatter setTimeZone:timeZone];
                [dateFormatter setDateFormat:@"MM dd yyyy"];
                NSDate *myDate = [dateFormatter dateFromString: dateString];
                
                launch.date = myDate;
            }
            
            if (launch.date && [launch.date timeIntervalSince1970] > [[NSDate date] timeIntervalSince1970]) {
                [launches addObject:launch];
            }
        }
    }];
    
    return launches;
}

- (NSURL *)getCurrentLiveStream
{
    NSString *rawData = [self stringFromURL:@"http://www.spaceflight101live.com"];
    NSString *link = [self getStringWithStart:@"'><a href='http://www.spaceflight101live.com/" endString:@"'>Live Event</a>" fromData:rawData];
    
    link = [NSString stringWithFormat:@"http://www.spaceflight101live.com/%@", link];
    
    return [NSURL URLWithString:link];
}

- (NSString *)stringFromURL:(NSString *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSError *errorDownload = nil;
    NSURLResponse *response = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&errorDownload];
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return responseString;
}


- (NSString *)getStringWithStart:(NSString *)startString endString:(NSString *)endString fromData:(NSString *)data {
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString: data];
    text = nil;
    
    [theScanner scanUpToString:startString intoString: NULL];
    if ([theScanner isAtEnd] == NO) {
        NSInteger newLoc = [theScanner scanLocation];
        [theScanner setScanLocation: newLoc];
        [theScanner scanUpToString:endString intoString: &text];
    }
    if (text && ![text isEqualToString:@""]) {
        text = [NSString stringWithFormat:@"%@", text];
        text = [text stringByReplacingOccurrencesOfString:startString withString:@""];
        return text;
    }
    return nil;
}

@end
