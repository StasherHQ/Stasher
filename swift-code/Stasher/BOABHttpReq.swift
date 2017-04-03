//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  BOABHttpReq.swift
//  BOABHTTPReq
//
//  Created by bhushan on 06/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import Foundation
protocol BOABHttpReqDelegate: NSObjectProtocol {
    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection)

    func boabHttpReqFailedWithError(_ error: Error?)
}
class BOABHttpReq: NSObject {

    var conn: BOABURLConnection?
    var data: Data?
    var block: ((_: Any, _: Data, _: Error) -> Void)? = nil
    var statusBlock: ((_: String) -> Void)? = nil

    weak var delegate: BOABHttpReqDelegate?
    var userInfo = [AnyHashable: Any]()
    var activityIndicatorView: STActivityIndicatorView?
    var noInternetView: STNoInternetView?

    func initBoabReq(withDelegate del: Any, shouldShowActivityIndicatorView showActivityIndicator: Bool) -> Any {
        super.init()
        
        data = Data.data
        delegate = del
        if showActivityIndicator {
            var vc: UIViewController? = (del as? UIViewController)
            activityIndicatorView = STActivityIndicatorView(defaultSizeandSuperView: vc?.view)
            vc?.view?.userInteractionEnabled = true
        }
    
    }

    func sendAsyncGetRequest(_ url: String, params: [AnyHashable: Any], block: @escaping (_: Any, _: Data, _: Error) -> Void, statusBlock: @escaping (_: String) -> Void) {
        if reachable {
            userInfo = params
            activityIndicatorView?.startAnimation()
            initializeRequest(block, statusBlock: statusBlock)
            var paramsAsString: String = getUrlEncodedParams(params)
            sendStatusUpdate("PARAMS - \(paramsAsString)")
            url = "\(url)?\(paramsAsString)"
            sendStatusUpdate("URL - \(url)")
            var req = BOABMutableURLRequest(url: URL(string: url))
            connect(req)
        }
    }

    func sendAsyncPostRequest(_ url: String, params: [AnyHashable: Any], json: Bool, block: @escaping (_: Any, _: Data, _: Error) -> Void, statusBlock: @escaping (_: String) -> Void) {
        if reachable {
            userInfo = params
            activityIndicatorView?.startAnimation()
            initializeRequest(block, statusBlock: statusBlock)
            var req = BOABMutableURLRequest(url: URL(string: url))
            setContentType(req, json: json)
            req.HTTPMethod = "POST"
            var muParamsDict: [AnyHashable: Any] = params
            muParamsDict[kParamKeyAccessToken] = STUserIdentity.sharedInstance().accessToken()
            var pairs = [Any]() /* capacity: 0 */
            for key: String in muParamsDict {
                pairs.append("\(key)=\(muParamsDict[key])")
            }
                /* We finally join the pairs of our array
                         using the '&' */
            var postString: String = (pairs as NSArray).componentsJoined(byString: "&")
            //NSLog(@"The POST body - %@",postString);
            req.setValue("\(UInt(postString.characters.count ?? 0))", forHTTPHeaderField: "Content-length")
            req.HTTPBody = postString.data(using: String.Encoding.utf8)
            connect(req)
        }
    }

