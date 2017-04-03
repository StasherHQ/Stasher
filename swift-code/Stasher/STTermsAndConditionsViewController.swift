//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STTermsAndConditionsViewController.swift
//  Stasher
//
//  Created by bhushan on 17/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol TermsAndConditionsDelegate: NSObjectProtocol {
    func acceptButtonPressed()

    func cancelButtonPressed()
}
class STTermsAndConditionsViewController: UIViewController, BOABHttpReqDelegate {
    var httpReq: BOABHttpReq?

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, andIsThroughSettings isSettingsCall: Bool, andIsPrivacyPolicy isPolicy: Bool, orIsUserAgreement isUserAgreement: Bool) {
        super.init(nibName: "STTermsAndConditionsViewController", bundle: nibBundleOrNil)
        
        if isSettingsCall {
            isSettings = isSettingsCall
            if isPolicy {
                isPrevacyPolicy = isPolicy
            }
            if isUserAgreement {
                isUserAgrrement = isUserAgreement
            }
        }
    
    }
    weak var delegate: TermsAndConditionsDelegate?
    @IBOutlet var policyWebView: UIWebView!
    @IBOutlet var policyTextView: UITextView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var acceptButton: UIButton!
    @IBOutlet var backButton: UIButton!
    var isSettings: Bool = false
    var isUserAgrrement: Bool = false
    var isPrevacyPolicy: Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        policyTextView.font = UIFont()
        policyTextView.textColor = UIColor.stasherText()
        headerLabel.font = UIFont()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if isSettings {
            acceptButton.isHidden = true
            cancelButton.isHidden = true
            backButton.isHidden = false
            var webFrame: CGRect = policyTextView.frame
            webFrame.size.height = view.frame.size.height - 40.0
            policyTextView.frame = webFrame
            if isPrevacyPolicy {
                headerLabel.text = "Privacy Policy"
            }
            else {
                headerLabel.text = "User Agreement"
            }
        }
        else {
            acceptButton.isHidden = false
            cancelButton.isHidden = false
            backButton.isHidden = true
        }
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
            kParamKeyAction : "terms"
        ]
, json: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        policyTextView.contentOffset = CGPoint.zero
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

    @IBAction func cancelButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.cancelButtonPressed)) {
            delegate?.cancelButtonPressed()
        }
    }

    @IBAction func acceptButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.acceptButtonPressed)) {
            delegate?.acceptButtonPressed()
        }
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDictionary != nil {
                var termsData = Data(base64Encoded: (responseDictionary?["page_content"] as? Data), options: 0)
                var policyString = String(termsData, encoding: 0)
                if isPrevacyPolicy {
                    //[self.policyTextView setText:@""];
                }
                else {
                    policyTextView.text = policyString
                }
                //[self.headerLabel setText:[responseDictionary objectForKey:@"page_title"]];
            }
        }
    }

    func boabHttpReqFailedWithError(_ error: Error?) {
        view.userInteractionEnabled = true
        if error != nil {

        }
    }
}