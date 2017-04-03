//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STChildPaymentRequestViewController.swift
//  Stasher
//
//  Created by bhushan on 03/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STChildPaymentRequestViewController: UIViewController {
    var httpReq: BOABHttpReq?

    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var requestButton: UIButton!
    @IBOutlet var txtFieldAmount: UITextField!
    @IBOutlet var txtViewMissionDescription: UITextView!
    @IBOutlet var missionDescriptionCharLimit: UILabel!
    var parentInfoDict = [AnyHashable: Any]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        headerLabel.font = UIFont()
        requestButton.titleLabel?.font = UIFont(size: 11.0)
        for txtFields: Any in view.subviews {
            if (txtFields is UITextField) {
                var textField: UITextField? = (txtFields as? UITextField)
                textField?.font = UIFont()
                textField?.attributedPlaceholder = NSAttributedString(string: textField?.placeholder, attributes: [NSForegroundColorAttributeName: UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0)), NSFontAttributeName: UIFont()])
                textField?.textColor = UIColor.stasherText()
            }
        }
        txtViewMissionDescription.textColor = UIColor.stasherTextFieldPlaceHolder()
        txtViewMissionDescription.font = UIFont()
        missionDescriptionCharLimit.font = UIFont.fontGothamRoundedMedium(withSize: 9.0)
        missionDescriptionCharLimit.textColor = UIColor.stasherTextFieldPlaceHolder()
        txtFieldAmount.keyboardType = .numbersAndPunctuation
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: self).addRightSwipeGestureRecognizerToMe()
    }
    /*
    #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
// MARK: ----- Actions

    @IBAction func requestPaymentButtonPressed(_ sender: Any) {
        if !txtFieldAmount.text.validateNotEmpty() {
            UIAlertView.show(withTitle: "", message: "Enter Amount!", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
            })
        }
        else if !txtViewMissionDescription.text.validateNotEmpty() || (txtViewMissionDescription.text == "What's it for?") {
            UIAlertView.show(withTitle: "", message: "Enter Mission Description!", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
            })
        }
        else {
            requestPaymentServerCall()
        }

    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func rightGestureHandle() {
        navigationController?.popViewController(animated: true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: nil)
    }
// MARK: ----- TextView Delegate

    func textView(_ textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        var shouldChange: Bool = true
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        if textView == txtViewMissionDescription {
            var missionTitleString: String = textView.text + (text)
            if (missionTitleString.characters.count ?? 0) > 250 {
                shouldChange = false
            }
        }
        return shouldChange
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == txtViewMissionDescription {
            if (txtViewMissionDescription.text == "What's it for?") {
                textView.text = ""
            }
        }
        textView.textColor = UIColor.stasherText()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == txtViewMissionDescription {
            if !textView.text.validateNotEmpty() {
                textView.textColor = UIColor.stasherTextFieldPlaceHolder()
                textView.text = "What's it for?"
            }
        }
    }
// MARK: ----- Textfield Methods

    func textFieldDidBeginEditing(_ textField: UITextField) {
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text.length > 0 && !textField.text.containsString("$") {
            textField.text = "$\(textField.text)"
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var shouldChange: Bool = true
        if textField == txtFieldAmount {
            if string.validateNumeric() {
                shouldChange = true
            }
            else if string.contains(".") && !textField.text.containsString(".") {
                shouldChange = true
            }
            else {
                shouldChange = false
            }
        }
        return shouldChange
    }
// MARK: ----- Request Server

    func requestPaymentServerCall() {
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        var paramDict = [AnyHashable: Any]()
        if STUserIdentity.sharedInstance().userId() != nil {
            paramDict[kParamKeyParentID] = parentInfoDict[kParamKeyUserID]
            paramDict[kParamKeyChildID] = STUserIdentity.sharedInstance().userId()
            paramDict[kParamKeyComment] = txtViewMissionDescription.text
            paramDict[kParamKeyComment] = txtFieldAmount.text
            paramDict[kParamKeyAction] = kAPIActionChildRequestPayment
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
            paramDict = nil
        }
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDictionary != nil {
                do {
                    if responseDictionary?["success"] {
                        UIAlertView.show(withTitle: "", message: responseDictionary?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                            navigationController?.popViewController(animated: true)
                        })
                    }
                    else if responseDictionary?["error"] {
                        UIAlertView.show(withTitle: "", message: responseDictionary?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                            navigationController?.popViewController(animated: true)
                        })
                    }

                }
            }
        }
    }
}