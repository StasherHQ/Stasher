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
#if __cplusplus
let FBSDK_EXTERN = "C"((visibility("default")))
#else
let FBSDK_EXTERN = extern __attribute__((visibility ("default")))
#endif
let FBSDK_STATIC_INLINE = inline
func FBSDK_NO_DESIGNATED_INITIALIZER() throws -> Any {
    throw NSException(name: NSInvalidArgumentException, reason: "unrecognized selector sent to instance \(self)", userInfo: nil)
}
func FBSDK_NOT_DESIGNATED_INITIALIZER(DESIGNATED_INITIALIZER: Any) throws -> Any {
    throw NSException(name: NSInvalidArgumentException, reason: "Please use the designated initializer [\(self) \(NSStringFromSelector(#selector(self.DESIGNATED_INITIALIZER)))]", userInfo: nil)
}
