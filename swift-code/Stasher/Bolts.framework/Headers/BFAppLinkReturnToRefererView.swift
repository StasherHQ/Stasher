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

enum BFIncludeStatusBarInSize : Int {
    case never
    case ios7AndLater
    case always
}

/*!
 Protocol that a class can implement in order to be notified when the user has navigated back
 to the referer of an App Link.
 */
protocol BFAppLinkReturnToRefererViewDelegate: NSObjectProtocol {
    /*!
     Called when the user has tapped inside the close button.
     */
    func returnToRefererViewDidTap(insideCloseButton view: BFAppLinkReturnToRefererView)
    /*!
     Called when the user has tapped inside the App Link portion of the view.
     */

    func returnToRefererViewDidTap(insideLink view: BFAppLinkReturnToRefererView, link: BFAppLink)
}
/*!
 Provides a UIView that displays a button allowing users to navigate back to the
 application that launched the App Link currently being handled, if the App Link
 contained referer data. The user can also close the view by clicking a close button
 rather than navigating away. If the view is provided an App Link that does not contain
 referer data, it will have zero size and no UI will be displayed.
 */
class BFAppLinkReturnToRefererView: UIView {
    /*!
     The delegate that will be notified when the user navigates back to the referer.
     */
    weak var delegate: BFAppLinkReturnToRefererViewDelegate?
    /*!
     The color of the text label and close button.
     */
    var textColor: UIColor?
    var refererAppLink: BFAppLink?
    /*!
     Indicates whether to extend the size of the view to include the current status bar
     size, for use in scenarios where the view might extend under the status bar on iOS 7 and
     above; this property has no effect on earlier versions of iOS.
     */
    var includeStatusBarInSize = BFIncludeStatusBarInSize(rawValue: 0)
    /*!
     Indicates whether the user has closed the view by clicking the close button.
     */
    var isClosed: Bool = false
}