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
 The result of calling navigate on a BFAppLinkNavigation
 */
enum BFAppLinkNavigationType : Int {
    /*! Indicates that the navigation failed and no app was opened */
    case failure
    /*! Indicates that the navigation succeeded by opening the URL in the browser */
    case browser
    /*! Indicates that the navigation succeeded by opening the URL in an app on the device */
    case app
}

/*!
 Represents a pending request to navigate to an App Link. Most developers will
 simply use navigateToURLInBackground: to open a URL, but developers can build
 custom requests with additional navigation and app data attached to them by
 creating BFAppLinkNavigations themselves.
 */
class BFAppLinkNavigation: NSObject {
    /*!
     The extras for the AppLinkNavigation. This will generally contain application-specific
     data that should be passed along with the request, such as advertiser or affiliate IDs or
     other such metadata relevant on this device.
     */
    private(set) var extras = [AnyHashable: Any]()
    /*!
     The al_applink_data for the AppLinkNavigation. This will generally contain data common to
     navigation attempts such as back-links, user agents, and other information that may be used
     in routing and handling an App Link request.
     */
    private(set) var appLinkData = [AnyHashable: Any]()
    /*! The AppLink to navigate to */
    private(set) var appLink: BFAppLink?
    /*! Creates an AppLinkNavigation with the given link, extras, and App Link data */

    convenience init(appLink: BFAppLink, extras: [AnyHashable: Any], appLinkData: [AnyHashable: Any]) {
    }
    /*!
     Creates an NSDictionary with the correct format for iOS callback URLs,
     to be used as 'appLinkData' argument in the call to navigationWithAppLink:extras:appLinkData:
     */

    class func callbackAppLinkDataForApp(withName appName: String, url: String) -> [AnyHashable: Any] {
    }
    /*! Performs the navigation */

    func navigate(_ error: Error?) -> BFAppLinkNavigationType {
    }
    /*! Returns a BFAppLink for the given URL */

    class func resolveAppLink(inBackground destination: URL) -> BFTask {
    }
    /*! Returns a BFAppLink for the given URL using the given App Link resolution strategy */

    class func resolveAppLink(inBackground destination: URL, resolver: BFAppLinkResolving) -> BFTask {
    }
    /*! Navigates to a BFAppLink and returns whether it opened in-app or in-browser */

    class func navigate(to link: BFAppLink, error: Error?) -> BFAppLinkNavigationType {
    }
    /*!
     Returns a BFAppLinkNavigationType based on a BFAppLink.
     It's essentially a no-side-effect version of navigateToAppLink:error:,
     allowing apps to determine flow based on the link type (e.g. open an
     internal web view instead of going straight to the browser for regular links.)
     */

    class func navigationType(for link: BFAppLink) -> BFAppLinkNavigationType {
    }
    /*!
     Return navigation type for current instance.
     No-side-effect version of navigate:
     */

    func navigationType() -> BFAppLinkNavigationType {
    }
    /*! Navigates to a URL (an asynchronous action) and returns a BFNavigationType */

    class func navigateToURL(inBackground destination: URL) -> BFTask {
    }
    /*!
     Navigates to a URL (an asynchronous action) using the given App Link resolution
     strategy and returns a BFNavigationType
     */

    class func navigateToURL(inBackground destination: URL, resolver: BFAppLinkResolving) -> BFTask {
    }
    /*!
     Gets the default resolver to be used for App Link resolution. If the developer has not set one explicitly,
     a basic, built-in resolver will be used.
     */

    class func defaultResolver() -> BFAppLinkResolving {
    }
    /*!
     Sets the default resolver to be used for App Link resolution. Setting this to nil will revert the
     default resolver to the basic, built-in resolver provided by Bolts.
     */

    class func setDefaultResolver(_ resolver: BFAppLinkResolving) {
    }
}