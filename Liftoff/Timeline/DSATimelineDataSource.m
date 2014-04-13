//
//  DSATimelineDataSource.m
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSATimelineDataSource.h"
#import "DSADataStore.h"
#import "DSATimelineViewCell.h"

@implementation DSATimelineDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DSADataStore sharedInstance].missions.count;
}

- (DSAMission *)missionforIndexPath:(NSIndexPath *)indexPath
{
    return [DSADataStore sharedInstance].missions[indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DSATimelineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimelineCell"];
    cell.mission = [self missionforIndexPath:indexPath];
    return cell;
}

@end
