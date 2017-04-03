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

/*!
 A BFTaskCompletionSource represents the producer side of tasks.
 It is a task that also has methods for changing the state of the
 task by settings its completion values.
 */
class BFTaskCompletionSource<__covariantResultType>: NSObject {
    /*!
     Creates a new unfinished task.
     */
    class func taskCompletionSource() -> BFTaskCompletionSource<__covariantResultType> {
    }
    /*!
     The task associated with this TaskCompletionSource.
     */
    private(set) weak var task: ResultType?
    /*!
     Completes the task by setting the result.
     Attempting to set this for a completed task will raise an exception.
     @param result The result of the task.
     */

    func setResult(_ result: ResultType?) {
    }
    /*!
     Completes the task by setting the error.
     Attempting to set this for a completed task will raise an exception.
     @param error The error for the task.
     */

    func setError(_ error: Error?) {
    }
    /*!
     Completes the task by setting an exception.
     Attempting to set this for a completed task will raise an exception.
     @param exception The exception for the task.
     
     @deprecated `BFTask` exception handling is deprecated and will be removed in a future release.
     */

    func setException(_ exception: NSException) {
    }
}
/*!
 Completes the task by marking it as cancelled.
 Attempting to set this for a completed task will raise an exception.
 */

func cancel() {
    /*!
     Sets the result of the task if it wasn't already completed.
     @returns whether the new value was set.
     */
    -(BOOL)
    /*!
     Sets the error of the task if it wasn't already completed.
     @param error The error for the task.
     @returns whether the new value was set.
     */
    -(BOOL)
    /*!
     Sets the exception of the task if it wasn't already completed.
     @param exception The exception for the task.
     @returns whether the new value was set.
     
     @deprecated `BFTask` exception handling is deprecated and will be removed in a future release.
     */
    -(BOOL)
    (deprecated("`BFTask` exception handling is deprecated and will be removed in a future release."))
    /*!
     Sets the cancellation state of the task if it wasn't already completed.
     @returns whether the new value was set.
     */
    -Bool(trySetCancelled)
}