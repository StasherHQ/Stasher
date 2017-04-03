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
 Provides a set of utilities for working with NSURLs, such as parsing of query parameters
 and handling for App Link requests.
 */
class BFURL: NSObject {
    /*!
     Creates a link target from a raw URL.
     On success, this posts the BFAppLinkParseEventName measurement event. If you are constructing the BFURL within your application delegate's
     application:openURL:sourceApplication:annotation:, you should instead use URLWithInboundURL:sourceApplication:
     to support better BFMeasurementEvent notifications
     @param url The instance of `NSURL` to create BFURL from.
     */
    convenience init(url: URL) {
    }
    /*!
     Creates a link target from a raw URL received from an external application. This is typically called from the app delegate's
     application:openURL:sourceApplication:annotation: and will post the BFAppLinkNavigateInEventName measurement event.
     @param url The instance of `NSURL` to create BFURL from.
     @param sourceApplication the bundle ID of the app that is requesting your app to open the URL. The same sourceApplication in application:openURL:sourceApplication:annotation:
     */

    convenience init(inboundURL url: URL, sourceApplication: String) {
    }
    /*!
     Gets the target URL.  If the link is an App Link, this is the target of the App Link.
     Otherwise, it is the url that created the target.
     */
    private(set) var targetURL: URL?
    /*!
     Gets the query parameters for the target, parsed into an NSDictionary.
     */
    private(set) var targetQueryParameters = [AnyHashable: Any]()
    /*!
     If this link target is an App Link, this is the data found in al_applink_data.
     Otherwise, it is nil.
     */
    private(set) var appLinkData = [AnyHashable: Any]()
    /*!
     If this link target is an App Link, this is the data found in extras.
     */
    private(set) var appLinkExtras = [AnyHashable: Any]()
    /*!
     The App Link indicating how to navigate back to the referer app, if any.
     */
    private(set) var appLinkReferer: BFAppLink?
    /*!
     The URL that was used to create this BFURL.
     */
    private(set) var inputURL: URL?
    /*!
     The query parameters of the inputURL, parsed into an NSDictionary.
     */
    private(set) var inputQueryParameters = [AnyHashable: Any]()
}