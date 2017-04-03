//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STRegisterStepTwoViewController.swift
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STRegisterStepTwoViewController: UIViewController, BOABHttpReqDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, STSharedCustomsDelegate, TermsAndConditionsDelegate, CountryNamesViewDelegate, AvatarVCDelegate {
    var currentTextField: UITextField?
    var countryNamesActionSheet: UIActionSheet?
    var countryID: Int = 0
    var genderActionSheet: UIActionSheet?
    var profilePhotoActionSheet: UIActionSheet?
    var tandcVC: STTermsAndConditionsViewController?
    var countryNamesVC: STCountryNamesViewController?
    var avatarSelectVC: STAvatarsViewController?
    var selectedDOBStr: String = ""

    var registrationInfoDictionary = [AnyHashable: Any]()
    var countryNamesDictsArray = [Any]()
    @IBOutlet var stepTitleBtn: UIButton!
    @IBOutlet var txtFieldFirstName: UITextField!
    @IBOutlet var txtFieldLastName: UITextField!
    @IBOutlet var txtFieldGender: UITextField!
    @IBOutlet var txtFieldAge: UITextField!
    @IBOutlet var txtFieldCountry: UITextField!
    @IBOutlet var dobDatePicker: UIDatePicker!
    @IBOutlet var dobPickerContainerView: UIView!
    @IBOutlet var dobPickerDoneButton: UIButton!
    @IBOutlet var profilePicButton: UIButton!
    var profilePickerImageData: Data?
    @IBOutlet var headerLabelRegistration: UILabel!
    @IBOutlet var headerLabelStep: UILabel!
    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var transparentImageBG: UIImageView!
    @IBOutlet var buttonCloseBackGroundPopUp: UIButton!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar?.isHidden = true
        if !registrationInfoDictionary.isEmpty {
            if registrationInfoDictionary[kParamKeyFirstname] {
                txtFieldFirstName.text = registrationInfoDictionary[kParamKeyFirstname]
            }
            if registrationInfoDictionary[kParamKeyLastname] {
                txtFieldLastName.text = registrationInfoDictionary[kParamKeyLastname]
            }
            if registrationInfoDictionary[kParamKeyGender] {
                txtFieldGender.text = registrationInfoDictionary[kParamKeyGender]
            }
            if registrationInfoDictionary[kParamKeyDateOfBirth] {
                var dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy-MM-dd"
                var dateFormat2 = DateFormatter()
                dateFormat2.dateFormat = "MMMM d, YYYY"
                var dateStr: String? = dateFormat2.string(from: dateFormat.date(fromString: (registrationInfoDictionary[kParamKeyDateOfBirth] as? String)))
                txtFieldAge.text = dateStr
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        transparentImageBG.frame = view.frame
        if STUserIdentity.sharedInstance().userIdentity() == CHILDUSER {
            headerLabelStep.text = NSLocalizedString("Step 2 of 2", comment: "")
        }
        else {
            headerLabelStep.text = NSLocalizedString("Step 2 of 3", comment: "")
        }
        if isiPhone4s {
            containerScrollView.contentSize = CGSize(width: CGFloat(containerScrollView.frame.size.width), height: CGFloat(registerButton.frame.origin.y + registerButton.frame.size.height))
            for txtFields: Any in containerScrollView.subviews {
                if (txtFields is UITextField) {
                    var textField: UITextField? = (txtFields as? UITextField)
                    textField?.font = UIFont()
                    textField?.attributedPlaceholder = NSAttributedString(string: textField?.placeholder, attributes: [NSForegroundColorAttributeName: UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0)), NSFontAttributeName: UIFont()])
                    textField?.textColor = UIColor.stasherText()
                }
            }
        }
        //Clip/Clear the other pieces whichever outside the rounded corner
        profilePicButton.clipsToBounds = true
        profilePicButton.layer.cornerRadius = profilePicButton.frame.size.width / 2.0
        profilePicButton.layer.borderColor = UIColor.clear.cgColor
        profilePicButton.layer.borderWidth = 2.0
        headerLabelRegistration.text = "Registration"
        headerLabelRegistration.font = UIFont.fontGothamRoundedMedium(withSize: 16.0)
        headerLabelStep.font = UIFont.fontGothamRoundedBook(withSize: 16.0)
        headerLabelStep.sizeToFit()
        headerLabelRegistration.sizeToFit()
        for txtFields: Any in view.subviews {
            if (txtFields is UITextField) {
                var textField: UITextField? = (txtFields as? UITextField)
                textField?.font = UIFont()
                textField?.attributedPlaceholder = NSAttributedString(string: textField?.placeholder, attributes: [NSForegroundColorAttributeName: UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0)), NSFontAttributeName: UIFont()])
                textField?.textColor = UIColor.stasherText()
            }
        }
        registerButton.titleLabel?.font = UIFont(size: 13.0)
        txtFieldFirstName.autocapitalizationType = .words
        txtFieldLastName.autocapitalizationType = .words
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if countryNamesDictsArray == nil {
            var httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: false)
            httpReq.sendAsyncPostRequest(STASHER_BASE_URL, params: [
                kParamKeyAction : kAPIActionAllCountries
            ]
, json: true)
        }
        STSharedCustoms.sharedAddGestureInstance(withDelegate: self).addRightSwipeGestureRecognizerToMe()
        if registrationInfoDictionary[kParamKeyAvatar] != nil {
            var data = Data(base64Encoded: (registrationInfoDictionary[kParamKeyAvatar] as? Data), options: 0)
            profilePicButton.setBackgroundImage(UIImage(data: data!), for: .normal)
        }
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

    @IBAction func profilePictureButtonPressed(_ sender: Any) {
        if profilePhotoActionSheet != nil {
            profilePhotoActionSheet = nil
        }
        if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
            profilePhotoActionSheet = UIActionSheet(title: {0
        }
        else {
            profilePhotoActionSheet = UIActionSheet(title: {0
        }
        profilePhotoActionSheet?.actionSheetStyle = .blackTranslucent
        profilePhotoActionSheet?.alpha = 0.90
        profilePhotoActionSheet?.tag = 1
        profilePhotoActionSheet?.show(in: view)
    }

    @IBAction func registerButtonPressed(_ sender: Any) {
        if txtFieldFirstName.text.validateNotEmpty() && txtFieldAge.text.validateNotEmpty() {
            if tandcVC == nil {
                tandcVC = STTermsAndConditionsViewController(nibName: "STTermsAndConditionsViewController", bundle: Bundle.main)
            }
            tandcVC?.delegate = self
            tandcVC?.view?.frame = view.frame
            view.addSubview(tandcVC?.view, withAnimation: true)
        }
        else {
            UIAlertView.show(withTitle: "", message: "All fields are mandatory.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {

                }
            })
        }
    }

    func cancelButtonPressed() {
        if tandcVC != nil {
            tandcVC?.view?.remove(fromSuperviewwithAnimation: true)
            tandcVC = nil
        }
    }

    func acceptButtonPressed() {
        if txtFieldFirstName.text.validateNotEmpty() && txtFieldAge.text.validateNotEmpty() {
            registrationInfoDictionary[kParamKeyFirstname] = txtFieldFirstName.text
            if txtFieldLastName.text.validateNotEmpty() {
                registrationInfoDictionary[kParamKeyLastname] = txtFieldLastName.text
            }
            //[self.registrationInfoDictionary setObject:self.txtFieldGender.text forKey:kParamKeyGender];
            registrationInfoDictionary[kParamKeyDateOfBirth] = selectedDOBStr
            //[self.registrationInfoDictionary setObject:[NSNumber numberWithInt:countryID] forKey:kParamKeyCountry];
            if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
                registrationInfoDictionary[kParamKeyIsParent] = "\("yes")"
            }
            if STUserIdentity.sharedInstance().userIdentity() == CHILDUSER {
                registrationInfoDictionary[kParamKeyIsParent] = "\("no")"
            }
            if profilePickerImageData == nil {
                if registrationInfoDictionary[kParamKeyAvatar] != nil {
                    registrationInfoDictionary[kParamKeyAvatar] = registrationInfoDictionary[kParamKeyAvatar]
                }
            }
            else {
                registrationInfoDictionary[kParamKeyAvatar] = profilePickerImageData?.base64EncodedString(withOptions: 0)
            }
            if deviceTokenStr != nil {
                registrationInfoDictionary["uid"] = deviceTokenStr
            }
            STUserIdentity.sharedInstance().userInformationDictionary = registrationInfoDictionary
            var httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
            registrationInfoDictionary[kParamKeyAction] = kAPIActionRegister
            httpReq.sendAsyncPostRequest(STASHER_BASE_URL, params: registrationInfoDictionary, json: true)
            view.userInteractionEnabled = false
        }
        else {
            UIAlertView.show(withTitle: "", message: "All fields are mandatory.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {

                }
            })
        }
    }

    @IBAction func dateOfBirthButtonPressed(_ sender: Any) {
        if currentTextField != nil {
            currentTextField?.resignFirstResponder()
        }
        dobPickerContainerView.backgroundColor = UIColor.stasherPopUpBG()
        dobPickerContainerView.clipsToBounds = true
        dobPickerContainerView.layer.cornerRadius = 10.0
        dobPickerContainerView.layer.borderColor = UIColor.lightGray.cgColor
        dobPickerContainerView.layer.borderWidth = 1.0
        dobPickerContainerView.isHidden = false
        transparentImageBG.setHidden(animated: false)
        buttonCloseBackGroundPopUp.isHidden = false
        //[self.dobDatePicker setMaximumDate:[NSDate date]];
    }

    @IBAction func dobPickerDoneButtonPressed(_ sender: Any) {
        dobPickerContainerView.isHidden = true
        transparentImageBG.setHidden(animated: true)
        buttonCloseBackGroundPopUp.isHidden = true
        var dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        var theDate: String = dateFormat.string(from: dobDatePicker.date)
        selectedDOBStr = theDate
        var dateFormat2 = DateFormatter()
        dateFormat2.dateFormat = "MMMM d, YYYY"
        var dateStr: String = dateFormat2.string(from: dateFormat.date(fromString: theDate))
        txtFieldAge.text = dateStr
    }

    @IBAction func dobPickerCancelButtonPressed(_ sender: Any) {
        dobPickerContainerView.isHidden = true
        transparentImageBG.setHidden(animated: true)
        buttonCloseBackGroundPopUp.isHidden = true
    }

    @IBAction func genderButtonPressed(_ sender: Any) {
        if currentTextField != nil {
            currentTextField?.resignFirstResponder()
        }
        if genderActionSheet != nil {
            genderActionSheet = nil
        }
        genderActionSheet = UIActionSheet(title: {0
        genderActionSheet?.addButton(withTitle: "\("Male")")
        genderActionSheet?.addButton(withTitle: "\("Female")")
        genderActionSheet?.addButton(withTitle: "Cancel")
        genderActionSheet?.cancelButtonIndex = 2
        if genderActionSheet != nil {
            genderActionSheet?.show(in: view)
        }
    }

    @IBAction func countryButtonPressed(_ sender: Any) {
        if currentTextField != nil {
            currentTextField?.resignFirstResponder()
        }
        if countryNamesActionSheet == nil {
            //[self prepareCountriesActionsheet];
        }
        //[countryNamesActionSheet showInView:self.view];
        if countryNamesVC != nil {
            countryNamesVC?.view?.removeFromSuperview()
            countryNamesVC = nil
        }
        countryNamesVC = STCountryNamesViewController(nibName: "STCountryNamesViewController", bundle: Bundle.main, andCountryArray: countryNamesDictsArray)
        countryNamesVC?.view?.frame = view.frame
        countryNamesVC?.delegate = self
        view.addSubview(countryNamesVC?.view, withAnimation: true)
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func rightGestureHandle() {
        navigationController?.popViewController(animated: true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: nil)
    }
// MARK: ----- Custm Methods

    func prepareCountriesActionsheet() {
        if countryNamesActionSheet != nil {
            countryNamesActionSheet = nil
        }
        countryNamesActionSheet = UIActionSheet(title: {0
        countryNamesActionSheet?.delegate = self
        for countryDict: [AnyHashable: Any] in countryNamesDictsArray {
            countryNamesActionSheet?.addButton(withTitle: "\(countryDict["country_name"])")
        }
        countryNamesActionSheet?.addButton(withTitle: "Cancel")
        countryNamesActionSheet?.cancelButtonIndex = countryNamesDictsArray.count
    }

    func launchStepThreeRegistration() {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var registerStepthreeVC: STRegisterStepThreeViewController? = storyboard.instantiateViewController(withIdentifier: "RegisterStepThreeViewController")
        navigationController?.pushViewController(registerStepthreeVC, animated: true)
    }
// MARK: ----- Textfield Methods

    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
        if !IS_STANDARD_IPHONE_6_PLUS {
            if textField == txtFieldAge {
                var viewFrame: CGRect = view.frame
                viewFrame.origin.y = -80.0
                //[self.view setFrame:viewFrame];
                containerScrollView.setContentOffset(CGPoint(x: CGFloat(0), y: CGFloat(80.0)), animated: true)
            }
            if isiPhone4s {
                var viewFrame: CGRect = view.frame
                viewFrame.origin.y = -80.0
                //[self.view setFrame:viewFrame];
                containerScrollView.setContentOffset(CGPoint(x: CGFloat(0), y: CGFloat(80.0)), animated: true)
            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if !IS_STANDARD_IPHONE_6_PLUS {
            textField.resignFirstResponder()
            var viewFrame: CGRect = view.frame
            viewFrame.origin.y = 0.0
            //[self.view setFrame:viewFrame];
            containerScrollView.setContentOffset(CGPoint(x: CGFloat(0), y: CGFloat(0)), animated: true)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFieldFirstName {
            textField.resignFirstResponder()
            txtFieldLastName.becomeFirstResponder()
        }
        else if textField == txtFieldLastName {
            textField.resignFirstResponder()
            dateOfBirthButtonPressed(nil)
        }
        else {
            textField.resignFirstResponder()
        }

        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var shouldChange: Bool = true
        if textField == txtFieldFirstName || textField == txtFieldLastName {
            if string.validateAlpha() {
                shouldChange = true
            }
            else {
                shouldChange = false
            }
        }
        else {
            shouldChange = true
        }
        return shouldChange
    }
// MARK: ----- ImagePicker Delegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPicking image: UIImage, editingInfo: [AnyHashable: Any]) {
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [AnyHashable: Any]) {
        if picker.sourceType == .camera {
            picker.dismiss(animated: true, completion: { _ in })
            var image: UIImage? = (info["UIImagePickerControllerOriginalImage"] as? UIImage)
            profilePicButton.setBackgroundImage(image, for: .normal)
            profilePickerImageData = Data(data: .uiImageJPEGRepresentation())
        }
        else {
            picker.dismiss(animated: true, completion: { _ in })
            var image: UIImage? = (info["UIImagePickerControllerOriginalImage"] as? UIImage)
            profilePicButton.setBackgroundImage(image, for: .normal)
            profilePickerImageData = Data(data: .uiImageJPEGRepresentation())
        }
    }
// MARK: ----- Actionsheet Delegate

    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonat buttonIndex: Int) {
        if actionSheet == countryNamesActionSheet {
            if countryNamesDictsArray.count > buttonIndex {
                txtFieldCountry.text = countryNamesDictsArray[buttonIndex]["country_name"]
                countryID = CInt(countryNamesDictsArray[buttonIndex]["id"])
            }
        }
        else if actionSheet == genderActionSheet {
            if buttonIndex != actionSheet.cancelButtonIndex {
                txtFieldGender.text = actionSheet.buttonTitle(at: buttonIndex)
            }
        }
        else if actionSheet == profilePhotoActionSheet {
            switch actionSheet.tag {
                case 1:
                    switch buttonIndex {
                        case 0:
#if TARGET_IPHONE_SIMULATOR
                            var alert = UIAlertView(title: "", message: "Camera not available.", delegate: nil, cancelButtonTitle: "OK", otherButtonTitles: "")
                            alert.show()
#elseif TARGET_OS_IPHONE
                            var picker = UIImagePickerController()
                            picker.sourceType = .camera
                            picker.delegate = self
                            //picker.allowsEditing = YES;
                            present(picker, animated: true, completion: { _ in })
#endif
                        case 1:
                            var pickerController = UIImagePickerController()
                            pickerController.delegate = self
                            pickerController.sourceType = .photoLibrary
                            present(pickerController, animated: true, completion: { _ in })
                        case 2:
                            if STUserIdentity.sharedInstance().userIdentity() == CHILDUSER {
                                if avatarSelectVC != nil {
                                    avatarSelectVC?.delegate = nil
                                    avatarSelectVC = nil
                                }
                                avatarSelectVC = STAvatarsViewController(nibName: "STAvatarsViewController", bundle: nil)
                                avatarSelectVC?.delegate = self
                                navigationController?.pushViewController(avatarSelectVC, animated: true)
                            }
                    }

                default:
                    break
            }
        }

    }
// MARK: ----- CountryNamesDelegate

    func countryNamesViewOkPressed(withCountryId selectedCountryIndex: Int) {
        if countryNamesDictsArray && countryNamesDictsArray.count > selectedCountryIndex {
            txtFieldCountry.text = countryNamesDictsArray[selectedCountryIndex]["country_name"]
            countryID = CInt(countryNamesDictsArray[selectedCountryIndex]["id"])
        }
        if countryNamesVC != nil {
            countryNamesVC?.view?.remove(fromSuperviewwithAnimation: true)
            countryNamesVC = nil
        }
    }

    func countryNamesViewCancelPressed() {
        if countryNamesVC != nil {
            countryNamesVC?.view?.remove(fromSuperviewwithAnimation: true)
            countryNamesVC = nil
        }
    }
// MARK: ----- AvatarVC Delegate

    func avatarSelected(withImgName imgNameStr: String) {
        profilePicButton.setBackgroundImage(UIImage(named: imgNameStr), for: .normal)
        profilePickerImageData = UIImagePNGRepresentation(UIImage(named: imgNameStr))
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDictionary != nil {
                var actionName: String? = ((conn.userInfo?[KParamsKey] as? String)?[kParamKeyAction] as? String)
                if (actionName == kAPIActionAllCountries) {
                    countryNamesDictsArray = responseDictionary?["countries"]
                    prepareCountriesActionsheet()
                }
                else if (actionName == kAPIActionRegister) {
                    view.userInteractionEnabled = true
                    if responseDictionary?["success"] != nil {
                        if responseDictionary?["success"] {
                            if responseDictionary?["usedetails"] && (responseDictionary?["usedetails"] is [AnyHashable: Any]) {
                                STUserIdentity.sharedInstance().userInformationDictionary = responseDictionary?["usedetails"]
                                var logInInfoDictionary: [AnyHashable: Any]? = (responseDictionary?["usedetails"] as? [AnyHashable: Any])?
                                logInInfoDictionary?[kUserDefaultsIsUserLoggedIn] = Int(1)
                                STLogInManager.sharedInstance().updateUserDefaultsInLogInManager(withDictionary: logInInfoDictionary)
                            }
                            UIAlertView.show(withTitle: "", message: "Thanks for registering! We’ve sent you an email with your account details.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                                if buttonIndex == alertView.cancelButtonIndex {
                                    if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
                                        self.launchStepThreeRegistration()
                                    }
                                    else {
                                        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                        var baseTabBarController: STBaseTabBarController? = storyboard.instantiateViewController(withIdentifier: "STBaseTabBarController")
                                        navigationController?.pushViewController(baseTabBarController, animated: true)
                                    }
                                }
                            })
                        }
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
        view.userInteractionEnabled = true
        if error != nil {

        }
    }
}