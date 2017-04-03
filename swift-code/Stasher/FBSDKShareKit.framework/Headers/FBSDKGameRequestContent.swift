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
import FBSDKCoreKit
/**
 NS_ENUM(NSUInteger, FBSDKGameRequestActionType)
  Additional context about the nature of the request.
 */
enum FBSDKGameRequestActionType : Int {
    /** No action type */
    case none = 0
    /** Send action type: The user is sending an object to the friends. */
    case send
    /** Ask For action type: The user is asking for an object from friends. */
    case askFor
    /** Turn action type: It is the turn of the friends to play against the user in a match. (no object) */
    case turn
}

/**
 NS_ENUM(NSUInteger, FBSDKGameRequestFilters)
  Filter for who can be displayed in the multi-friend selector.
 */
enum FBSDKGameRequestFilter : Int {
    /** No filter, all friends can be displayed. */
    case none = 0
    /** Friends using the app can be displayed. */
    case appUsers
    /** Friends not using the app can be displayed. */
    case appNonUsers
}

/**
  A model for a game request.
 */
class FBSDKGameRequestContent: NSObject, FBSDKCopying, NSSecureCoding {
    /**
      Used when defining additional context about the nature of the request.
    
     The parameter 'objectID' is required if the action type is either
     'FBSDKGameRequestSendActionType' or 'FBSDKGameRequestAskForActionType'.
    
    - SeeAlso:objectID
     */
    var actionType = FBSDKGameRequestActionType(rawValue: 0)
    /**
      Compares the receiver to another game request content.
     - Parameter content: The other content
     - Returns: YES if the receiver's values are equal to the other content's values; otherwise NO
     */

    func isEqual(to content: FBSDKGameRequestContent) -> Bool {
    }
    /**
      Additional freeform data you may pass for tracking. This will be stored as part of
     the request objects created. The maximum length is 255 characters.
     */
    var data: String = ""
    /**
      This controls the set of friends someone sees if a multi-friend selector is shown.
     It is FBSDKGameRequestNoFilter by default, meaning that all friends can be shown.
     If specify as FBSDKGameRequestAppUsersFilter, only friends who use the app will be shown.
     On the other hands, use FBSDKGameRequestAppNonUsersFilter to filter only friends who do not use the app.
    
     The parameter name is preserved to be consistent with the counter part on desktop.
     */
    var filters = FBSDKGameRequestFilter(rawValue: 0)
    /**
      A plain-text message to be sent as part of the request. This text will surface in the App Center view
     of the request, but not on the notification jewel. Required parameter.
     */
    var message: String = ""
    /**
      The Open Graph object ID of the object being sent.
    
    - SeeAlso:actionType
     */
    var objectID: String = ""
    /**
      An array of user IDs, usernames or invite tokens (NSString) of people to send request.
    
     These may or may not be a friend of the sender. If this is specified by the app,
     the sender will not have a choice of recipients. If not, the sender will see a multi-friend selector
    
     This is equivalent to the "to" parameter when using the web game request dialog.
     */
    var recipients = [Any]()
    /**
      An array of user IDs that will be included in the dialog as the first suggested friends.
     Cannot be used together with filters.
    
     This is equivalent to the "suggestions" parameter when using the web game request dialog.
    */
    var recipientSuggestions = [Any]()
    /**
    
    - Warning:Use `recipientSuggestions` instead.
    */
    var suggestions = [Any]()
}
/**
  The title for the dialog.
 */

var title: String = ""