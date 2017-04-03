//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STRegisterStepOneViewController.swift
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STRegisterStepOneViewController: UIViewController, STSharedCustomsDelegate {
    var httpReq: BOABHttpReq?
    var stepOneParamDict = [AnyHashable: Any]()

    @IBOutlet var headerLabelRegistration: UILabel!
    @IBOutlet var headerLabelSteps: UILabel!
    var launchInfoDictionary = [AnyHashable: Any]()
    @IBOutlet var stepsTitleLabel: UILabel!
    @IBOutlet var aboveAgeRegistrationFieldView: UIView!
    @IBOutlet var belowAgeRegistrationFieldView: UIView!
    @IBOutlet var underAgeLabel: UILabel!
    @IBOutlet var areYouParentLabel: UILabel!
    @IBOutlet var ageSwitch: UISwitch!
    @IBOutlet var parentSwitch: UISwitch!
    @IBOutlet var txtFieldEmailAddress: UITextField!
    @IBOutlet var txtFieldUsername: UITextField!
    @IBOutlet var txtFieldPassword: UITextField!
    @IBOutlet var txtFieldParentsEmailAddress: UITextField!
    @IBOutlet var txtFieldUnderAgeUsername: UITextField!
    @IBOutlet var txtFieldUnderAgePassword: UITextField!
    @IBOutlet var aboveAgeNextButton: UIButton!
    @IBOutlet var belowAgeNextButton: UIButton!
    @IBOutlet var parentCustomSwitchView: UIView!
    @IBOutlet var buttonParentSwitchYes: UIButton!
    @IBOutlet var buttonParentSwitchNo: UIButton!
    @IBOutlet var imgViewGreenParentCustomSwitch: UIImageView!
    @IBOutlet var imgViewBGParentCustomSwitch: UIImageView!
    @IBOutlet var ageCustomSwitchView: UIView!
    @IBOutlet var buttonAgeSwitchYes: UIButton!
    @IBOutlet var buttonAgeSwitchNo: UIButton!
    @IBOutlet var imgViewGreenAgeCustomSwitch: UIImageView!
    @IBOutlet var imgViewBGAgeCustomSwitch: UIImageView!

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, withDictionary dictionary: [AnyHashable: Any]) {
        super.init(nibName: "STRegisterStepOneViewController", bundle: Bundle.main)
        
        launchInfoDictionary = dictionary
    
    }

    @IBAction func parentSwitchValueChanged(_ sender: Any) {
        var thisParentSwitch: UISwitch? = (sender as? UISwitch)
        if thisParentSwitch == parentSwitch {
            if !thisParentSwitch?.isOn() {
                ageCustomSwitchView.isHidden = false
                underAgeLabel.isHidden = false
                aboveAgeRegistrationFieldView.remove(fromSuperviewwithAnimation: true)
                addBelowAgeRegistrationViewAsSubview()
                changeHeaderText(NSLocalizedString("Step 1 of 2", comment: ""))
                STUserIdentity.sharedInstance().userIdentity = CHILDUSER
            }
            else {
                ageCustomSwitchView.isHidden = true
                underAgeLabel.isHidden = true
                addAboveAgeRegistrationViewAsSubview()
                belowAgeRegistrationFieldView.remove(fromSuperviewwithAnimation: true)
                changeHeaderText(NSLocalizedString("Step 1 of 3", comment: ""))
                STUserIdentity.sharedInstance().userIdentity = PARENTUSER
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        headerLabelRegistration.sizeToFit()
        headerLabelSteps.sizeToFit()
        changeHeaderText(NSLocalizedString("Step 1 of 3", comment: ""))
        headerLabelRegistration.font = UIFont.fontGothamRoundedMedium(withSize: 16.0)
        headerLabelSteps.sizeToFit()
        areYouParentLabel.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        areYouParentLabel.textColor = UIColor.stasherText()
        underAgeLabel.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        underAgeLabel.textColor = UIColor.stasherText()
        aboveAgeNextButton.titleLabel?.font = UIFont(size: 11.0)
        belowAgeNextButton.titleLabel?.font = UIFont(size: 11.0)
        buttonParentSwitchYes.titleLabel?.font = UIFont(size: 6.5)
        buttonAgeSwitchYes.titleLabel?.font = UIFont(size: 6.5)
        buttonAgeSwitchNo.titleLabel?.font = UIFont(size: 6.5)
        buttonParentSwitchNo.titleLabel?.font = UIFont(size: 6.5)
        setUpTextFieldAttributes()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //[[STSharedCustoms sharedAddGestureInstanceWithDelegate:self] addRightSwipeGestureRecognizerToMe];
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar?.isHidden = true
        if parentSwitch.isOn() {
            addAboveAgeRegistrationViewAsSubview()
        }
        if !launchInfoDictionary.isEmpty {
            if launchInfoDictionary[kParamKeyEmail] {
                txtFieldEmailAddress.text = launchInfoDictionary[kParamKeyEmail]
            }
        }
        changeHeaderText(NSLocalizedString("Step 1 of 3", comment: ""))
        performSelector(#selector(self.setUpFrames), withObject: nil, afterDelay: 0.1)
    }

    func setUpFrames() {
        var parentSwitchFrame: CGRect = parentSwitch.frame
        parentSwitchFrame.origin.x = view.frame.size.width - parentCustomSwitchView.frame.size.width - 8.0
        parentSwitchFrame.origin.y = areYouParentLabel.center.y
        parentSwitchFrame.size.width = parentCustomSwitchView.frame.size.width
        parentSwitchFrame.size.height = parentCustomSwitchView.frame.size.height
        parentCustomSwitchView.frame = parentSwitchFrame
        parentCustomSwitchView.center = CGPoint(x: CGFloat(parentCustomSwitchView.center.x), y: CGFloat(areYouParentLabel.center.y - 2))
        view.addSubview(parentCustomSwitchView)
        var ageSwitchFrame: CGRect = ageSwitch.frame
        ageSwitchFrame.origin.x = view.frame.size.width - ageCustomSwitchView.frame.size.width - 8.0
        ageSwitchFrame.size.width = ageCustomSwitchView.frame.size.width
        ageSwitchFrame.size.height = ageCustomSwitchView.frame.size.height
        ageCustomSwitchView.frame = ageSwitchFrame
        view.addSubview(ageCustomSwitchView)
        ageCustomSwitchView.isHidden = true
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
// MARK: ----- Actions

    @IBAction func nextButtonPressed(_ sender: Any) {
        if !stepOneParamDict.isEmpty {
            stepOneParamDict = nil
        }
        STUserIdentity.sharedInstance().userIdentity = parentSwitch.isOn() ? PARENTUSER : CHILDUSER
        STUserIdentity.sharedInstance().isUserUnderAge = ageSwitch.isOn() ? true : false
        if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
            if txtFieldEmailAddress.text.validateNotEmpty() && txtFieldPassword.text.validateNotEmpty() && txtFieldUsername.text.validateNotEmpty() {
                if txtFieldEmailAddress.text.validateEmail() {
                    stepOneParamDict = [AnyHashable: Any]()
                    stepOneParamDict[kParamKeyEmail] = txtFieldEmailAddress.text
                    stepOneParamDict[kParamKeyPassword] = txtFieldPassword.text
                    stepOneParamDict[kParamKeyUsername] = txtFieldUsername.text
                    //[self launchStepRegistrationWithDictionary:dict];
                    if httpReq != nil {
                        httpReq?.delegate = nil
                        httpReq = nil
                    }
                    httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
                    httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
                        kParamKeyAction : kAPIActionRegistrationStepOne,
                        kParamKeyUsername : txtFieldUsername.text,
                        kParamKeyEmail : txtFieldEmailAddress.text
                    ]
, json: true)
                }
                else {
                    UIAlertView.show(withTitle: "", message: "Enter a valid E-mail address.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        if buttonIndex == alertView.cancelButtonIndex {
                            self.txtFieldEmailAddress.becomeFirstResponder()
                        }
                    })
                }
            }
            else {
                UIAlertView.show(withTitle: "", message: "All fields are mandatory.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                    if buttonIndex == alertView.cancelButtonIndex {

                    }
                })
            }
        }
        else {
            if STUserIdentity.sharedInstance().isUserUnderAge() {
                if txtFieldParentsEmailAddress.text.validateNotEmpty() && txtFieldUnderAgeUsername.text.validateNotEmpty() {
                    if txtFieldParentsEmailAddress.text.validateEmail() {
                        stepOneParamDict = [AnyHashable: Any]()
                        stepOneParamDict["email"] = txtFieldParentsEmailAddress.text
                        stepOneParamDict["username"] = txtFieldUnderAgeUsername.text
                        //[self launchStepRegistrationWithDictionary:dict];
                        if httpReq != nil {
                            httpReq?.delegate = nil
                            httpReq = nil
                        }
                        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
                        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
                            kParamKeyAction : kAPIActionRegistrationStepOne,
                            kParamKeyUsername : txtFieldUnderAgeUsername.text,
                            kParamKeyEmail : txtFieldParentsEmailAddress.text
                        ]
, json: true)
                    }
                    else {
                        UIAlertView.show(withTitle: "", message: "Enter a valid E-mail address.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                            if buttonIndex == alertView.cancelButtonIndex {
                                self.txtFieldParentsEmailAddress.becomeFirstResponder()
                            }
                        })
                    }
                }
                else {
                    UIAlertView.show(withTitle: "", message: "All fields are mandatory.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        if buttonIndex == alertView.cancelButtonIndex {

                        }
                    })
                }
            }
            else {
                if txtFieldEmailAddress.text.validateNotEmpty() && txtFieldPassword.text.validateNotEmpty() && txtFieldUsername.text.validateNotEmpty() {
                    if txtFieldEmailAddress.text.validateEmail() {
                        stepOneParamDict = [AnyHashable: Any]()
                        stepOneParamDict["email"] = txtFieldEmailAddress.text
                        stepOneParamDict["password"] = txtFieldPassword.text
                        stepOneParamDict["username"] = txtFieldUsername.text
                        //[self launchStepRegistrationWithDictionary:dict];
                        if httpReq != nil {
                            httpReq?.delegate = nil
                            httpReq = nil
                        }
                        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
                        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
                            kParamKeyAction : kAPIActionRegistrationStepOne,
                            kParamKeyUsername : txtFieldUsername.text,
                            kParamKeyEmail : txtFieldEmailAddress.text
                        ]
, json: true)
                    }
                    else {
                        UIAlertView.show(withTitle: "", message: "Enter a valid E-mail address.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                            if buttonIndex == alertView.cancelButtonIndex {
                                self.txtFieldEmailAddress.becomeFirstResponder()
                            }
                        })
                    }
                }
                else {
                    UIAlertView.show(withTitle: "", message: "All fields are mandatory.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        if buttonIndex == alertView.cancelButtonIndex {

                        }
                    })
                }
            }
        }
    }

    func changeHeaderText(_ text: String) {
        var font1 = UIFont.fontGothamRoundedMedium(withSize: 14.0)
        var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
        var aAttrString1 = NSMutableAttributedString(string: "\("Registration") ", attributes: arialDict)
        var font2 = UIFont.fontGothamRoundedBook(withSize: 14.0)
        var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
        var aAttrString2 = NSMutableAttributedString(string: "\(text)", attributes: arialDict2)
        aAttrString1.append(aAttrString2)
        headerLabelRegistration.attributedText = aAttrString1
    }

    func launchStepRegistration(withDictionary dict: [AnyHashable: Any]) {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var storyBoardIdentifier: String
        if isiPhone4s {
            storyBoardIdentifier = "STRegisterStepTwoViewController.3.5"
        }
        else if IS_STANDARD_IPHONE_6_PLUS {
            storyBoardIdentifier = "STRegisterStepTwoViewController.5.5"
        }
        else {
            storyBoardIdentifier = "STRegisterStepTwoViewController"
        }

        var registerStepTwoVC: STRegisterStepTwoViewController? = storyboard.instantiateViewController(withIdentifier: storyBoardIdentifier)
        if !launchInfoDictionary.isEmpty {
            if launchInfoDictionary[kParamKeyFirstname] {
                dict[kParamKeyFirstname] = launchInfoDictionary[kParamKeyFirstname]
            }
            if launchInfoDictionary[kParamKeyLastname] {
                dict[kParamKeyLastname] = launchInfoDictionary[kParamKeyLastname]
            }
            if launchInfoDictionary[kParamKeyGender] {
                dict[kParamKeyGender] = launchInfoDictionary[kParamKeyGender]
            }
            if launchInfoDictionary[kParamKeyDateOfBirth] {
                dict[kParamKeyDateOfBirth] = launchInfoDictionary[kParamKeyDateOfBirth]
            }
            if launchInfoDictionary[kParamKeyAvatar] {
                dict[kParamKeyAvatar] = launchInfoDictionary[kParamKeyAvatar]
            }
        }
        registerStepTwoVC?.registrationInfoDictionary = dict
        navigationController?.pushViewController(registerStepTwoVC, animated: true)
    }

    @IBAction func underAgeSwitchValueChanged(_ sender: Any) {
        var thisAgeSwitch: UISwitch? = (sender as? UISwitch)
        if thisAgeSwitch == ageSwitch {
            if !thisAgeSwitch?.isOn() {
                var aboveAgeViewFrame: CGRect = aboveAgeRegistrationFieldView.frame
                aboveAgeViewFrame.origin.y = underAgeLabel.frame.origin.y + 2 * underAgeLabel.frame.size.height
                aboveAgeViewFrame.size.width = view.frame.size.width - aboveAgeRegistrationFieldView.frame.origin.x
                aboveAgeRegistrationFieldView.frame = aboveAgeViewFrame
                view.addSubview(aboveAgeRegistrationFieldView, withAnimation: true)
                changeHeaderText(NSLocalizedString("Step 1 of 2", comment: ""))
                STUserIdentity.sharedInstance().isUserUnderAge = false
            }
            else {
                aboveAgeRegistrationFieldView.remove(fromSuperviewwithAnimation: true)
                addBelowAgeRegistrationViewAsSubview()
                changeHeaderText(NSLocalizedString("Step 1 of 2", comment: ""))
                STUserIdentity.sharedInstance().isUserUnderAge = true
            }
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func rightGestureHandle() {
        navigationController?.popViewController(animated: true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: nil)
    }

    @IBAction func underAgeFinishButtonPressed(_ sender: Any) {
        if !txtFieldParentsEmailAddress.text.validateEmail() {
            UIAlertView.show(withTitle: "", message: "Please enter valid email address.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
            })
        }
        else {
            if httpReq != nil {
                httpReq?.delegate = nil
                httpReq = nil
            }
            httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
            var paramDict = [AnyHashable: Any]()
            paramDict[kParamKeyEmail] = txtFieldParentsEmailAddress.text
            paramDict[kParamKeyPassword] = txtFieldUnderAgePassword
            paramDict[kParamKeyAction] = kAPIActionInviteParent
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
            paramDict = nil
        }
    }
// MARK: ----- Custom Methods

    func addAboveAgeRegistrationViewAsSubview() {
        var aboveAgeViewFrame: CGRect = aboveAgeRegistrationFieldView.frame
        aboveAgeViewFrame.origin.y = underAgeLabel.frame.origin.y
        aboveAgeViewFrame.size.width = view.frame.size.width - aboveAgeRegistrationFieldView.frame.origin.x
        aboveAgeRegistrationFieldView.frame = aboveAgeViewFrame
        view.addSubview(aboveAgeRegistrationFieldView, withAnimation: true)
    }

    func addBelowAgeRegistrationViewAsSubview() {
        var belowAgeViewFrame: CGRect = belowAgeRegistrationFieldView.frame
        belowAgeViewFrame.origin.y = underAgeLabel.frame.origin.y + 2 * underAgeLabel.frame.size.height
        belowAgeViewFrame.size.width = view.frame.size.width - belowAgeRegistrationFieldView.frame.origin.x
        belowAgeRegistrationFieldView.frame = belowAgeViewFrame
        view.addSubview(belowAgeRegistrationFieldView, withAnimation: true)
        var ageSwitchFrame: CGRect = ageSwitch.frame
        ageSwitchFrame.origin.x = view.frame.size.width - ageCustomSwitchView.frame.size.width - 8.0
        ageSwitchFrame.size.width = ageCustomSwitchView.frame.size.width
        ageSwitchFrame.size.height = ageCustomSwitchView.frame.size.height
        ageCustomSwitchView.frame = ageSwitchFrame
        view.addSubview(ageCustomSwitchView)
        ageCustomSwitchView.isHidden = false
    }

    func setUpTextFieldAttributes() {
        for txtFields: Any in aboveAgeRegistrationFieldView.subviews {
            if (txtFields is UITextField) {
                var textField: UITextField? = (txtFields as? UITextField)
                textField?.font = UIFont()
                textField?.attributedPlaceholder = NSAttributedString(string: textField?.placeholder, attributes: [NSForegroundColorAttributeName: UIColor.stasherTextFieldPlaceHolder(), NSFontAttributeName: UIFont()])
                textField?.textColor = UIColor.stasherText()
            }
        }
        for txtFields: Any in belowAgeRegistrationFieldView.subviews {
            if (txtFields is UITextField) {
                var textField: UITextField? = (txtFields as? UITextField)
                textField?.font = UIFont()
                textField?.attributedPlaceholder = NSAttributedString(string: textField?.placeholder, attributes: [NSForegroundColorAttributeName: UIColor.stasherTextFieldPlaceHolder(), NSFontAttributeName: UIFont()])
                textField?.textColor = UIColor.stasherText()
            }
        }
    }

    @IBAction func parentCustomSwitchYesButtonPressed(_ sender: Any) {
        if parentSwitch.isOn() {
            UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
                self.imgViewGreenParentCustomSwitch.center = CGPoint(x: CGFloat(13), y: CGFloat(imgViewGreenParentCustomSwitch.center.y))
                self.parentSwitch.on = false
                self.parentSwitchValueChanged(self.parentSwitch)
                self.buttonParentSwitchYes.setHidden(animated: true)
                self.buttonParentSwitchNo.setHidden(animated: false)
                self.imgViewGreenParentCustomSwitch.image = UIImage(named: "toggle_graycircle")
                self.imgViewBGParentCustomSwitch.image = UIImage(named: "toggle_graybg")
            })
        }
        else {
            UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
                self.imgViewGreenParentCustomSwitch.center = CGPoint(x: CGFloat(parentCustomSwitchView.frame.size.width - 13), y: CGFloat(imgViewGreenParentCustomSwitch.center.y))
                self.parentSwitch.on = true
                self.parentSwitchValueChanged(self.parentSwitch)
                self.buttonParentSwitchYes.setHidden(animated: false)
                self.buttonParentSwitchNo.setHidden(animated: true)
                self.imgViewGreenParentCustomSwitch.image = UIImage(named: "toggle_yellowcircle")
                self.imgViewBGParentCustomSwitch.image = UIImage(named: "toggle_greenBG")
            })
        }
    }

    @IBAction func parentCustomSwitchNoButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
            self.imgViewGreenParentCustomSwitch.center = buttonParentSwitchNo.center
            self.parentSwitch.on = false
            self.parentSwitchValueChanged(self.parentSwitch)
        })
    }

    @IBAction func ageCustomSwitchYesButtonPressed(_ sender: Any) {
        if ageSwitch.isOn() {
            UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
                self.imgViewGreenAgeCustomSwitch.center = CGPoint(x: CGFloat(13), y: CGFloat(imgViewGreenAgeCustomSwitch.center.y))
                self.ageSwitch.on = false
                self.underAgeSwitchValueChanged(self.ageSwitch)
                self.buttonAgeSwitchYes.setHidden(animated: true)
                self.buttonAgeSwitchNo.setHidden(animated: false)
                self.imgViewGreenAgeCustomSwitch.image = UIImage(named: "toggle_graycircle")
                self.imgViewBGAgeCustomSwitch.image = UIImage(named: "toggle_graybg")
            })
        }
        else {
            UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
                self.imgViewGreenAgeCustomSwitch.center = CGPoint(x: CGFloat(ageCustomSwitchView.frame.size.width - 13), y: CGFloat(imgViewGreenAgeCustomSwitch.center.y))
                self.ageSwitch.on = true
                self.underAgeSwitchValueChanged(self.ageSwitch)
                self.buttonAgeSwitchYes.setHidden(animated: false)
                self.buttonAgeSwitchNo.setHidden(animated: true)
                self.imgViewGreenAgeCustomSwitch.image = UIImage(named: "toggle_yellowcircle")
                self.imgViewBGAgeCustomSwitch.image = UIImage(named: "toggle_greenBG")
            })
        }
    }

    @IBAction func ageCustomSwitchNoButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
            self.imgViewGreenAgeCustomSwitch.center = buttonAgeSwitchNo.center
            self.ageSwitch.on = false
            self.underAgeSwitchValueChanged(self.ageSwitch)
        })
    }
