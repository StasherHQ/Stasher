//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STParentPaymentFlowViewController.swift
//  Stasher
//
//  Created by bhushan on 06/02/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
protocol ParentPaymentFlowDelegate: NSObjectProtocol {
    func addAccountSuccessFull(withDict dict: [AnyHashable: Any], andBankAccountUserType bankAccType: Int)
}
class STParentPaymentFlowViewController: UIViewController, BOABHttpReqDelegate {
    var httpReq: BOABHttpReq?

    weak var delegate: ParentPaymentFlowDelegate?
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var paymentWebView: UIWebView!
    var paymentParamsDict = [AnyHashable: Any]()
    var activityIndicatorView: STActivityIndicatorView?
    var bankAccountTypeInt: Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        headerLabel.font = UIFont()
        NotificationCenter.default.addObserver(self, selector: #selector(self.bankTransactionFinished), name: kNotificationIdentifier_BankTransactionFinished, object: nil)
            //create dictionary with user information
        var userInfo = [AnyHashable: Any]()
        //add api key
        userInfo["api_key"] = "4aa327f5ac661878d6178e2c2b44aa5a9a0708d2"
        //add api password
        userInfo["api_password"] = "7a383e494ac323569402b9f1fe591c1735906202"
        //add amount as string
        if paymentParamsDict && paymentParamsDict["amount"] != nil {
            userInfo["amount"] = paymentParamsDict["amount"]
        }
        //[userInfo setObject:@"0.01" forKey:@"amount"];
        //add invoice detail];
        if paymentParamsDict && paymentParamsDict["description"] != nil {
            userInfo["invoice_detail"] = paymentParamsDict["description"]
        }
        //[userInfo setObject:@"invoice detail" forKey:@"invoice_detail"];
        //add information request
        userInfo["information_request"] = "show_all"
        //add recurring detail
        userInfo["reccuring"] = "ot"
        //add redirect URL
        userInfo["redirect_url"] = "fb743090835784071://"
            //make url string with user info on the end
        var url: String? = "https://knoxpayments.com/pay?api_key=\(userInfo["api_key"] as? String)&api_password=\(userInfo["api_password"] as? String)&amount=\(userInfo["amount"] as? String)&invoice_detail=\(userInfo["invoice_detail"] as? String)&information_request=\(userInfo["information_request"] as? String)&recurring=\(userInfo["reccuring"] as? String)&redirect_url=\(userInfo["redirect_url"] as? String)"
        url = url?.addingPercentEscapes(using: String.Encoding.ascii)
        print("\(url)")
            //create URL and request
        var nsurl = URL(string: url)
        var nsrequest = URLRequest(url: nsurl!)
        paymentWebView.loadRequest(nsrequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func bankTransactionFinished(_ notification: Notification) {
        var dict: [AnyHashable: Any]? = notification.userInfo
        if dict != nil {
            if (dict?["completed"] == "canceled") {
                navigationController?.popViewController(animated: true)
                return
            }
            if dict?["pay_id"] {
                STUserIdentity.sharedInstance().userKnoxFirstTransactionID = dict?["pay_id"]
                if httpReq != nil {
                    httpReq?.delegate = nil
                    httpReq = nil
                }
                httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
                if bankAccountTypeInt == 1 {
                    var apiActionString: String
                    apiActionString = kAPIActionAddBankAccount
                    httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
                        kParamKeyParentID : Int(CInt(STUserIdentity.sharedInstance().userId())),
                        kParamKeyAction : apiActionString,
                        kParamKeyTransactionID : dict?["pay_id"]
                    ]
, json: true)
                }
                else if bankAccountTypeInt == 2 {
                    var apiActionString: String
                    apiActionString = kAPIActionAddBankAccountChild
                    var childUserID: String
                    childUserID = (paymentParamsDict["childInfoDict"][kParamKeyUserID] as? String)
                    httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
                        kParamKeyChildID : Int((childUserID as NSString).integerValue),
                        kParamKeyAction : apiActionString,
                        kParamKeyTransactionID : dict?["pay_id"]
                    ]
, json: true)
                }
            }
            if dict?["completed"] {

            }
        }
    }
// MARK: ----- WebView Delegate

    func webViewDidStartLoad(_ webView: UIWebView) {
        if activityIndicatorView != nil {
            activityIndicatorView?.removeFromSuperview()
            activityIndicatorView = nil
        }
        activityIndicatorView = STActivityIndicatorView(defaultSizeandSuperView: view)
        activityIndicatorView?.startAnimation()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicatorView?.stopAnimation()
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activityIndicatorView?.stopAnimation()
        if activityIndicatorView != nil {
            activityIndicatorView?.removeFromSuperview()
            activityIndicatorView = nil
        }
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDictionary != nil {
                if delegate?.responds(to: Selector("addAccountSuccessFullWithDict:andBankAccountUserType:")) {
                    delegate?.addAccountSuccessFull(withDict: responseDictionary, andBankAccountUserType: bankAccountTypeInt)
                }
            }
        }
    }
}