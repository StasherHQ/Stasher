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
import UIKit
import FBSDKCoreKit
/*
 * Constants defining logging behavior.  Use with <[FBSDKSettings setLoggingBehavior]>.
 */
/** Include access token in logging. */
let FBSDKLoggingBehaviorAccessTokens: String = ""
/** Log performance characteristics */
let FBSDKLoggingBehaviorPerformanceCharacteristics: String = ""
/** Log FBSDKAppEvents interactions */
let FBSDKLoggingBehaviorAppEvents: String = ""
/** Log Informational occurrences */
let FBSDKLoggingBehaviorInformational: String = ""
/** Log cache errors. */
let FBSDKLoggingBehaviorCacheErrors: String = ""
/** Log errors from SDK UI controls */
let FBSDKLoggingBehaviorUIControlErrors: String = ""
/** Log debug warnings from API response, i.e. when friends fields requested, but user_friends permission isn't granted. */
let FBSDKLoggingBehaviorGraphAPIDebugWarning: String = ""
/** Log warnings from API response, i.e. when requested feature will be deprecated in next version of API.
 Info is the lowest level of severity, using it will result in logging all previously mentioned levels.
 */
let FBSDKLoggingBehaviorGraphAPIDebugInfo: String = ""
/** Log errors from SDK network requests */
let FBSDKLoggingBehaviorNetworkRequests: String = ""
/** Log errors likely to be preventable by the developer. This is in the default set of enabled logging behaviors. */
let FBSDKLoggingBehaviorDeveloperErrors: String = ""
class FBSDKSettings: NSObject {
    /**
      Get the Facebook App ID used by the SDK.
    
     If not explicitly set, the default will be read from the application's plist (FacebookAppID).
     */
    class func appID() -> String {
    }
    /**
      Set the Facebook App ID to be used by the SDK.
     - Parameter appID: The Facebook App ID to be used by the SDK.
     */

    class func setAppID(_ appID: String) {
    }
    /**
      Get the default url scheme suffix used for sessions.
    
     If not explicitly set, the default will be read from the application's plist (FacebookUrlSchemeSuffix).
     */

    class func appURLSchemeSuffix() -> String {
    }
    /**
      Set the app url scheme suffix used by the SDK.
     - Parameter appURLSchemeSuffix: The url scheme suffix to be used by the SDK.
     */

    class func setAppURLSchemeSuffix(_ appURLSchemeSuffix: String) {
    }
    /**
      Retrieve the Client Token that has been set via [FBSDKSettings setClientToken].
    
     If not explicitly set, the default will be read from the application's plist (FacebookClientToken).
     */

    class func clientToken() -> String {
    }
    /**
      Sets the Client Token for the Facebook App.
    
     This is needed for certain API calls when made anonymously, without a user-based access token.
     - Parameter clientToken: The Facebook App's "client token", which, for a given appid can be found in the Security
     section of the Advanced tab of the Facebook App settings found at <https://developers.facebook.com/apps/[your-app-id]>
     */

    class func setClientToken(_ clientToken: String) {
    }
    /**
      A convenient way to toggle error recovery for all FBSDKGraphRequest instances created after this is set.
     - Parameter disableGraphErrorRecovery: YES or NO.
     */

    class func setGraphErrorRecoveryDisabled(_ disableGraphErrorRecovery: Bool) {
    }
    /**
      Get the Facebook Display Name used by the SDK.
    
     If not explicitly set, the default will be read from the application's plist (FacebookDisplayName).
     */

    class func displayName() -> String {
    }
    /**
      Set the default Facebook Display Name to be used by the SDK.
    
      This should match the Display Name that has been set for the app with the corresponding Facebook App ID,
     in the Facebook App Dashboard.
     - Parameter displayName: The Facebook Display Name to be used by the SDK.
     */

    class func setDisplayName(_ displayName: String) {
    }
    /**
      Get the Facebook domain part.
    
     If not explicitly set, the default will be read from the application's plist (FacebookDomainPart).
     */

    class func facebookDomainPart() -> String {
    }
    /**
      Set the subpart of the Facebook domain.
    
     This can be used to change the Facebook domain (e.g. @"beta") so that requests will be sent to
     graph.beta.facebook.com
     - Parameter facebookDomainPart: The domain part to be inserted into facebook.com.
     */