// MARK: ----- Textfield Methods

    @IBAction func textFieldDidChange(_ textField: UITextField) {
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !IS_STANDARD_IPHONE_6 && !IS_STANDARD_IPHONE_6_PLUS {
            if isiPhone5 {
                if textField == txtFieldPassword || textField == txtFieldParentsEmailAddress {
                    var viewFrame: CGRect = view.frame
                    viewFrame.origin.y = -40.0
                    view.frame = viewFrame
                }
            }
            else {
                var viewFrame: CGRect = view.frame
                viewFrame.origin.y = -100.0
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
        if textField == txtFieldEmailAddress {
            txtFieldUsername.becomeFirstResponder()
        }
        else if textField == txtFieldUsername {
            txtFieldPassword.becomeFirstResponder()
        }
        else if textField == txtFieldUnderAgeUsername {
            txtFieldUnderAgePassword.becomeFirstResponder()
        }
        else if textField == txtFieldUnderAgePassword {
            txtFieldParentsEmailAddress.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }

        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var shouldChange: Bool = true
        if textField == txtFieldUsername || textField == txtFieldPassword || textField == txtFieldUnderAgeUsername || textField == txtFieldUnderAgePassword {
            if string.validateAlphanumeric() {
                shouldChange = true
            }
            else {
                shouldChange = false
            }
        }
        return shouldChange
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            if (conn.userInfo?["params"]["action"] == kAPIActionInviteParent) {
                var responseDict: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
                if responseDict?["success"] && responseDict?["success"]["message"] {
                    UIAlertView.show(withTitle: "", message: responseDict?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        if buttonIndex == alertView.cancelButtonIndex {

                        }
                    })
                }
                else if responseDict?["error"] && responseDict?["error"]["message"] {
                    UIAlertView.show(withTitle: "", message: responseDict?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        if buttonIndex == alertView.cancelButtonIndex {

                        }
                    })
                }
            }
            else {
                var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
                if responseDictionary != nil {
                    if responseDictionary?["success"] != nil {
                        launchStepRegistration(withDictionary: stepOneParamDict)
                    }
                    else if responseDictionary?["error"] != nil {
                        if responseDictionary?["error"] {
                            UIAlertView.show(withTitle: "", message: responseDictionary?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                                if buttonIndex == alertView.cancelButtonIndex {
                                    navigationController?.popViewController(animated: true)
                                }
                            })
                        }
                    }
                }
            }
        }
    }

    func boabHttpReqFailedWithError(_ error: Error?) {
        if error != nil {

        }
    }
}