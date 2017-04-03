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

  Callback block for returning an array of FBSDKAccessToken instances (and possibly `NSNull` instances); or an error.
 */
typealias FBSDKTestUsersManagerRetrieveTestAccountTokensHandler = (_ tokens: [Any], _ error: Error?) -> Void
/**

  Callback block for removing a test user.
 */
typealias FBSDKTestUsersManagerRemoveTestAccountHandler = (_ error: Error?) -> Void
/**
  Provides methods for managing test accounts for testing Facebook integration.


 Facebook allows developers to create test accounts for testing their applications'
 Facebook integration (see https://developers.facebook.com/docs/test_users/). This class
 simplifies use of these accounts for writing tests. It is not designed for use in
 production application code.

 This class will make Graph API calls on behalf of your app to manage test accounts and requires
 an app id and app secret. You will typically use this class to write unit or integration tests.
 Make sure you NEVER include your app secret in your production app.
 */
class FBSDKTestUsersManager: NSObject {
    /**
      construct or return the shared instance
     - Parameter appID: the Facebook app id
     - Parameter appSecret: the Facebook app secret
     */
    class func sharedInstance(forAppID appID: String, appSecret: String) -> FBSDKTestUsersManager {
    }
    /**
      retrieve FBSDKAccessToken instances for test accounts with the specific permissions.
     - Parameter arraysOfPermissions: an array of permissions sets, such as @[ [NSSet setWithObject:@"email"], [NSSet setWithObject:@"user_birthday"]]
     if you needed two test accounts with email and birthday permissions, respectively. You can pass in empty nested sets
     if you need two arbitrary test accounts. For convenience, passing nil is treated as @[ [NSSet set] ]
     for fetching a single test user.
     - Parameter createIfNotFound: if YES, new test accounts are created if no test accounts existed that fit the permissions
     requirement
     - Parameter handler: the callback to invoke which will return an array of `FBAccessTokenData` instances or an `NSError`.
     If param `createIfNotFound` is NO, the array may contain `[NSNull null]` instances.
    
    
     If you are requesting test accounts with differing number of permissions, try to order
     `arrayOfPermissionsArrays` so that the most number of permissions come first to minimize creation of new
     test accounts.
     */

    func requestTestAccountTokens(withArraysOfPermissions arraysOfPermissions: [Any], createIfNotFound: Bool, completionHandler handler: FBSDKTestUsersManagerRetrieveTestAccountTokensHandler) {
    }
    /**
      add a test account with the specified permissions
     - Parameter permissions: the set of permissions, e.g., [NSSet setWithObjects:@"email", @"user_friends"]
     - Parameter handler: the callback handler
     */

    func addTestAccount(withPermissions permissions: Set<AnyHashable>, completionHandler handler: FBSDKTestUsersManagerRetrieveTestAccountTokensHandler) {
    }
    /**
      remove a test account for the given user id
     - Parameter userId: the user id
     - Parameter handler: the callback handler
     */

    func removeTestAccount(_ userId: String, completionHandler handler: FBSDKTestUsersManagerRemoveTestAccountHandler) {
    }
    /**
      Make two test users friends with each other.
     - Parameter first: the token of the first user
     - Parameter second: the token of the second user
     - Parameter callback: the callback handler
     */

    func makeFriends(withFirst first: FBSDKAccessToken, second: FBSDKAccessToken, callback: @escaping (_: Error) -> Void) {
    }
}