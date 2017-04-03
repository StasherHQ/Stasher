//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
/*
 *  Copyright (c) 2016, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 */
//once
import Foundation
/**
 Returns whether all instances of `BFTask` should automatically @try/@catch exceptions in continuation blocks. Default: `YES`.

 @return Boolean value indicating whether exceptions are being caught.
 */
func BFTaskCatchesExceptions() -> Bool {
}

/**
 Set whether all instances of `BFTask` should automatically @try/@catch exceptions in continuation blocks. Default: `YES`.

 @param catchExceptions Boolean value indicating whether exceptions shoudl be caught.
 */
func BFTaskSetCatchesExceptions(catchExceptions: Bool) {
}