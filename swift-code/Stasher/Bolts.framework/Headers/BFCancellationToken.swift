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
 A block that will be called when a token is cancelled.
 */
typealias BFCancellationBlock = () -> Void
/*!
 The consumer view of a CancellationToken.
 Propagates notification that operations should be canceled.
 A BFCancellationToken has methods to inspect whether the token has been cancelled.
 */
class BFCancellationToken: NSObject {
    /*!
     Whether cancellation has been requested for this token source.
     */
    private(set) var isCancellationRequested: Bool = false
    /*!
     Register a block to be notified when the token is cancelled.
     If the token is already cancelled the delegate will be notified immediately.
     */

    func registerCancellationObserver(with block: BFCancellationBlock) -> BFCancellationTokenRegistration {
    }
}