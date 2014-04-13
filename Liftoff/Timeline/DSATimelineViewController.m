//
//  DSATimelineViewController.m
//  Liftoff
//
//  Created by Michael on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import "DSATimelineViewController.h"
#import "DSATimelineDataSource.h"
#import "DSATimelineOffsetManager.h"

@interface DSATimelineViewController ()

@property (strong, nonatomic) IBOutlet UITableView *timelineTable;
@property (strong, nonatomic) DSATimelineDataSource *dataSource;
@property (strong, nonatomic) UIPanGestureRecognizer *panRecognizer;

@end

@implementation DSATimelineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:[DSATimelineOffsetManager sharedInstance] action:@selector(panRecognized:)];
    [_panRecognizer setDelegate:[DSATimelineOffsetManager sharedInstance]];
    [self.view addGestureRecognizer:_panRecognizer];

    _dataSource = [[DSATimelineDataSource alloc] init];
    [_timelineTable setDataSource:_dataSource];
    [_timelineTable setDelegate:[DSATimelineOffsetManager sharedInstance]];
    [[DSATimelineOffsetManager sharedInstance] setTimelineTable:_timelineTable];
}

@end
