//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
/*
     File: Reachability.swift
 Abstract: Basic demonstration of how to use the SystemConfiguration Reachablity APIs.
  Version: 3.5
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 
 */
import Foundation
import SystemConfiguration
import netinet
enum NetworkStatus : Int {
    case notReachable = 0
    case reachableViaWiFi
    case reachableViaWWAN
}

var kReachabilityChangedNotification: String = ""
class Reachability: NSObject {
    /*!
     * Use to check the reachability of a given host name.
     */
    convenience init(hostName: String) {
        var returnValue: Reachability? = nil
        var reachability: SCNetworkReachability? = SCNetworkReachabilityCreateWithName(nil, hostName.utf8)
        if reachability != nil {
            returnValue = self.init()
            if returnValue != nil {
                returnValue?._reachabilityRef = reachability
                returnValue?._alwaysReturnLocalWiFiStatus = false
            }
        }
        return returnValue!
    }
    /*!
     * Use to check the reachability of a given IP address.
     */

    convenience init(address hostAddress: sockaddr_in) {
        var reachability: SCNetworkReachability?? = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (hostAddress as? sockaddr))
        var returnValue: Reachability? = nil
        if reachability != nil {
            returnValue = self.init()
            if returnValue != nil {
                returnValue?._reachabilityRef = reachability
                returnValue?._alwaysReturnLocalWiFiStatus = false
            }
        }
        return returnValue!
    }
    /*!
     * Checks whether the default route is available. Should be used by applications that do not connect to a particular host.
     */

    convenience init() {
struct sockaddr_in {
}

        var zeroAddress: sockaddr_in
        bzero(zeroAddress, MemoryLayout<zeroAddress>.size)
        zeroAddress.sin_len = MemoryLayout<zeroAddress>.size
        zeroAddress.sin_family = AF_INET
        return self.init(address: zeroAddress)
    }
    /*!
     * Checks whether a local WiFi connection is available.
     */

    convenience init() {
struct sockaddr_in {
}

        var localWifiAddress: sockaddr_in
        bzero(localWifiAddress, MemoryLayout<localWifiAddress>.size)
        localWifiAddress.sin_len = MemoryLayout<localWifiAddress>.size
        localWifiAddress.sin_family = AF_INET
        // IN_LINKLOCALNETNUM is defined in <netinet/in.h> as 169.254.0.0.
        localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM)
        var returnValue: Reachability? = self.init(address: localWifiAddress)
        if returnValue != nil {
            returnValue?._alwaysReturnLocalWiFiStatus = true
        }
        return returnValue!
    }
    /*!
     * Start listening for reachability notifications on the current run loop.
     */

    func startNotifier() -> Bool {
        var returnValue: Bool = false
        var context: SCNetworkReachabilityContext? = [0, ((self) as? Void), nil, nil, nil]
        if SCNetworkReachabilitySetCallback(_reachabilityRef, ReachabilityCallback, context) {
            if SCNetworkReachabilityScheduleWithRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode) {
                returnValue = true
            }
        }
        return returnValue
    }

    func stopNotifier() {
        if _reachabilityRef != nil {
            SCNetworkReachabilityUnscheduleFromRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode)
        }
    }

    func currentReachabilityStatus() -> NetworkStatus {
        assert(_reachabilityRef != nil, "currentNetworkStatus called with NULL SCNetworkReachabilityRef")
        var returnValue: NetworkStatus = .notReachable
        var flags: SCNetworkReachabilityFlags
        if SCNetworkReachabilityGetFlags(_reachabilityRef, flags) {
            if _alwaysReturnLocalWiFiStatus {
                returnValue = localWiFiStatus(for: flags)
            }
            else {
                returnValue = networkStatus(for: flags)
            }
        }
        return returnValue
    }
    /*!
     * WWAN may be available, but not active until a connection has been established. WiFi may require a connection for VPN on Demand.
     */

    func connectionRequired() -> Bool {
        assert(_reachabilityRef != nil, "connectionRequired called with NULL reachabilityRef")
        var flags: SCNetworkReachabilityFlags
        if SCNetworkReachabilityGetFlags(_reachabilityRef, flags) {
            return (flags & kSCNetworkReachabilityFlagsConnectionRequired)
        }
        return false
    }
    var alwaysReturnLocalWiFiStatus: Bool = false
    //default is NO
    var reachabilityRef: SCNetworkReachability? = nil


// MARK: - Start and stop notifier

    deinit {
        stopNotifier()
        if _reachabilityRef != nil {

        }
    }
// MARK: - Network Flag Handling

    func localWiFiStatus(for flags: SCNetworkReachabilityFlags) -> NetworkStatus {
        PrintReachabilityFlags(flags, "localWiFiStatusForFlags")
        var returnValue: NetworkStatus = .notReachable
        if (flags & kSCNetworkReachabilityFlagsReachable) && (flags & kSCNetworkReachabilityFlagsIsDirect) {
            returnValue = .reachableViaWiFi
        }
        return returnValue
    }

    func networkStatus(for flags: SCNetworkReachabilityFlags) -> NetworkStatus {
        PrintReachabilityFlags(flags, "networkStatusForFlags")
        if (flags & kSCNetworkReachabilityFlagsReachable) == 0 {
            // The target host is not reachable.
            return .notReachable
        }
        var returnValue: NetworkStatus = .notReachable
        if (flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0 {
            /*
                     If the target host is reachable and no connection is required then we'll assume (for now) that you're on Wi-Fi...
                     */
            returnValue = .reachableViaWiFi
        }
        if (((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0) || (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0) {
            /*
                     ... and the connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs...
                     */
            if (flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0 {
                /*
                             ... and no [user] intervention is needed...
                             */
                returnValue = .reachableViaWiFi
            }
        }
        if (flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN {
            /*
                     ... but WWAN connections are OK if the calling application is using the CFNetwork APIs.
                     */
            returnValue = .reachableViaWWAN
        }
        return returnValue
    }
}
import arpa
import ifaddrs
import netdb
import sys
import CoreFoundation
var kReachabilityChangedNotification: String = "kNetworkReachabilityChangedNotification"
// MARK: - Supporting functions
let kShouldPrintReachabilityFlags = 0
func PrintReachabilityFlags(flags: SCNetworkReachabilityFlags, comment: CChar) {
#if kShouldPrintReachabilityFlags
    print("Reachability Flag Status: \((flags & kSCNetworkReachabilityFlagsIsWWAN) ? "W" : "-")\((flags & kSCNetworkReachabilityFlagsReachable) ? "R" : "-") \((flags & kSCNetworkReachabilityFlagsTransientConnection) ? "t" : "-")\((flags & kSCNetworkReachabilityFlagsConnectionRequired) ? "c" : "-")\((flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) ? "C" : "-")\((flags & kSCNetworkReachabilityFlagsInterventionRequired) ? "i" : "-")\((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) ? "D" : "-")\((flags & kSCNetworkReachabilityFlagsIsLocalAddress) ? "l" : "-")\((flags & kSCNetworkReachabilityFlagsIsDirect) ? "d" : "-") \(comment)\n")
#endif
}
func ReachabilityCallback(target: SCNetworkReachability?, flags: SCNetworkReachabilityFlags, info: Void) {
//unused (target, flags)
    assert(info != nil, "info was NULL in ReachabilityCallback")
    assert(((info as? NSObject)? is Reachability), "info was wrong class in ReachabilityCallback")
    var noteObject: Reachability? = (info as? Reachability)
    // Post a notification to notify the client that the network reachability changed.
    NotificationCenter.default.post(name: kReachabilityChangedNotification, object: noteObject)
}
// MARK: - Reachability implementation