//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STParentMakePaymentViewController.swift
//  Stasher
//
//  Created by bhushan on 02/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STParentMakePaymentViewController: UIViewController, STSharedCustomsDelegate {

    @IBOutlet var headerLabel: UILabel!
    var childDictionary = [AnyHashable: Any]()
    @IBOutlet var labelChildName: UILabel!
    @IBOutlet var childAvatarImgView: UIImageView!
    @IBOutlet var oneTimeButton: UIButton!
    @IBOutlet var recurringButton: UIButton!
    @IBOutlet var txtFieldAmount: UITextField!
    @IBOutlet var txtViewMissionDescription: UITextView!
    @IBOutlet var missionDescriptionCharLimit: UILabel!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        labelChildName.textColor = UIColor.stasherText()
        var font1 = UIFont.fontGothamRoundedMedium(withSize: 14.0)
        var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
        var aAttrString1 = NSMutableAttributedString(string: "\(childDictionary[kParamKeyFirstname] as? NSMutableAttributedString) ", attributes: arialDict)
        var font2 = UIFont.fontGothamRoundedBook(withSize: 14.0)
        var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
        var aAttrString2 = NSMutableAttributedString(string: "\(childDictionary[kParamKeyLastname] as? NSMutableAttributedString)", attributes: arialDict2)
        aAttrString1?.append(aAttrString2)
        labelChildName.attributedText = aAttrString1
        if !(childDictionary[kParamKeyAvatar] is NSNull) && !(childDictionary[kParamKeyAvatar] == "") {
            childAvatarImgView.setImageWith(URL(string: childDictionary[kParamKeyAvatar]), placeholderImage: UIImage(named: "account_face_placeholder"))
        }
        else {
            childAvatarImgView.image = UIImage(named: "account_face_placeholder")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        headerLabel.font = UIFont()
        childAvatarImgView.clipsToBounds = true
        childAvatarImgView.layer.cornerRadius = childAvatarImgView.frame.size.width / 2.0
        childAvatarImgView.layer.borderColor = UIColor.lightGray.cgColor
        childAvatarImgView.layer.borderWidth = 0.5
        for txtFields: Any in view.subviews {
            if (txtFields is UITextField) {
                var textField: UITextField? = (txtFields as? UITextField)
                textField?.font = UIFont()
                textField?.attributedPlaceholder = NSAttributedString(string: textField?.placeholder, attributes: [NSForegroundColorAttributeName: UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0)), NSFontAttributeName: UIFont()])
                textField?.textColor = UIColor.stasherText()
            }
        }
        oneTimeButton.titleLabel?.font = UIFont(size: 11.0)
        recurringButton.titleLabel?.font = UIFont(size: 11.0)
        txtViewMissionDescription.textColor = UIColor.stasherTextFieldPlaceHolder()
        txtViewMissionDescription.font = UIFont()
        missionDescriptionCharLimit.font = UIFont.fontGothamRoundedMedium(withSize: 9.0)
        missionDescriptionCharLimit.textColor = UIColor.stasherTextFieldPlaceHolder()
        txtFieldAmount.keyboardType = .numbersAndPunctuation
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: self).addRightSwipeGestureRecognizerToMe()
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

    @IBAction func oneTimeButtonPressed(_ sender: Any) {
        if txtFieldAmount.text.validateNotEmpty() && txtViewMissionDescription.text.validateNotEmpty() {
            if STUserIdentity.sharedInstance().userKnoxFirstTransactionID() != nil && !(STUserIdentity.sharedInstance().userKnoxFirstTransactionID() == "") {
                UIAlertView.show(withTitle: "", message: "Auto Transfer under development", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                })
            }
            else {
                UIAlertView.show(withTitle: "", message: "Link Bank Account First", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                })
            }
        }
        else {
            var message: String
            if !txtFieldAmount.text.validateNotEmpty() {
                message = "Please enter amount."
            }
            else {
                message = "Please enter description."
            }
            UIAlertView.show(withTitle: "", message: message, cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
            })
        }
    }

    @IBAction func recurringButtonPressed(_ sender: Any) {
        if txtFieldAmount.text.validateNotEmpty() {
            if STUserIdentity.sharedInstance().userKnoxFirstTransactionID() != nil && !(STUserIdentity.sharedInstance().userKnoxFirstTransactionID() == "") {
                UIAlertView.show(withTitle: "", message: "Auto Transfer under development", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                })
            }
            else {
                UIAlertView.show(withTitle: "", message: "Link Bank Account First", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                })
            }
        }
        else {
            var message: String
            if !txtFieldAmount.text.validateNotEmpty() {
                message = "Please enter amount."
            }
            else {
                message = "Please enter description."
            }
            UIAlertView.show(withTitle: "", message: message, cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
            })
        }
    }

    func rightGestureHandle() {
        navigationController?.popViewController(animated: true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: nil)
    }

    func sendKnoxRequest(withAmount amt: String, transactionType: String) {
        print("sendKnoxRequest to OAB Server...")
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
        if !IS_STANDARD_IPHONE_6 && !IS_STANDARD_IPHONE_6_PLUS {
            if textField == txtFieldAmount {
                var viewFrame: CGRect = view.frame
                viewFrame.origin.y = -120.0
                view.frame = viewFrame
            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if !IS_STANDARD_IPHONE_6 && !IS_STANDARD_IPHONE_6_PLUS {
            textField.resignFirstResponder()
            var viewFrame: CGRect = view.frame
            viewFrame.origin.y = 0.0
            view.frame = viewFrame
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text.length > 0 && !textField.text.containsString("$") {
            textField.text = "$\(textField.text)"
        }
        textField.resignFirstResponder()
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
}