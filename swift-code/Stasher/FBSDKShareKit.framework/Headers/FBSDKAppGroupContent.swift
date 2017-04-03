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
import FBSDKCoreKit
/**
 NS_ENUM(NSUInteger, FBSDKAppGroupPrivacy)
  Specifies the privacy of a group.
 */
enum FBSDKAppGroupPrivacy : Int {
    /** Anyone can see the group, who's in it and what members post. */
    case open = 0
    /** Anyone can see the group and who's in it, but only members can see posts. */
    case closed
}

/**
  Converts an FBSDKAppGroupPrivacy to an NSString.
 */
func NSStringFromFBSDKAppGroupPrivacy(privacy: FBSDKAppGroupPrivacy) -> String {
}

/**
  A model for creating an app group.
 */
class FBSDKAppGroupContent: NSObject, FBSDKCopying, NSSecureCoding {
    /**
      The description of the group.
     */
    var groupDescription: String = ""
    /**
      The name of the group.
     */
    var name: String = ""
    /**
      The privacy for the group.
     */
    var privacy = FBSDKAppGroupPrivacy(rawValue: 0)
    /**
      Compares the receiver to another app group content.
     - Parameter content: The other content
     - Returns: YES if the receiver's values are equal to the other content's values; otherwise NO
     */

    func isEqual(to content: FBSDKAppGroupContent) -> Bool {
    }
}