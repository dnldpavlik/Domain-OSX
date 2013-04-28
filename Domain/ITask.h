//
//  ITask.h
//  Domain
//
//  Created by Donald Pavlik on 4/21/13.
//  Copyright (c) 2013 Donald Pavlik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ITask <NSObject>

#pragma MARK: Properties
/*!
    @property description
    @abstract Gives the task description
*/
@property (strong, nonatomic) NSString *description;

/*!
    @property note
    @abstract Gives the note for the task
*/
@property (strong, nonatomic) NSString *note;

/*!
    @property inProgress 
    @abstract Indecates whether the task is in progress
    @discussion TRUE is the task is in progress else FALSe
*/
@property (nonatomic, readonly) BOOL inProgress;

/*!
    @property isCompleted
    @abstract Indecates whether the task is completed
    @discussion TRUE if the task is completed else FALSE
*/
@property (nonatomic, readonly) BOOL isCompleted;

/*! 
    @property blocked
    @abstract Indecates whether the task is blocked
    @discussion TRUE if the task is blocked else FALSE
*/
@property (nonatomic, getter = isBlocked, readonly) BOOL blocked;

/*! 
    @property timeTaken
    @abstract Gives the time that was taken for the task
    @result Gives the time taken in seconds for the task
    @discussion Time taken is only updated when a task has been started and either paused or completed.  On these later two events the time taken will be updated from the time the task was started to the current time of that code event.
*/
@property (nonatomic, readonly) double timeTaken;

/*!
    @property subTasks
    @abstract Gives any sub tasks for the task
    @discussion Sub tasks can be added, removed, updated to the collection, but the collection can not be ovetwritten with another collection.
*/
@property (strong, nonatomic, readonly) NSMutableArray *subTasks;

#pragma MARK: Methods
/*! 
    Starts the task
    @result Sets the internal start time of to the current time and marks the task as in progress
*/
-(void)Start;

/*!
    Pauses a task that is in Progress
    @result Sets the in progress to false and updates the time taken from the internal start time to the time the task was paused
*/
-(void)Pause;

/*! 
    Completed a task
    @result Sets the task is completed flag to true, marks the in progress as false and updates the time taken from the time the task was started
*/
-(void)Completed;

@end
