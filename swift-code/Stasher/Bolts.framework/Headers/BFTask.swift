//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
/*
 *  Copyright (c) 2014, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */
import Foundation
import Bolts
/*!
 Error domain used if there was multiple errors on <BFTask taskForCompletionOfAllTasks:>.
 */
let BFTaskErrorDomain: String = ""
/*!
 An error code used for <BFTask taskForCompletionOfAllTasks:>, if there were multiple errors.
 */
let kBFMultipleErrorsError: Int = 0
/*!
 An exception that is thrown if there was multiple exceptions on <BFTask taskForCompletionOfAllTasks:>.
 
 @deprecated `BFTask` exception handling is deprecated and will be removed in a future release.
 */

/*!
 An error userInfo key used if there were multiple errors on <BFTask taskForCompletionOfAllTasks:>.
 Value type is `NSArray<NSError *> *`.
 */
let BFTaskMultipleErrorsUserInfoKey: String = ""
/*!
 An error userInfo key used if there were multiple exceptions on <BFTask taskForCompletionOfAllTasks:>.
 Value type is `NSArray<NSException *> *`.
 
 @deprecated `BFTask` exception handling is deprecated and will be removed in a future release.
 */

/*!
 The consumer view of a Task. A BFTask has methods to
 inspect the state of the task, and to add continuations to
 be run once the task is complete.
 */
class BFTask<__covariantResultType>: NSObject {
    /*!
     A block that can act as a continuation for a task.
     */
    var BFContinuationBlock: ((_ t: ResultType) -> Any)? = nil
    /*!
     Creates a task that is already completed with the given result.
     @param result The result for the task.
     */

    class func task(withResult result: ResultType?) -> BFTask<__covariantResultType> {
    }
    /*!
     Creates a task that is already completed with the given error.
     @param error The error for the task.
     */

    class func taskWithError(_ error: Error?) -> BFTask<__covariantResultType> {
    }
    /*!
     Creates a task that is already completed with the given exception.
     @param exception The exception for the task.
     
     @deprecated `BFTask` exception handling is deprecated and will be removed in a future release.
     */

    class func task(with exception: NSException) -> BFTask<__covariantResultType> {
    }
}
/*!
 Creates a task that is already cancelled.
 */

class func cancelledTask() -> Self {
    /*!
     Returns a task that will be completed (with result == nil) once
     all of the input tasks have completed.
     @param tasks An `NSArray` of the tasks to use as an input.
     */
    +( as? Self)
    /*!
     Returns a task that will be completed once all of the input tasks have completed.
     If all tasks complete successfully without being faulted or cancelled the result will be
     an `NSArray` of all task results in the order they were provided.
     @param tasks An `NSArray` of the tasks to use as an input.
     */
    +( as? Self)
    /*!
     Returns a task that will be completed once there is at least one successful task.
     The first task to successuly complete will set the result, all other tasks results are 
     ignored.
     @param tasks An `NSArray` of the tasks to use as an input.
     */
    +( as? Self)
    /*!
     Returns a task that will be completed a certain amount of time in the future.
     @param millis The approximate number of milliseconds to wait before the
     task will be finished (with result == nil).
     */
    +( as? Self)
    /*!
     Returns a task that will be completed a certain amount of time in the future.
     @param millis The approximate number of milliseconds to wait before the
     task will be finished (with result == nil).
     @param token The cancellation token (optional).
     */
    +( as? Self)
    /*!
     Returns a task that will be completed after the given block completes with
     the specified executor.
     @param executor A BFExecutor responsible for determining how the
     continuation block will be run.
     @param block The block to immediately schedule to run with the given executor.
     @returns A task that will be completed after block has run.
     If block returns a BFTask, then the task returned from
     this method will not be completed until that task is completed.
     */
    +( as? Self)
        // Properties that will be set on the task once it is completed.
    /*!
     The result of a successful task.
     */