    func sendAsyncPostRequest(_ url: String, params: [AnyHashable: Any], json: Bool) {
        if reachable {
            activityIndicatorView?.startAnimation()
            var req = BOABMutableURLRequest(url: URL(string: url))
            setContentType(req, json: json)
            req.HTTPMethod = "POST"
            userInfo = params
            var muParamsDict: [AnyHashable: Any] = params
            muParamsDict["accesstoken"] = STUserIdentity.sharedInstance().accessToken()
            var pairs = [Any]() /* capacity: 0 */
            for key: String in muParamsDict {
                pairs.append("\(key)=\(muParamsDict[key])")
            }
                /* We finally join the pairs of our array
                         using the '&' */
            var postString: String = (pairs as NSArray).componentsJoined(byString: "&")
            //NSLog(@"The POST body - %@",postString);
            req.setValue("\(UInt(postString.characters.count ?? 0))", forHTTPHeaderField: "Content-length")
            req.HTTPBody = postString.data(using: String.Encoding.utf8)
            req.userInfo = [
                "url" : url,
                "request" : req,
                "params" : muParamsDict
            ]

            connect(req)
            print("Request URL = \(req.url) \n Request body \(String(data: req.httpBody, encoding: String.Encoding.utf8))")
        }
        else {
            UIAlertView.show(withTitle: "", message: "Stasher has some network issues! Try Later.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {

                }
            })
        }
    }

    func sendAsyncGetRequest(_ url: String, params: [AnyHashable: Any]) {
        if reachable {
            activityIndicatorView?.startAnimation()
            var paramsAsString: String = getUrlEncodedParams(params)
            userInfo = params
            sendStatusUpdate("PARAMS - \(paramsAsString)")
            url = "\(url)?\(paramsAsString)"
            sendStatusUpdate("URL - \(url)")
            var req = BOABMutableURLRequest(url: URL(string: url))
            connect(req)
        }
    }

    func sendAsyncGetRequest(_ url: String) {
        if reachable {
            activityIndicatorView?.startAnimation()
            url = "\(url)"
            sendStatusUpdate("URL - \(url)")
            var req = BOABMutableURLRequest(url: URL(string: url))
            connect(req)
        }
    }

    func reachable() -> Bool {
        var hostReach = Reachability()
        var netStatus: NetworkStatus = hostReach.currentReachabilityStatus()
        var reachable = Reachability(hostName: kREACHABILITYCHECKURL)
        var netHostStatus: NetworkStatus = reachable.currentReachabilityStatus()
        if netStatus == NotReachable {
            /*
                    [UIAlertView showWithTitle:@""
                                       message:@"Looks like network issue! Try later."
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          if (buttonIndex == [alertView cancelButtonIndex]) {
                                          }
                                      }];
                     */
            if noInternetView != nil {
                noInternetView?.removeFromSuperview()
                noInternetView = nil
            }
            var vc: UIViewController? = (delegate as? UIViewController)
            noInternetView = STNoInternetView(defaultSizeandSuperView: vc?.view)
            if (vc? is NSClassFromString("STParentPaymentViewController")) {
                noInternetView?.frame = CGRect(x: CGFloat(0.0), y: CGFloat(vc?.view?.frame?.size?.height - 30.0), width: CGFloat(vc?.view?.frame?.size?.width), height: CGFloat(30.0))
            }
            return false
        }
        else if netHostStatus == NotReachable {
            /*
                    [UIAlertView showWithTitle:@""
                                       message:@"Looks like network issue! Try later."
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          if (buttonIndex == [alertView cancelButtonIndex]) {
                                          }
                                      }];
                     */
            if noInternetView != nil {
                noInternetView?.removeFromSuperview()
                noInternetView = nil
            }
            var vc: UIViewController? = (delegate as? UIViewController)
            noInternetView = STNoInternetView(defaultSizeandSuperView: vc?.view)
            if (vc? is NSClassFromString("STParentPaymentViewController")) {
                noInternetView?.frame = CGRect(x: CGFloat(0.0), y: CGFloat(vc?.view?.frame?.size?.height - 30.0), width: CGFloat(vc?.view?.frame?.size?.width), height: CGFloat(30.0))
            }
            return false
        }

        return true
    }

    func cancel() {
        var vc: UIViewController? = (delegate as? UIViewController)
        vc?.view?.userInteractionEnabled = true
        activityIndicatorView?.stopAnimation()
        block = nil
        data = nil
        conn?.cancel()
        conn = nil
    }


    func initializeRequest(_ block: @escaping (_: Any, _: Data, _: Error) -> Void, statusBlock: @escaping (_: String) -> Void) {
        data = Data.data
        self.block = block
        self.statusBlock = statusBlock
    }

    func getJsonEncodedParams(_ params: [AnyHashable: Any]) -> Data {
        var error: Error?
        var jsonData: Data? = try? JSONSerialization.data(withJSONObject: params, options: NSJSONWritingPrettyPrinted)
        if error != nil {
            print("\(error)")
        }
        return jsonData!
    }

    func getEncodedParams(_ params: [AnyHashable: Any], json: Bool) -> Data {
        var paramsAsData: Data?
        if json {
            paramsAsData = getJsonEncodedParams(params)
        }
        else {
            var paramsAsString: String = getUrlEncodedParams(params)
            paramsAsData = paramsAsString.data(using: String.Encoding.utf8)
        }
        return paramsAsData!
    }

    func setContentType(_ req: BOABMutableURLRequest, json: Bool) {
        if json {
            req.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
            //[req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
    }

    func sendStatusUpdate(_ message: String) {
        if !statusBlock || statusBlock == nil {
            return
        }
        statusBlock(message)
    }

    func connect(_ request: BOABMutableURLRequest) {
        var conn = BOABURLConnection(request: request, delegate: self, startImmediately: false)
        if !conn {
            if block {
                block(nil, nil, Error(domain: "", code: 1, userInfo: nil))
            }
            if delegate?.responds(to: #selector(self.BOABHttpReqFailedWithError)) {
                try? delegate?.boabHttpReqFailed()
            }
            UIAlertView.show(withTitle: "", message: "Stasher has some network issues! Try Later.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {

                }
            })
            return
        }
        self.conn = conn
        self.conn.userInfo = request.userInfo
        conn.start()
        UIApplication.shared.networkActivityIndicatorVisible = true
        sendStatusUpdate("Connecting...")
    }

    func getUrlEncodedParams(_ params: [AnyHashable: Any]) -> String {
        var paramsAsString = String()
        var firstParam: Bool = true
        for key: String in params.keys {
            var value: Any? = params.value(forKey: key)
            var valueAsData: Data? = try? JSONSerialization.data(withJSONObject: value, options: [])
            value = String(valueAsData, encoding: String.Encoding.utf8)
            if firstParam {
                firstParam = false
            }
            else {
                paramsAsString += "&"
            }
            paramsAsString += "\(key)=\(getEscapedString(value))"
        }
        return paramsAsString
    }

    func getEscapedString(_ unescapedString: String) -> String {
        if !(unescapedString is String) {
            return unescapedString
        }
        var escapedString: String? = (CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil, (unescapedString as? CFString), nil, ("!*'();:@&=+$,/?%#[]" as? CFString), kCFStringEncodingUTF8)) as? String)
        return escapedString!
    }
