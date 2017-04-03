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
 BFCancellationTokenSource represents the producer side of a CancellationToken.
 Signals to a CancellationToken that it should be canceled.
 It is a cancellation token that also has methods
 for changing the state of a token by cancelling it.
 */
class BFCancellationTokenSource: NSObject {
    /*!
     Creates a new cancellation token source.
     */
    convenience init() {
    }
    /*!
     The cancellation token associated with this CancellationTokenSource.
     */
    private(set) var token: BFCancellationToken?
    /*!
     Whether cancellation has been requested for this token source.
     */
    private(set) var isCancellationRequested: Bool = false
    /*!
     Cancels the token if it has not already been cancelled.
     */

    func cancel() {
    }
    /*!
     Schedules a cancel operation on this CancellationTokenSource after the specified number of milliseconds.
     @param millis The number of milliseconds to wait before completing the returned task.
     If delay is `0` the cancel is executed immediately. If delay is `-1` any scheduled cancellation is stopped.
     */

    func cancel(afterDelay millis: Int) {
    }
    /*!
     Releases all resources associated with this token source,
     including disposing of all registrations.
     */

    func dispose() {
    }
}