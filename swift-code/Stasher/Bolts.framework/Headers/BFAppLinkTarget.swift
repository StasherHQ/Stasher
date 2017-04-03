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
 Represents a target defined in App Link metadata, consisting of at least
 a URL, and optionally an App Store ID and name.
 */
class BFAppLinkTarget: NSObject {
    /*! Creates a BFAppLinkTarget with the given app site and target URL. */
    convenience init(url: URL, appStoreId: String, appName: String) {
    }
    /*! The URL prefix for this app link target */
    private(set) var url: URL?
    /*! The app ID for the app store */
    private(set) var appStoreId: String = ""
    /*! The name of the app */
    private(set) var appName: String = ""
}