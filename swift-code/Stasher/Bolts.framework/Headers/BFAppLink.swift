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
/*! The version of the App Link protocol that this library supports */
let BFAppLinkVersion: FOUNDATION_EXPORT NSString?
/*!
 Contains App Link metadata relevant for navigation on this device
 derived from the HTML at a given URL.
 */
class BFAppLink: NSObject {
    /*!
     Creates a BFAppLink with the given list of BFAppLinkTargets and target URL.
    
     Generally, this will only be used by implementers of the BFAppLinkResolving protocol,
     as these implementers will produce App Link metadata for a given URL.
    
     @param sourceURL the URL from which this App Link is derived
     @param targets an ordered list of BFAppLinkTargets for this platform derived
     from App Link metadata.
     @param webURL the fallback web URL, if any, for the app link.
     */
    convenience init(sourceURL: URL, targets: [Any], webURL: URL) {
    }
    /*! The URL from which this BFAppLink was derived */
    private(set) var sourceURL: URL?
    /*!
     The ordered list of targets applicable to this platform that will be used
     for navigation.
     */
    private(set) var targets = [Any]()
    /*! The fallback web URL to use if no targets are installed on this device. */
    private(set) var webURL: URL?
}