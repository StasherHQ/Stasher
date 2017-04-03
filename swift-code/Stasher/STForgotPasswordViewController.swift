//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STForgotPasswordViewController.swift
//  Stasher
//
//  Created by bhushan on 14/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol ForgotPasswordDelegate: NSObjectProtocol {
    func sendPaswordToEmailButtonPressed()

    func forgetpasswordCanceled()
}
class STForgotPasswordViewController: UIViewController {

    weak var delegate: ForgotPasswordDelegate?
    @IBOutlet var txtFieldusernameMailId: UITextField!
    @IBOutlet var popUpContainerView: UIView!
    @IBOutlet var okButton: UIButton!
    @IBOutlet var cancelButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        txtFieldusernameMailId.font = UIFont()
        txtFieldusernameMailId.attributedPlaceholder = NSAttributedString(string: txtFieldusernameMailId.placeholder, attributes: [NSForegroundColorAttributeName: UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0)), NSFontAttributeName: UIFont()])
        txtFieldusernameMailId.textColor = UIColor.stasherText()
        popUpContainerView.clipsToBounds = true
        popUpContainerView.layer.cornerRadius = 10.0
        popUpContainerView.layer.borderColor = UIColor.lightGray.cgColor
        popUpContainerView.layer.borderWidth = 1.0
        okButton.titleLabel?.font = UIFont(size: 11.0)
        cancelButton.titleLabel?.font = UIFont(size: 11.0)
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

    @IBAction func sendPasswordButtonPressed(_ sender: Any) {
        if txtFieldusernameMailId.text.validateNotEmpty() {
            if txtFieldusernameMailId.text.validateAlphanumeric() || txtFieldusernameMailId.text.validateEmail() {
                var httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
                httpReq.sendAsyncPostRequest(STASHER_BASE_URL, params: [
                    kParamKeyUsername : txtFieldusernameMailId.text,
                    kParamKeyAction : kAPIActionForgotPassword
                ]
, json: true)
            }
            else {
                UIAlertView.show(withTitle: "", message: "Enter a valid E-mail address or Username.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                    if buttonIndex == alertView.cancelButtonIndex {
                        self.txtFieldusernameMailId.becomeFirstResponder()
                    }
                })
            }
        }
        else {
            UIAlertView.show(withTitle: "", message: "Enter a E-mail address or Username.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {
                    self.txtFieldusernameMailId.becomeFirstResponder()
                }
            })
        }
    }

    @IBAction func forgePasswordCancelButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.forgetpasswordCanceled)) {
            delegate?.forgetpasswordCanceled()
        }
    }
// MARK: ----- Textfield

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var shouldChange: Bool = true
        return shouldChange
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDictionary != nil {
                if responseDictionary?["success"] {
                    UIAlertView.show(withTitle: "", message: responseDictionary?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        if buttonIndex == alertView.cancelButtonIndex {
                            if self.delegate?.responds(to: #selector(self.sendPaswordToEmailButtonPressed)) {
                                self.delegate?.sendPaswordToEmailButtonPressed()
                            }
                        }
                    })
                }
                else if responseDictionary?["error"] {
                    UIAlertView.show(withTitle: "", message: responseDictionary?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        if buttonIndex == alertView.cancelButtonIndex {
                            if self.delegate?.responds(to: #selector(self.sendPaswordToEmailButtonPressed)) {
                                self.delegate?.sendPaswordToEmailButtonPressed()
                            }
                        }
                    })
                }
            }
        }
    }

    func boabHttpReqFailedWithError(_ error: Error?) {
        if error != nil {

        }
    }
}