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
import FBSDKShareKit
import FBSDKShareKit
/**
 NS_ENUM (NSUInteger, FBSDKLikeControlAuxiliaryPosition)

  Specifies the position of the auxiliary view relative to the like button.
 */
enum FBSDKLikeControlAuxiliaryPosition : Int {
    /** The auxiliary view is inline with the like button. */
    case inline
    /** The auxiliary view is above the like button. */
    case top
    /** The auxiliary view is below the like button. */
    case bottom
}

/**
  Converts an FBSDKLikeControlAuxiliaryPosition to an NSString.
 */
func NSStringFromFBSDKLikeControlAuxiliaryPosition(auxiliaryPosition: FBSDKLikeControlAuxiliaryPosition) -> String {
}

/**
 NS_ENUM(NSUInteger, FBSDKLikeControlHorizontalAlignment)

  Specifies the horizontal alignment for FBSDKLikeControlStyleStandard with
 FBSDKLikeControlAuxiliaryPositionTop or FBSDKLikeControlAuxiliaryPositionBottom.
 */
enum FBSDKLikeControlHorizontalAlignment : Int {
    /** The subviews are left aligned. */
    case left
    /** The subviews are center aligned. */
    case center
    /** The subviews are right aligned. */
    case right
}

/**
  Converts an FBSDKLikeControlHorizontalAlignment to an NSString.
 */
func NSStringFromFBSDKLikeControlHorizontalAlignment(horizontalAlignment: FBSDKLikeControlHorizontalAlignment) -> String {
}

/**
 NS_ENUM (NSUInteger, FBSDKLikeControlStyle)

  Specifies the style of a like control.
 */
enum FBSDKLikeControlStyle : Int {
    /** Displays the button and the social sentence. */
    case standard = 0
    /** Displays the button and a box that contains the like count. */
    case boxCount
}

/**
  Converts an FBSDKLikeControlStyle to an NSString.
 */
func NSStringFromFBSDKLikeControlStyle(style: FBSDKLikeControlStyle) -> String {
}

/**

  UI control to like an object in the Facebook graph.


 Taps on the like button within this control will invoke an API call to the Facebook app through a
 fast-app-switch that allows the user to like the object.  Upon return to the calling app, the view will update
 with the new state and send actions for the UIControlEventValueChanged event.
 */
class FBSDKLikeControl: UIControl, FBSDKLiking {
    /**
      The foreground color to use for the content of the receiver.
     */
    var foregroundColor: UIColor?
    /**
      The position for the auxiliary view for the receiver.
    
    
    - See:FBSDKLikeControlAuxiliaryPosition
     */
    var likeControlAuxiliaryPosition = FBSDKLikeControlAuxiliaryPosition(rawValue: 0)
    /**
      The text alignment of the social sentence.
    
    
     This value is only valid for FBSDKLikeControlStyleStandard with
     FBSDKLikeControlAuxiliaryPositionTop|Bottom.
     */
    var likeControlHorizontalAlignment = FBSDKLikeControlHorizontalAlignment(rawValue: 0)
    /**
      The style to use for the receiver.
    
    
    - See:FBSDKLikeControlStyle
     */
    var likeControlStyle = FBSDKLikeControlStyle(rawValue: 0)
    /**
      The preferred maximum width (in points) for autolayout.
    
    
     This property affects the size of the receiver when layout constraints are applied to it. During layout,
     if the text extends beyond the width specified by this property, the additional text is flowed to one or more new
     lines, thereby increasing the height of the receiver.
     */
    var preferredMaxLayoutWidth: CGFloat = 0.0
    /**
      If YES, a sound is played when the receiver is toggled.
    
     @default YES
     */
    var isSoundEnabled: Bool = false
}