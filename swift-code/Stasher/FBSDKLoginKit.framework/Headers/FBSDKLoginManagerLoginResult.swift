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

/**
  Describes the result of a login attempt.
 */
class FBSDKLoginManagerLoginResult: NSObject {
    /**
      the access token.
     */
    var token: FBSDKAccessToken?
    /**
      whether the login was cancelled by the user.
     */
    private(set) var isCancelled: Bool = false
    /**
      the set of permissions granted by the user in the associated request.
    
     inspect the token's permissions set for a complete list.
     */
    var grantedPermissions = Set<AnyHashable>()
    /**
      the set of permissions declined by the user in the associated request.
    
     inspect the token's permissions set for a complete list.
     */
    var declinedPermissions = Set<AnyHashable>()
    /**
      Initializes a new instance.
     - Parameter token: the access token
     - Parameter isCancelled: whether the login was cancelled by the user
     - Parameter grantedPermissions: the set of granted permissions
     - Parameter declinedPermissions: the set of declined permissions
     */

    required init(token: FBSDKAccessToken, isCancelled: Bool, grantedPermissions: Set<AnyHashable>, declinedPermissions: Set<AnyHashable>) {
    }
}