    class func setFacebookDomainPart(_ facebookDomainPart: String) {
    }
    /**
      The quality of JPEG images sent to Facebook from the SDK.
    
     If not explicitly set, the default is 0.9.
    
    - See:[UIImageJPEGRepresentation](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIKitFunctionReference/#//apple_ref/c/func/UIImageJPEGRepresentation) */

    class func jpegCompressionQuality() -> CGFloat {
    }
    /**
      Set the quality of JPEG images sent to Facebook from the SDK.
     - Parameter JPEGCompressionQuality: The quality for JPEG images, expressed as a value from 0.0 to 1.0.
    
    - See:[UIImageJPEGRepresentation](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIKitFunctionReference/#//apple_ref/c/func/UIImageJPEGRepresentation) */

    class func setJPEGCompressionQuality(_ JPEGCompressionQuality: CGFloat) {
    }
    /**
      Flag which controls the auto logging of basic app events, such as activateApp and deactivateApp.
     If not explicitly set, the default is 1 - true
     */

    class func autoLogAppEventsEnabled() -> NSNumber {
    }
    /**
     Set the flag which controls the auto logging of basic app events, such as activateApp and deactivateApp.
     - Parameter AutoLogAppEventsEnabled: Flag value, expressed as a value from 0 - false or 1 - true.
     */

    class func setAutoLogAppEventsEnabled(_ AutoLogAppEventsEnabled: NSNumber) {
    }
    /**
      Gets whether data such as that generated through FBSDKAppEvents and sent to Facebook should be restricted from being used for other than analytics and conversions.  Defaults to NO.  This value is stored on the device and persists across app launches.
     */

    class func limitEventAndDataUsage() -> Bool {
    }
    /**
      Sets whether data such as that generated through FBSDKAppEvents and sent to Facebook should be restricted from being used for other than analytics and conversions.  Defaults to NO.  This value is stored on the device and persists across app launches.
    
     - Parameter limitEventAndDataUsage:   The desired value.
     */

    class func setLimitEventAndDataUsage(_ limitEventAndDataUsage: Bool) {
    }
    /**
      Retrieve the current iOS SDK version.
     */

    class func sdkVersion() -> String {
    }
    /**
      Retrieve the current Facebook SDK logging behavior.
     */

    class func loggingBehavior() -> Set<AnyHashable> {
    }
    /**
      Set the current Facebook SDK logging behavior.  This should consist of strings defined as
     constants with FBSDKLoggingBehavior*.
    
     - Parameter loggingBehavior: A set of strings indicating what information should be logged.  If nil is provided, the logging
     behavior is reset to the default set of enabled behaviors.  Set to an empty set in order to disable all logging.
    
    
     You can also define this via an array in your app plist with key "FacebookLoggingBehavior" or add and remove individual values via enableLoggingBehavior: or disableLogginBehavior:
     */

    class func setLoggingBehavior(_ loggingBehavior: Set<AnyHashable>) {
    }
    /**
      Enable a particular Facebook SDK logging behavior.
    
     - Parameter loggingBehavior: The LoggingBehavior to enable. This should be a string defined as a constant with FBSDKLoggingBehavior*.
     */

    class func enableLoggingBehavior(_ loggingBehavior: String) {
    }
    /**
      Disable a particular Facebook SDK logging behavior.
    
     - Parameter loggingBehavior: The LoggingBehavior to disable. This should be a string defined as a constant with FBSDKLoggingBehavior*.
     */

    class func disableLoggingBehavior(_ loggingBehavior: String) {
    }
    /**
      Set the user defaults key used by legacy token caches.
    
     - Parameter tokenInformationKeyName: the key used by legacy token caches.
    
    
     Use this only if you customized FBSessionTokenCachingStrategy in v3.x of
      the Facebook SDK for iOS.
    */

    class func setLegacyUserDefaultTokenInformationKeyName(_ tokenInformationKeyName: String) {
    }
    /**
      Get the user defaults key used by legacy token caches.
    */

    class func legacyUserDefaultTokenInformationKeyName() -> String {
    }
    /**
      Overrides the default Graph API version to use with `FBSDKGraphRequests`. This overrides `FBSDK_TARGET_PLATFORM_VERSION`.
    
     The string should be of the form `@"v2.7"`.
    */

    class func setGraphAPIVersion(_ version: String) {
    }
    /**
      Returns the default Graph API version. Defaults to `FBSDK_TARGET_PLATFORM_VERSION`
    */

    class func graphAPIVersion() -> String {
    }
}