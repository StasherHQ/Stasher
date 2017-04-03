//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
// Copyright (c) 2014-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
import Foundation
import UIKit
import FBSDKShareKit

/**
  A dialog for sending App Invites.
 */
class FBSDKAppInviteDialog: NSObject {
    /**
      Convenience method to show a FBSDKAppInviteDialog
     - Parameter viewController: A UIViewController to present the dialog from.
     - Parameter content: The content for the app invite.
     - Parameter delegate: The receiver's delegate.
    */
    class func show(from viewController: UIViewController, with content: FBSDKAppInviteContent, delegate: FBSDKAppInviteDialogDelegate) -> FBSDKAppInviteDialog {
    }
    /**
    
    - Warning:use showFromViewController:withContent:delegate: instead
     */

    class func show(with content: FBSDKAppInviteContent, delegate: FBSDKAppInviteDialogDelegate) -> FBSDKAppInviteDialog {
    }
}
/**
  A UIViewController to present the dialog from.

 If not specified, the top most view controller will be automatically determined as best as possible.
 */

var fromViewController: UIViewController?
weak var delegate: FBSDKAppInviteDialogDelegate?
var content: FBSDKAppInviteContent?
/**
  A Boolean value that indicates whether the receiver can initiate an app invite.

 May return NO if the appropriate Facebook app is not installed and is required or an access token is
 required but not available.  This method does not validate the content on the receiver, so this can be checked before
 building up the content.

- See:validateWithError:
 - Returns: YES if the receiver can show the dialog, otherwise NO.
 */

func canShow() -> Bool {
    /**
      Begins the app invite from the receiver.
     - Returns: YES if the receiver was able to show the dialog, otherwise NO.
     */
    -Bool(show)
    /**
      Validates the content on the receiver.
     - Parameter errorRef: If an error occurs, upon return contains an NSError object that describes the problem.
     - Returns: YES if the content is valid, otherwise NO.
     */
    -(BOOL)
    /**
      A delegate for FBSDKAppInviteDialog.
    
     The delegate is notified with the results of the app invite as long as the application has permissions to
     receive the information.  For example, if the person is not signed into the containing app, the shower may not be able
     to distinguish between completion of an app invite and cancellation.
     */

    /**
      Sent to the delegate when the app invite completes without error.
     - Parameter appInviteDialog: The FBSDKAppInviteDialog that completed.
     - Parameter results: The results from the dialog.  This may be nil or empty.
     */
    -( as? Void)
    /**
      Sent to the delegate when the app invite encounters an error.
     - Parameter appInviteDialog: The FBSDKAppInviteDialog that completed.
     - Parameter error: The error.
     */
    -( as? Void)
}