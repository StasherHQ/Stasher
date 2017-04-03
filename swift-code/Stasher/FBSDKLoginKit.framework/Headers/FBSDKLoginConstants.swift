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
  The error domain for all errors from FBSDKLoginKit

 Error codes from the SDK in the range 300-399 are reserved for this domain.
 */
let FBSDKLoginErrorDomain: String = ""
/**
 NS_ENUM(NSInteger, FBSDKLoginErrorCode)
  Error codes for FBSDKLoginErrorDomain.
 */
enum FBSDKLoginErrorCode : Int {
    /**
        Reserved.
       */
    case fbsdkLoginReservedErrorCode = 300
    /**
        The error code for unknown errors.
       */
    case fbsdkLoginUnknownErrorCode
    /**
        The user's password has changed and must log in again
      */
    case fbsdkLoginPasswordChangedErrorCode
    /**
        The user must log in to their account on www.facebook.com to restore access
      */
    case fbsdkLoginUserCheckpointedErrorCode
    /**
        Indicates a failure to request new permissions because the user has changed.
       */
    case fbsdkLoginUserMismatchErrorCode
    /**
        The user must confirm their account with Facebook before logging in
      */
    case fbsdkLoginUnconfirmedUserErrorCode
    /**
        The Accounts framework failed without returning an error, indicating the
       app's slider in the iOS Facebook Settings (device Settings -> Facebook -> App Name) has
       been disabled.
       */
    case fbsdkLoginSystemAccountAppDisabledErrorCode
    /**
        An error occurred related to Facebook system Account store
      */
    case fbsdkLoginSystemAccountUnavailableErrorCode
    /**
        The login response was missing a valid challenge string.
      */
    case fbsdkLoginBadChallengeString
}