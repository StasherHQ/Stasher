//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STRegisterStepThreeViewController.swift
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STRegisterStepThreeViewController: UIViewController, BOABHttpReqDelegate {
    var httpReq: BOABHttpReq?

    @IBOutlet var textFieldCardNumber: UITextField!
    @IBOutlet var textFieldExpiryDate: UITextField!
    @IBOutlet var textFieldCVVNumber: UITextField!
    @IBOutlet var buttonSaveDetails: UIButton!
    @IBOutlet var buttonSaveLater: UIButton!
    @IBOutlet var paymentsWebView: UIWebView!
    @IBOutlet var selectBankDetailsLabel: UILabel!
    var activityIndicatorView: STActivityIndicatorView?
    @IBOutlet var headerLabelRegistration: UILabel!
    @IBOutlet var headerLabelStep: UILabel!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar?.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSaveLater.titleLabel?.font = UIFont(size: 11.0)
        buttonSaveLater.setTitleColor(UIColor.stasherText(), for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(self.bankTransactionFinished), name: kNotificationIdentifier_BankTransactionFinished, object: nil)
        // Do any additional setup after loading the view.
        headerLabelRegistration.text = "Registration"
        headerLabelRegistration.font = UIFont()
        headerLabelStep.font = UIFont()
        headerLabelStep.sizeToFit()
        headerLabelRegistration.sizeToFit()
        selectBankDetailsLabel.font = UIFont()
        selectBankDetailsLabel.textColor = UIColor.stasherText()
            //create dictionary with user information
        var userInfo = [AnyHashable: Any]()
        //add api key
        userInfo["api_key"] = "4aa327f5ac661878d6178e2c2b44aa5a9a0708d2"
        //add api password
        userInfo["api_password"] = "7a383e494ac323569402b9f1fe591c1735906202"
        //add amount as string
        userInfo["amount"] = "0.01"
        //[userInfo setObject:@"0.01" forKey:@"amount"];
        //add invoice detail];
        userInfo["invoice_detail"] = "Registration Token Transaction"
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
        paymentsWebView.loadRequest(nsrequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func saveDetailsButtonPressed(_ sender: Any) {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var baseTabsController: STBaseTabBarController? = storyboard.instantiateViewController(withIdentifier: "STBaseTabBarController")
        navigationController?.pushViewController(baseTabsController, animated: true)
    }

    @IBAction func saveLaterButtonPressed(_ sender: Any) {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var baseTabsController: STBaseTabBarController? = storyboard.instantiateViewController(withIdentifier: "STBaseTabBarController")
        navigationController?.pushViewController(baseTabsController, animated: true)
    }

    func bankTransactionFinished(_ notification: Notification) {
        var dict: [AnyHashable: Any]? = notification.userInfo
        if dict != nil {
            if dict?["pay_id"] {
                STUserIdentity.sharedInstance().userKnoxFirstTransactionID = dict?["pay_id"]
                if httpReq != nil {
                    httpReq?.delegate = nil
                    httpReq = nil
                }
                httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
                var userIdString: String
                var apiActionString: String
                userIdString = kParamKeyParentID
                apiActionString = kAPIActionAddBankAccount
                httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
                    userIdString : Int(CInt(STUserIdentity.sharedInstance().userId())),
                    kParamKeyAction : apiActionString,
                    kParamKeyTransactionID : dict?["pay_id"]
                ]
, json: true)
            }
            if dict?["completed"] {

            }
        }
        saveLaterButtonPressed(nil)
        NotificationCenter.default.removeObserver(self, name: kNotificationIdentifier_BankTransactionFinished, object: nil)
    }
// MARK: ----- Textfield Methods

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
                print("transaction_id sent to server...")
            }
        }
    }
}