    , nonatomic, strong, readonly
    var result: ResultType
    /*!
     The error of a failed task.
     */
    , nonatomic, strong, readonly
    var error: Error?
    /*!
     The exception of a failed task.
    
     @deprecated `BFTask` exception handling is deprecated and will be removed in a future release.
     */
    , nonatomic, strong, readonly
    /*!
     Whether this task has been cancelled.
     */
    (nonatomic, assign, readonly, getter = isCancelled)
    var cancelled: Bool
    /*!
     Whether this task has completed due to an error or exception.
     */
    (nonatomic, assign, readonly, getter = isFaulted)
    var faulted: Bool
    /*!
     Whether this task has completed.
     */
    (nonatomic, assign, readonly, getter = isCompleted)
    var completed: Bool
    /*!
     Enqueues the given block to be run once this task is complete.
     This method uses a default execution strategy. The block will be
     run on the thread where the previous task completes, unless the
     the stack depth is too deep, in which case it will be run on a
     dispatch queue with default priority.
     @param block The block to be run once this task is complete.
     @returns A task that will be completed after block has run.
     If block returns a BFTask, then the task returned from
     this method will not be completed until that task is completed.
     */
    -( as? BFTask)
    /*!
     Enqueues the given block to be run once this task is complete.
     This method uses a default execution strategy. The block will be
     run on the thread where the previous task completes, unless the
     the stack depth is too deep, in which case it will be run on a
     dispatch queue with default priority.
     @param block The block to be run once this task is complete.
     @param cancellationToken The cancellation token (optional).
     @returns A task that will be completed after block has run.
     If block returns a BFTask, then the task returned from
     this method will not be completed until that task is completed.
     */
    -( as? BFTask)
    /*!
     Enqueues the given block to be run once this task is complete.
     @param executor A BFExecutor responsible for determining how the
     continuation block will be run.
     @param block The block to be run once this task is complete.
     @returns A task that will be completed after block has run.
     If block returns a BFTask, then the task returned from
     this method will not be completed until that task is completed.
     */
    -( as? BFTask)
    /*!
     Enqueues the given block to be run once this task is complete.
     @param executor A BFExecutor responsible for determining how the
     continuation block will be run.
     @param block The block to be run once this task is complete.
     @param cancellationToken The cancellation token (optional).
     @returns A task that will be completed after block has run.
     If block returns a BFTask, then the task returned from
     his method will not be completed until that task is completed.
     */
    -( as? BFTask)
    /*!
     Identical to continueWithBlock:, except that the block is only run
     if this task did not produce a cancellation, error, or exception.
     If it did, then the failure will be propagated to the returned
     task.
     @param block The block to be run once this task is complete.
     @returns A task that will be completed after block has run.
     If block returns a BFTask, then the task returned from
     this method will not be completed until that task is completed.
     */
    -( as? BFTask)
    /*!
     Identical to continueWithBlock:, except that the block is only run
     if this task did not produce a cancellation, error, or exception.
     If it did, then the failure will be propagated to the returned
     task.
     @param block The block to be run once this task is complete.
     @param cancellationToken The cancellation token (optional).
     @returns A task that will be completed after block has run.
     If block returns a BFTask, then the task returned from
     this method will not be completed until that task is completed.
     */
    -( as? BFTask)
    /*!
     Identical to continueWithExecutor:withBlock:, except that the block
     is only run if this task did not produce a cancellation, error, or
     exception. If it did, then the failure will be propagated to the
     returned task.
     @param executor A BFExecutor responsible for determining how the
     continuation block will be run.
     @param block The block to be run once this task is complete.
     @returns A task that will be completed after block has run.
     If block returns a BFTask, then the task returned from
     this method will not be completed until that task is completed.
     */
    -( as? BFTask)
    /*!
     Identical to continueWithExecutor:withBlock:, except that the block
     is only run if this task did not produce a cancellation, error, or
     exception. If it did, then the failure will be propagated to the
     returned task.
     @param executor A BFExecutor responsible for determining how the
     continuation block will be run.
     @param block The block to be run once this task is complete.
     @param cancellationToken The cancellation token (optional).
     @returns A task that will be completed after block has run.
     If block returns a BFTask, then the task returned from
     this method will not be completed until that task is completed.
     */
    -( as? BFTask)
    /*!
     Waits until this operation is completed.
     This method is inefficient and consumes a thread resource while
     it's running. It should be avoided. This method logs a warning
     message if it is used on the main thread.
     */
    -(waitUntilFinished as? Void)
}