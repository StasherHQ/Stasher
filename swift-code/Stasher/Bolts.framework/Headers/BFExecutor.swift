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
 An object that can run a given block.
 */
class BFExecutor: NSObject {
    /*!
     Returns a default executor, which runs continuations immediately until the call stack gets too
     deep, then dispatches to a new GCD queue.
     */
    class func default() -> BFExecutor {
    }
    /*!
     Returns an executor that runs continuations on the thread where the previous task was completed.
     */

    class func immediate() -> BFExecutor {
    }
    /*!
     Returns an executor that runs continuations on the main thread.
     */

    class func mainThread() -> BFExecutor {
    }
    /*!
     Returns a new executor that uses the given block to execute continuations.
     @param block The block to use.
     */

    convenience init(block: @escaping (_ block: Void) -> Void) {
    }
    /*!
     Returns a new executor that runs continuations on the given queue.
     @param queue The instance of `dispatch_queue_t` to dispatch all continuations onto.
     */

    convenience init(dispatchQueue queue: DispatchQueue) {
    }
    /*!
     Returns a new executor that runs continuations on the given queue.
     @param queue The instance of `NSOperationQueue` to run all continuations on.
     */

    convenience init(operationQueue queue: OperationQueue) {
    }
    /*!
     Runs the given block using this executor's particular strategy.
     @param block The block to execute.
     */

    func execute(_ block: @escaping () -> Void) {
    }
}