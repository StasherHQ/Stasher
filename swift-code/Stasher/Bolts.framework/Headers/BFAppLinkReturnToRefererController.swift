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
import UIKit
import Bolts

/*!
 Protocol that a class can implement in order to be notified when the user has navigated back
 to the referer of an App Link.
 */
protocol BFAppLinkReturnToRefererControllerDelegate: NSObjectProtocol {
    /*! Called when the user has tapped to navigate, but before the navigation has been performed. */
    func return(_ controller: BFAppLinkReturnToRefererController, willNavigateTo appLink: BFAppLink)
    /*! Called after the navigation has been attempted, with an indication of whether the referer
     app link was successfully opened. */

    func return(_ controller: BFAppLinkReturnToRefererController, didNavigateTo url: BFAppLink, type: BFAppLinkNavigationType)
}
/*!
 A controller class that implements default behavior for a BFAppLinkReturnToRefererView, including
 the ability to display the view above the navigation bar for navigation-based apps.
 */
class BFAppLinkReturnToRefererController: NSObject, BFAppLinkReturnToRefererViewDelegate {
    /*!
     The delegate that will be notified when the user navigates back to the referer.
     */
    weak var delegate: BFAppLinkReturnToRefererControllerDelegate?
    /*!
     The BFAppLinkReturnToRefererView this controller is controlling.
     */
    var view: BFAppLinkReturnToRefererView?
    /*!
     Initializes a controller suitable for controlling a BFAppLinkReturnToRefererView that is to be displayed
     contained within another UIView (i.e., not displayed above the navigation bar).
     */

    override init() {
    }
    /*!
     Initializes a controller suitable for controlling a BFAppLinkReturnToRefererView that is to be displayed
     displayed above the navigation bar.
     */

    init(for navController: UINavigationController) {
    }
    /*!
     Removes the view entirely from the navigation controller it is currently displayed in.
     */

    func removeFromNavController() {
    }
    /*!
     Shows the BFAppLinkReturnToRefererView with the specified referer information. If nil or missing data,
     the view will not be displayed. */

    func showView(forRefererAppLink refererAppLink: BFAppLink) {
    }
    /*!
     Shows the BFAppLinkReturnToRefererView with referer information extracted from the specified URL.
     If nil or missing referer App Link data, the view will not be displayed. */

    func showView(forRefererURL url: URL) {
    }
    /*!
     Closes the view, possibly animating it.
     */

    func closeView(animated: Bool) {
    }
}