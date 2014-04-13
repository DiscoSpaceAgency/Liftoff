//
//  DSATimelineDataSource.h
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

@class DSAMission;

@interface DSATimelineDataSource : NSObject <UITableViewDataSource>

- (DSAMission *)missionforIndexPath:(NSIndexPath *)indexPath;

@end
