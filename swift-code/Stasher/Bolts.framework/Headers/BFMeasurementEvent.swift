//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
/*
 *  Copyright (c) 2014, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */
import Foundation
/*! The name of the notification posted by BFMeasurementEvent */
let BFMeasurementEventNotificationName: FOUNDATION_EXPORT NSString?
/*! Defines keys in the userInfo object for the notification named BFMeasurementEventNotificationName */
/*! The string field for the name of the event */
let BFMeasurementEventNameKey: FOUNDATION_EXPORT NSString?
/*! The dictionary field for the arguments of the event */
let BFMeasurementEventArgsKey: FOUNDATION_EXPORT NSString?
/*! Bolts Events raised by BFMeasurementEvent for Applink */
/*!
 The name of the event posted when [BFURL URLWithURL:] is called successfully. This represents the successful parsing of an app link URL.
 */
let BFAppLinkParseEventName: FOUNDATION_EXPORT NSString?
/*!
 The name of the event posted when [BFURL URLWithInboundURL:] is called successfully.
 This represents parsing an inbound app link URL from a different application
 */
let BFAppLinkNavigateInEventName: FOUNDATION_EXPORT NSString?
/*! The event raised when the user navigates from your app to other apps */
let BFAppLinkNavigateOutEventName: FOUNDATION_EXPORT NSString?
/*!
 The event raised when the user navigates out from your app and back to the referrer app.
 e.g when the user leaves your app after tapping the back-to-referrer navigation bar
 */
let BFAppLinkNavigateBackToReferrerEventName: FOUNDATION_EXPORT NSString?
class BFMeasurementEvent: NSObject {
}