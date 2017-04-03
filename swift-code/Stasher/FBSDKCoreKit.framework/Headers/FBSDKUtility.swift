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
  Class to contain common utility methods.
 */
class FBSDKUtility: NSObject {
    /**
      Parses a query string into a dictionary.
     - Parameter queryString: The query string value.
     - Returns: A dictionary with the key/value pairs.
     */
    class func dictionary(withQueryString queryString: String) -> [AnyHashable: Any] {
    }
    /**
      Constructs a query string from a dictionary.
     - Parameter dictionary: The dictionary with key/value pairs for the query string.
     - Parameter errorRef: If an error occurs, upon return contains an NSError object that describes the problem.
     - Returns: Query string representation of the parameters.
     */

    class func queryString(withDictionary dictionary: [AnyHashable: Any], error errorRef: Error?) -> String {
    }
    /**
      Decodes a value from an URL.
     - Parameter value: The value to decode.
     - Returns: The decoded value.
     */

    class func urlDecode(_ value: String) -> String {
    }
    /**
      Encodes a value for an URL.
     - Parameter value: The value to encode.
     - Returns: The encoded value.
     */

    class func urlEncode(_ value: String) -> String {
    }
}