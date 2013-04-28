//
//  TestTask.m
//  Domain
//
//  Created by Donald Pavlik on 4/17/13.
//  Copyright (c) 2013 Donald Pavlik. All rights reserved.
//

#import "TestTask.h"

@implementation TestTask

// Properties
@synthesize testTask;

-(void)setUp {
    [super setUp];
    
    testTask = [[Task alloc] init];
    STAssertNotNil(testTask, @"Cound not create Task");
}

-(void)tearDown {
    [super tearDown];
}

/*!
    Tests the initial values for the properties of task
*/
-(void)testInitalValuesOfTask {
    STAssertNil(testTask.description, @"Initialized task's description is not null.");
    STAssertNil(testTask.note, @"Initialized task's note is not null");
    STAssertFalse(testTask.inProgress, @"Initialized task's in progress is true, should be false.");
    STAssertFalse(testTask.isCompleted, @"Initialized tasks is set as completed, should be not completed.");
    STAssertFalse(testTask.isBlocked, @"Initialized task is set as blocked, should be not blocked.");
    STAssertEquals(0.0, testTask.timeTaken, @"Initialized tasks time taken is not null.");
    STAssertNotNil(testTask.subTasks, @"Initialized tasks subtasks should have a collection, and not be nill");
    STAssertEquals([testTask.subTasks count], (NSUInteger)0, @"Initialized tasks sub task collection should have no items in it.");
};

/*!
    Tests to see if the passed in description is the same being returned.
*/
-(void)testTaskDescription {
    NSString *testString = @"Test task description";
    testTask.description = testString;
    
    STAssertEquals(testString, testTask.description, @"Returned task description is not the same as supplied description value.");
}

/*! 
    Tests to see if the passed in note is the same being returned.
*/
-(void)testTaskNote {
    NSString *testNote = @"Test task note";
    testTask.note = testNote;
    
    STAssertEquals(testNote, testTask.note, @"Returned task note is not the same as supplied note value.");
}

/*!
    Tests to see if a started task is in progress
*/
-(void)testStartTaskInProgress
{
    [testTask Start];
    
    STAssertTrue(testTask.inProgress, @"Started task not marked as in progress.");
}

/*! 
    Tests to see if a paused task is no longer in progress
*/
-(void)testStartedTaskPausedIsNotInProgress
{
    [testTask Start];
    [testTask Pause];

    STAssertFalse(testTask.inProgress, @"Paused task is still in progress");
}

/*! 
    Tests to see if a Paused Task updates the Time Taken
*/
-(void)testPausedTaskUpdatesTimeTakenFromStartTask
{
    [testTask Start];
    
    [testTask Pause];
    
    STAssertFalse(testTask.timeTaken == 0, @"Time Taken has not been updated from its initial value.");
}

/*! 
    Tests that pausing a task multiple times does not change the value of time taken from the first pause if task was not started again
*/
-(void)testMultiplePauseForStartTaskDoesNotUpdateTimeTaken
{
    [testTask Start];
    [testTask Pause];
    double timeTaken = testTask.timeTaken;
    
    [testTask Pause];
    [testTask Pause];
    
    STAssertEquals(timeTaken, testTask.timeTaken, @"Tasks time taken being updated when task has not been restarted.");
}

/*!
    Tests that starting and pausing a task multiple times increments the time taken.
*/
-(void)testStartPauseStartPauseTaskTimeTakenIsUpdating
{
    [testTask Start];
    [testTask Pause];
    double timeTaken = testTask.timeTaken;
    
    [testTask Start];
    [testTask Pause];

    STAssertTrue(timeTaken < testTask.timeTaken, @"Tasks time taken is not being updated, from start to pause");
}

/*!
    Tests that a started task when completed updates the time taken
*/
-(void)testCompletingStartedTaskUpdatesTimeTaken
{
    [testTask Start];
    [testTask Completed];
    
    STAssertTrue(testTask.isCompleted, @"Completed task is not marked as complete.");
    STAssertFalse(testTask.inProgress, @"Completed task is still marked as in progress");
    STAssertTrue(0.0 < testTask.timeTaken, @"Completed task does not have a recorded time taken.");
}

@end
