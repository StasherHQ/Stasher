//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STChangePasswordViewController.swift
//  Stasher
//
//  Created by bhushan on 19/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol ChangePasswordDelegate: NSObjectProtocol {
    func passwordHasBeenChanged()
}
class STChangePasswordViewController: UIViewController, STSharedCustomsDelegate {
    var httpReq: BOABHttpReq?

    weak var delegate: ChangePasswordDelegate?
    var changPasswordParamDictionary = [AnyHashable: Any]()
    @IBOutlet var savePasswordChangeButton: UIButton!
    @IBOutlet var txtFieldOldPassword: UITextField!
    @IBOutlet var txtFieldNewPassword: UITextField!
    @IBOutlet var: UITextField!
    @IBOutlet var headerlabel: UILabel!
    @IBOutlet var buttonSave: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        headerlabel.font = UIFont()
        buttonSave.titleLabel?.font = UIFont(size: 11.0)
        for txtFields: Any in view.subviews {
            if (txtFields is UITextField) {
                var textField: UITextField? = (txtFields as? UITextField)
                textField?.font = UIFont()
                textField?.attributedPlaceholder = NSAttributedString(string: textField?.placeholder, attributes: [NSForegroundColorAttributeName: UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0)), NSFontAttributeName: UIFont()])
                textField?.textColor = UIColor.stasherText()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: self).addRightSwipeGestureRecognizerToMe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func rightGestureHandle() {
        navigationController?.popViewController(animated: true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: nil)
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

    @IBAction func savePasswordChangeButtonPressed(_ sender: Any) {
        if changPasswordParamDictionary.isEmpty {
            changPasswordParamDictionary = [AnyHashable: Any]()
        }
        changPasswordParamDictionary[kChangePasswordParamKeyOldPassword] = txtFieldOldPassword.text
        changPasswordParamDictionary[kChangePasswordParamKeyNewPassword] = txtFieldNewPassword.text
        changPasswordParamDictionary[kChangePasswordParamKeyConfirmPassword] = txtFieldConfirmPassword.text
        if STUserIdentity.sharedInstance().userId() {
            changPasswordParamDictionary[kParamKeyUserID] = STUserIdentity.sharedInstance().userId()
        }
        changPasswordParamDictionary[kParamKeyAction] = kAPIActionChangePassword
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: changPasswordParamDictionary, json: true)
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
// MARK: ----- Custom Methods

    func popChangePasswordController() {
        if delegate?.responds(to: #selector(self.passwordHasBeenChanged)) {
            delegate?.passwordHasBeenChanged()
        }
    }
// MARK: ----- Textfield Methods

    func textFieldDidBeginEditing(_ textField: UITextField) {
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFieldOldPassword {
            txtFieldNewPassword.becomeFirstResponder()
        }
        else if textField == txtFieldNewPassword {
            txtFieldConfirmPassword.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }

        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var shouldChange: Bool = true
        if textField == txtFieldOldPassword || textField == txtFieldNewPassword || textField == txtFieldConfirmPassword {
            if string.validateAlphanumeric() {
                shouldChange = true
            }
            else {
                shouldChange = false
            }
        }
        return shouldChange
    }
// MARK: - BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDict: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDict?["success"] {
                UIAlertView.show(withTitle: "", message: responseDict?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                    if buttonIndex == alertView.cancelButtonIndex {
                        navigationController?.popViewController(animated: true)
                        self.performSelector(#selector(self.popChangePasswordController), withObject: nil, afterDelay: 0.5)
                    }
                })
            }
            else if responseDict?["error"] {
                UIAlertView.show(withTitle: "", message: responseDict?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                    if buttonIndex == alertView.cancelButtonIndex {

                    }
                })
            }
        }
    }

    func boabHttpReqFailedWithError(_ error: Error?) {
        if error != nil {

        }
    }
}