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
  Protocol defining operations on open graph actions and objects.

 The property keys MUST have namespaces specified on them, such as `og:image`.
 */
protocol FBSDKShareOpenGraphValueContaining: NSObjectProtocol, NSSecureCoding {
    /**
      Gets an NSArray out of the receiver.
     - Parameter key: The key for the value
     - Returns: The NSArray value or nil
     */
    func array(forKey key: String) -> [Any]
    /**
      Applies a given block object to the entries of the receiver.
     - Parameter block: A block object to operate on entries in the receiver
     */

    func enumerateKeysAndObjects(usingBlock block: @escaping (_ key: String, _ object: Any, _ stop: Bool) -> Void)
    /**
      Returns an enumerator object that lets you access each key in the receiver.
     - Returns: An enumerator object that lets you access each key in the receiver
     */

    func keyEnumerator() -> NSEnumerator
    /**
      Gets an NSNumber out of the receiver.
     - Parameter key: The key for the value
     - Returns: The NSNumber value or nil
     */

    func number(forKey key: String) -> NSNumber
    /**
      Returns an enumerator object that lets you access each value in the receiver.
     - Returns: An enumerator object that lets you access each value in the receiver
     */

    func objectEnumerator() -> NSEnumerator
    /**
      Gets an FBSDKShareOpenGraphObject out of the receiver.
     - Parameter key: The key for the value
     - Returns: The FBSDKShareOpenGraphObject value or nil
     */

    func object(forKey key: String) -> FBSDKShareOpenGraphObject
    /**
      Enables subscript access to the values in the receiver.
     - Parameter key: The key for the value
     - Returns: The value
     */

    func object(forKeyedSubscript key: String) -> Any
    /**
      Parses properties out of a dictionary into the receiver.
     - Parameter properties: The properties to parse.
     */

    func parseProperties(_ properties: [AnyHashable: Any])
    /**
      Gets an FBSDKSharePhoto out of the receiver.
     - Parameter key: The key for the value
     - Returns: The FBSDKSharePhoto value or nil
     */

    func photo(forKey key: String) -> FBSDKSharePhoto
    /**
      Removes a value from the receiver for the specified key.
     - Parameter key: The key for the value
     */

    func removeValueForKey(_ key: String)
    /**
      Sets an NSArray on the receiver.
    
     This method will throw if the array contains any values that is not an NSNumber, NSString, NSURL,
     FBSDKSharePhoto or FBSDKShareOpenGraphObject.
     - Parameter array: The NSArray value
     - Parameter key: The key for the value
     */

    func set(_ array: [Any], forKey key: String)
    /**
      Sets an NSNumber on the receiver.
     - Parameter number: The NSNumber value
     - Parameter key: The key for the value
     */

    func setNumber(_ number: NSNumber, forKey key: String)
    /**
      Sets an FBSDKShareOpenGraphObject on the receiver.
     - Parameter object: The FBSDKShareOpenGraphObject value
     - Parameter key: The key for the value
     */

    func setObject(_ object: FBSDKShareOpenGraphObject, forKey key: String)
    /**
      Sets an FBSDKSharePhoto on the receiver.
     - Parameter photo: The FBSDKSharePhoto value
     - Parameter key: The key for the value
     */

    func setPhoto(_ photo: FBSDKSharePhoto, forKey key: String)
    /**
      Sets an NSString on the receiver.
     - Parameter string: The NSString value
     - Parameter key: The key for the value
     */

    func set(_ string: String, forKey key: String)
    /**
      Sets an NSURL on the receiver.
     - Parameter URL: The NSURL value
     - Parameter key: The key for the value
     */

    func set(_ URL: URL, forKey key: String)
    /**
      Gets an NSString out of the receiver.
     - Parameter key: The key for the value
     - Returns: The NSString value or nil
     */

    func string(forKey key: String) -> String
    /**
      Gets an NSURL out of the receiver.
     - Parameter key: The key for the value
     - Returns: The NSURL value or nil
     */

    func url(forKey key: String) -> URL
}
/**
  A base class to container Open Graph values.
 */
class FBSDKShareOpenGraphValueContainer: NSObject, FBSDKShareOpenGraphValueContaining {
}