// MARK: - RequestUsingDelegate
// MARK: - Connection Delegate

    func connection(_ connection: NSURLConnection, didFailWithError error: Error?) {
        var vc: UIViewController? = (delegate as? UIViewController)
        vc?.view?.userInteractionEnabled = true
        activityIndicatorView?.stopAnimation()
        UIApplication.shared.networkActivityIndicatorVisible = false
        if block {
            block(nil, nil, error)
        }
        if delegate?.responds(to: #selector(self.BOABHttpReqFailedWithError)) {
            try? delegate?.boabHttpReqFailed()
            if noInternetView != nil {
                noInternetView?.removeFromSuperview()
                noInternetView = nil
            }
            var vc: UIViewController? = (delegate as? UIViewController)
            noInternetView = STNoInternetView(defaultSizeandSuperView: vc?.view)
            if (vc? is NSClassFromString("STParentPaymentViewController")) {
                noInternetView?.frame = CGRect(x: CGFloat(0.0), y: CGFloat(vc?.view?.frame?.size?.height - 30.0), width: CGFloat(vc?.view?.frame?.size?.width), height: CGFloat(30.0))
            }
        }
        var showErrorAlert: Bool = true
        if !userInfo.isEmpty {
            if (userInfo?["action"] == kAPIActionSearchChild) {
                showErrorAlert = false
            }
            else if reachable() {
                showErrorAlert = false
            }
        }
        if showErrorAlert {
            UIAlertView.show(withTitle: "", message: "Stasher has some network issues! Try Later.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {

                }
            })
        }
        sendStatusUpdate(error?.description)
    }

    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        var vc: UIViewController? = (delegate as? UIViewController)
        vc?.view?.userInteractionEnabled = true
        activityIndicatorView?.stopAnimation()
        UIApplication.shared.networkActivityIndicatorVisible = false
        if block {
            var error: Error?
            var data: Any? = try? JSONSerialization.jsonObject(withData: self.data, options: [])
            block(data, self.data, error)
        }
        else {
            sendStatusUpdate("Finished downloading data")
        }
        if delegate?.responds(to: Selector("BOABHttpReqFinishedWithResponse:andConnection:")) {
            delegate?.boabHttpReqFinished(withResponse: self.data, andConnection: (connection as? BOABURLConnection))
            if !userInfo.isEmpty {
                if (userInfo?[kParamKeySaveResponseLocally] == "yes") {
                    if (userInfo?["action"] == kAPIActionProfile) {
                        var filePath: String = "\(STCacheManager.sharedInstance().applicationCachedJSONDirectory()).\("txt")"
                        var err: Error? = nil
                        if FileManager.default.fileExists(atPath: filePath) {
                            try? FileManager.default.removeItem(atPath: filePath)
                        }
                        var jsonString = String(data: self.data, encoding: String.Encoding.utf8)
                        STCacheManager.sharedInstance().saveJSON(forAPIName: userInfo?["action"], jsonString: jsonString)
                        jsonString = nil
                        filePath = nil
                    }
                }
            }
        }
    }

    func connection(_ connection: NSURLConnection, didReceiveResponse response: URLResponse) {
        var httpResponse: HTTPURLResponse? = (response as? HTTPURLResponse)
        var code: Int? = httpResponse?.statusCode
        if code != 200 {
            if block {
                block(nil, nil, Error(domain: "HTTPError", code: code, userInfo: [:]))
            }
            if delegate?.responds(to: #selector(self.BOABHttpReqFailedWithError)) {
                try? delegate?.boabHttpReqFailed()
            }
            UIAlertView.show(withTitle: "", message: "Stasher has some network issues! Try Later.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {

                }
            })
            cancel()
        }
    }

    func connection(_ connection: NSURLConnection, didReceiveData data: Data) {
        self.data.append(data)
        sendStatusUpdate("Got \(UInt(self.data.length)) bytes")
    }

    func connection(_ connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: URLAuthenticationChallenge) {
        var vc: UIViewController? = (delegate as? UIViewController)
        vc?.view?.userInteractionEnabled = true
        activityIndicatorView?.stopAnimation()
        challenge.sender.continueWithoutCredential(forAuthenticationChallenge: challenge)
        sendStatusUpdate("Got auth challenge")
    }

    func connection(_ connection: NSURLConnection, willSendRequestForAuthenticationChallenge challenge: URLAuthenticationChallenge) {
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            sendStatusUpdate("Ignoring SSL")
            var trust: SecTrustRef? = challenge.protectionSpace.serverTrust
            var cred = URLCredential(trust: trust)
            challenge.sender.useCredential(cred, forAuthenticationChallenge: challenge)
            return
        }
        sendStatusUpdate("Cancelling SSL")
        challenge.sender.cancelAuthenticationChallenge(challenge)
    }
// MARK: - Rechability
}
import UIKit