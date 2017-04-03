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
import FBSDKShareKit

/**
  The common interface for components that initiate sharing.

- See:FBSDKShareDialog

- See:FBSDKMessageDialog

- See:FBSDKShareAPI
 */
protocol FBSDKSharing: NSObjectProtocol {
    /**
      The receiver's delegate or nil if it doesn't have a delegate.
     */
    weak var delegate: FBSDKSharingDelegate? { get set }
    /**
      The content to be shared.
     */
    var shareContent = FBSDKSharingContent() { get set }
    /**
      A Boolean value that indicates whether the receiver should fail if it finds an error with the share content.
    
     If NO, the sharer will still be displayed without the data that was mis-configured.  For example, an
     invalid placeID specified on the shareContent would produce a data error.
     */
    var isShouldFailOnDataError: Bool = false { get set }
    /**
      Validates the content on the receiver.
     - Parameter errorRef: If an error occurs, upon return contains an NSError object that describes the problem.
     - Returns: YES if the content is valid, otherwise NO.
     */

    func validate() throws
}
/**
  The common interface for dialogs that initiate sharing.
 */
protocol FBSDKSharingDialog: FBSDKSharing {
    /**
      A Boolean value that indicates whether the receiver can initiate a share.
    
     May return NO if the appropriate Facebook app is not installed and is required or an access token is
     required but not available.  This method does not validate the content on the receiver, so this can be checked before
     building up the content.
    
    - See:[FBSDKSharing validateWithError:]
     - Returns: YES if the receiver can share, otherwise NO.
     */
    func canShow() -> Bool
    /**
      Shows the dialog.
     - Returns: YES if the receiver was able to begin sharing, otherwise NO.
     */

    func show() -> Bool
}
/**
  A delegate for FBSDKSharing.

 The delegate is notified with the results of the sharer as long as the application has permissions to
 receive the information.  For example, if the person is not signed into the containing app, the sharer may not be able
 to distinguish between completion of a share and cancellation.
 */
protocol FBSDKSharingDelegate: NSObjectProtocol {
    /**
      Sent to the delegate when the share completes without error or cancellation.
     - Parameter sharer: The FBSDKSharing that completed.
     - Parameter results: The results from the sharer.  This may be nil or empty.
     */
    func sharer(_ sharer: FBSDKSharing, didCompleteWithResults results: [AnyHashable: Any])
    /**
      Sent to the delegate when the sharer encounters an error.
     - Parameter sharer: The FBSDKSharing that completed.
     - Parameter error: The error.
     */

    func sharer(_ sharer: FBSDKSharing, didFailWithError error: Error?)
    /**
      Sent to the delegate when the sharer is cancelled.
     - Parameter sharer: The FBSDKSharing that completed.
     */

    func sharerDidCancel(_ sharer: FBSDKSharing)
}