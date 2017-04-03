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
/**
  Notification indicating that the `currentProfile` has changed.

 the userInfo dictionary of the notification will contain keys
 `FBSDKProfileChangeOldKey` and
 `FBSDKProfileChangeNewKey`.
 */
let FBSDKProfileDidChangeNotification: String = ""
/*   key in notification's userInfo object for getting the old profile.

 If there was no old profile, the key will not be present.
 */
let FBSDKProfileChangeOldKey: String = ""
/*   key in notification's userInfo object for getting the new profile.

 If there is no new profile, the key will not be present.
 */
let FBSDKProfileChangeNewKey: String = ""
/**
  Represents an immutable Facebook profile

 This class provides a global "currentProfile" instance to more easily
 add social context to your application. When the profile changes, a notification is
 posted so that you can update relevant parts of your UI and is persisted to NSUserDefaults.

 Typically, you will want to call `enableUpdatesOnAccessTokenChange:YES` so that
 it automatically observes changes to the `[FBSDKAccessToken currentAccessToken]`.

 You can use this class to build your own `FBSDKProfilePictureView` or in place of typical requests to "/me".
 */
class FBSDKProfile: NSObject, NSCopying, NSSecureCoding {
    /**
      initializes a new instance.
     - Parameter userID: the user ID
     - Parameter firstName: the user's first name
     - Parameter middleName: the user's middle name
     - Parameter lastName: the user's last name
     - Parameter name: the user's complete name
     - Parameter linkURL: the link for this profile
     - Parameter refreshDate: the optional date this profile was fetched. Defaults to [NSDate date].
     */
    required init(userID: String, firstName: String, middleName: String, lastName: String, name: String, linkURL: URL, refreshDate: Date) {
    }
    /**
      The user id
     */
    private(set) var userID: String = ""
    /**
      The user's first name
     */
    private(set) var firstName: String = ""
    /**
      The user's middle name
     */
    private(set) var middleName: String = ""
    /**
      The user's last name
     */
    private(set) var lastName: String = ""
    /**
      The user's complete name
     */
    private(set) var name: String = ""
    /**
      A URL to the user's profile.
    
     Consider using Bolts and `FBSDKAppLinkResolver` to resolve this
     to an app link to link directly to the user's profile in the Facebook app.
     */
    private(set) var linkURL: URL?
    /**
      The last time the profile data was fetched.
     */
    private(set) var refreshDate: Date?
    /**
      Gets the current FBSDKProfile instance.
     */

    class func current() -> FBSDKProfile {
    }
    /**
      Sets the current instance and posts the appropriate notification if the profile parameter is different
     than the receiver.
     - Parameter profile: the profile to set
    
     This persists the profile to NSUserDefaults.
     */

    class func setCurrent(_ profile: FBSDKProfile) {
    }
    /**
      Indicates if `currentProfile` will automatically observe `FBSDKAccessTokenDidChangeNotification` notifications
     - Parameter enable: YES is observing
    
     If observing, this class will issue a graph request for public profile data when the current token's userID
     differs from the current profile. You can observe `FBSDKProfileDidChangeNotification` for when the profile is updated.
    
     Note that if `[FBSDKAccessToken currentAccessToken]` is unset, the `currentProfile` instance remains. It's also possible
     for `currentProfile` to return nil until the data is fetched.
     */

    class func enableUpdates(onAccessTokenChange enable: Bool) {
    }
    /**
      Loads the current profile and passes it to the completion block.
     - Parameter completion: The block to be executed once the profile is loaded
    
     If the profile is already loaded, this method will call the completion block synchronously, otherwise it
     will begin a graph request to update `currentProfile` and then call the completion block when finished.
     */

    class func loadCurrentProfile(withCompletion completion: @escaping (_ profile: FBSDKProfile, _ error: Error?) -> Void) {
    }
    /**
      A convenience method for returning a complete `NSURL` for retrieving the user's profile image.
     - Parameter mode: The picture mode
     - Parameter size: The height and width. This will be rounded to integer precision.
     */

    func imageURL(for mode: FBSDKProfilePictureMode, size: CGSize) -> URL {
    }
    /**
      A convenience method for returning a Graph API path for retrieving the user's profile image.
    
    - Warning:use `imageURLForPictureMode:size:` instead
    
     You can pass this to a `FBSDKGraphRequest` instance to download the image.
     - Parameter mode: The picture mode
     - Parameter size: The height and width. This will be rounded to integer precision.
     */

    func imagePath(for mode: FBSDKProfilePictureMode, size: CGSize) -> String {
    }
}
/**
  Returns YES if the profile is equivalent to the receiver.
 - Parameter profile: the profile to compare to.
 */

func isEqual(to profile: FBSDKProfile) -> Bool {
}