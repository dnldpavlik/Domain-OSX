//
//  Task.m
//  Domain
//
//  Created by Donald Pavlik on 4/17/13.
//  Copyright (c) 2013 Donald Pavlik. All rights reserved.
//

#import "Task.h"

@interface Task()
@property (strong, nonatomic) NSDate *startTime;

@property (readwrite, nonatomic) BOOL inProgress;
@property (readwrite, nonatomic) BOOL isCompleted;
@property (readwrite, nonatomic) BOOL blocked;
@property (readwrite, nonatomic) double timeTaken;
@property (readwrite, nonatomic, strong) NSMutableArray *subTasks;
@end

@implementation Task

#pragma MARK: Properties
@synthesize description = _description;
@synthesize note = _note;
@synthesize inProgress = _inProgress;
@synthesize isCompleted = _isCompleted;
@synthesize blocked = _blocked;
@synthesize timeTaken = _timeTaken;
@synthesize subTasks = _subTasks;
@synthesize startTime = _startTime;

-(NSMutableArray *)subTasks
{
    if(!_subTasks)
    {
        _subTasks = [[NSMutableArray alloc] init];
    }
    
    return _subTasks;
}

#pragma MARK: Initialization
- (void)dealloc
{
    self.subTasks = nil;
}

#pragma MARK: Methods
/*!
    Logs the time taken from the set start time. If time is less than a second, time added will be 1 second.
*/
-(void)logTime
{
    if (self.startTime != nil)
    {
        double timeDifference = [self.startTime timeIntervalSinceNow] * -1;
        self.timeTaken += (timeDifference) ? timeDifference : 1;
        self.startTime = nil;
    }
}

-(void) Start
{
    self.inProgress = TRUE;
    
    self.startTime = [NSDate date];
}

-(void) Pause
{
    self.inProgress = FALSE;
    [self logTime];
}

-(void) Completed
{
    self.inProgress = FALSE;
    self.isCompleted = TRUE;
    [self logTime];
}
@end
