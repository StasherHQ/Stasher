//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STCreateChildViewController.swift
//  Stasher
//
//  Created by bhushan on 20/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STCreateChildViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, STSharedCustomsDelegate, CountryNamesViewDelegate, AvatarVCDelegate {
    var currentTextfield: UITextField?
    var countryNamesActionSheet: UIActionSheet?
    var countryID: Int = 0
    var genderActionSheet: UIActionSheet?
    var countryNamesVC: STCountryNamesViewController?
    var avatarSelectVC: STAvatarsViewController?
    var profilePhotoActionSheet: UIActionSheet?
    var selectedDOBStr: String = ""

    @IBOutlet var headerLabel: UILabel!
    var countryNamesDictsArray = [Any]()
    var registrationInfoDictionary = [AnyHashable: Any]()
    @IBOutlet var scrollViewTextFields: UIScrollView!
    @IBOutlet var txtfieldEmailAddress: UITextField!
    @IBOutlet var txtfieldusername: UITextField!
    @IBOutlet var txtfieldFirstname: UITextField!
    @IBOutlet var txtfieldLastname: UITextField!
    @IBOutlet var txtfieldPassword: UITextField!
    @IBOutlet var txtfieldGender: UITextField!
    @IBOutlet var txtfieldCountry: UITextField!
    @IBOutlet var txtfieldDob: UITextField!
    @IBOutlet var profilePicButton: UIButton!
    @IBOutlet var profilePicImageView: UIImageView!
    @IBOutlet var dobDatePicker: UIDatePicker!
    @IBOutlet var dobPickerContainerView: UIView!
    @IBOutlet var dobPickerDoneButton: UIButton!
    @IBOutlet var createChildButton: UIButton!
    @IBOutlet var createChildPopUpButton: UIButton!
    @IBOutlet var relationOptionView: UIView!
    @IBOutlet var parentRelationButton: UIButton!
    @IBOutlet var familyRelationButton: UIButton!
    @IBOutlet var friendRelationButton: UIButton!
    @IBOutlet var txtfieldContainerView: UIView!
    var relationshipEnum = RelationShipToChild()
    var profilePickerImageData: Data?
    @IBOutlet var popUpBGImageView: UIImageView!
    @IBOutlet var popUpBGCloseButton: UIButton!
    @IBOutlet var selectDOBlabel: UILabel!
    @IBOutlet var dobPopUpOkButton: UIButton!
    @IBOutlet var dobPopUpCancelButton: UIButton!
    @IBOutlet var imgViewparentBullet: UIImageView!
    @IBOutlet var imgViewFamilyBullet: UIImageView!
    @IBOutlet var imgViewFriendBullet: UIImageView!
    @IBOutlet var labelHeadingChooseRelation: UILabel!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if countryNamesDictsArray == nil {
            var httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: false)
            httpReq.sendAsyncPostRequest(STASHER_BASE_URL, params: [
                kParamKeyAction : kAPIActionAllCountries
            ]
, json: true)
        }
        if !registrationInfoDictionary.isEmpty {
            registrationInfoDictionary = nil
        }
        registrationInfoDictionary = [AnyHashable: Any]()
        relationOptionView.isHidden = true
        relationshipEnum = PARENT
        parentRelationButton.setTitleColor(UIColor.blue, for: .normal)
        familyRelationButton.setTitleColor(UIColor.white, for: .normal)
        friendRelationButton.setTitleColor(UIColor.white, for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        headerLabel.font = UIFont()
        for txtFields: Any in txtfieldContainerView.subviews {
            if (txtFields is UITextField) {
                var textField: UITextField? = (txtFields as? UITextField)
                textField?.font = UIFont()
                textField?.attributedPlaceholder = NSAttributedString(string: textField?.placeholder, attributes: [NSForegroundColorAttributeName: UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0)), NSFontAttributeName: UIFont()])
                textField?.textColor = UIColor.stasherText()
            }
        }
        txtfieldFirstname.autocapitalizationType = .words
        txtfieldLastname.autocapitalizationType = .words
        profilePicButton.clipsToBounds = true
        profilePicButton.layer.cornerRadius = profilePicButton.frame.size.width / 2.0
        profilePicButton.layer.borderColor = UIColor.clear.cgColor
        profilePicButton.layer.borderWidth = 2.0
        profilePicImageView.clipsToBounds = true
        profilePicImageView.layer.cornerRadius = profilePicButton.frame.size.width / 2.0
        profilePicImageView.layer.borderColor = UIColor.clear.cgColor
        profilePicImageView.layer.borderWidth = 2.0
        profilePicImageView.contentMode = .scaleAspectFill
        createChildButton.titleLabel?.font = UIFont(size: 11.0)
        dobPickerContainerView.clipsToBounds = true
        dobPickerContainerView.layer.cornerRadius = 10.0
        dobPickerContainerView.layer.borderColor = UIColor.lightGray.cgColor
        dobPickerContainerView.layer.borderWidth = 1.0
        dobPickerContainerView.backgroundColor = UIColor.stasherPopUpBG()
        dobPopUpOkButton.titleLabel?.font = UIFont(size: 13.0)
        dobPopUpCancelButton.titleLabel?.font = UIFont(size: 13.0)
        selectDOBlabel.font = UIFont.fontGothamRoundedMedium(withSize: 13.0)
        relationOptionView.clipsToBounds = true
        relationOptionView.layer.cornerRadius = 10.0
        relationOptionView.layer.borderColor = UIColor.lightGray.cgColor
        relationOptionView.layer.borderWidth = 2.0
        relationOptionView.backgroundColor = UIColor.stasherPopUpBG()
        labelHeadingChooseRelation.font = UIFont.fontGothamRoundedMedium(withSize: 13.0)
        labelHeadingChooseRelation.textColor = UIColor.stasherText()
        createChildButton.titleLabel?.font = UIFont(size: 11.0)
        parentRelationButton.titleLabel?.font = UIFont(size: 11.0)
        familyRelationButton.titleLabel?.font = UIFont(size: 11.0)
        friendRelationButton.titleLabel?.font = UIFont(size: 11.0)
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
// MARK: ----- Actions

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func rightGestureHandle() {
        navigationController?.popViewController(animated: true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: nil)
    }

    @IBAction func profilePictureButtonPressed(_ sender: Any) {
        /*
            UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
            pickerController.delegate = self;
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:pickerController animated:YES completion:nil];
             */
        if profilePhotoActionSheet != nil {
            profilePhotoActionSheet = nil
        }
        profilePhotoActionSheet = UIActionSheet(title: {0
        profilePhotoActionSheet?.actionSheetStyle = .blackTranslucent
        profilePhotoActionSheet?.alpha = 0.90
        profilePhotoActionSheet?.tag = 1
        profilePhotoActionSheet?.show(in: view)
    }

    @IBAction func createChildButtonPressed(_ sender: Any) {
        parentRelationButton.setTitleColor(UIColor.stasherText(), for: .normal)
        friendRelationButton.setTitleColor(UIColor.stasherText(), for: .normal)
        familyRelationButton.setTitleColor(UIColor.stasherText(), for: .normal)
        createChildPopUpButton.titleLabel?.font = UIFont(size: 11.0)
        popUpBGCloseButton.setHidden(animated: false)
        popUpBGImageView.setHidden(animated: false)
        relationOptionView.setHidden(animated: false)
    }

    @IBAction func dateOfBirthButtonPressed(_ sender: Any) {
        if currentTextfield != nil {
            currentTextfield?.resignFirstResponder()
        }
        dobPickerContainerView.isHidden = false
        popUpBGCloseButton.isHidden = false
        popUpBGImageView.setHidden(animated: false)
        //[self.dobDatePicker setMaximumDate:[NSDate date]];
    }

    @IBAction func dobPickerDoneButtonPressed(_ sender: Any) {
        dobPickerContainerView.isHidden = true
        popUpBGCloseButton.isHidden = true
        popUpBGImageView.setHidden(animated: true)
        var dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        var theDate: String = dateFormat.string(from: dobDatePicker.date)
        selectedDOBStr = theDate
        var dateFormat2 = DateFormatter()
        dateFormat2.dateFormat = "MMMM d, YYYY"
        var dateStr: String = dateFormat2.string(from: dateFormat.date(fromString: theDate))
        txtfieldDob.text = dateStr
    }

    @IBAction func dobPopUpCloseButtonPressed(_ sender: Any) {
        dobPickerContainerView.isHidden = true
        popUpBGCloseButton.isHidden = true
        popUpBGImageView.setHidden(animated: true)
        relationOptionView.setHidden(animated: true)
    }

    @IBAction func genderButtonPressed(_ sender: Any) {
        if currentTextfield != nil {
            currentTextfield?.resignFirstResponder()
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
        if currentTextfield != nil {
            currentTextfield?.resignFirstResponder()
        }
        if countryNamesVC != nil {
            countryNamesVC?.view?.removeFromSuperview()
            countryNamesVC = nil
        }
        countryNamesVC = STCountryNamesViewController(nibName: "STCountryNamesViewController", bundle: Bundle.main, andCountryArray: countryNamesDictsArray)
        countryNamesVC?.view?.frame = view.frame
        countryNamesVC?.delegate = self
        view.addSubview(countryNamesVC?.view, withAnimation: true)
    }

    @IBAction func parentRelationButtonPressed(_ sender: Any) {
        relationshipEnum = PARENT
        imgViewparentBullet.image = UIImage(named: "buletbutton_Active")
        imgViewFamilyBullet.image = UIImage(named: "buletbutton_Inactive")
        imgViewFriendBullet.image = UIImage(named: "buletbutton_Inactive")
    }

    @IBAction func familyRelationButtonPressed(_ sender: Any) {
        relationshipEnum = FAMILY
        imgViewparentBullet.image = UIImage(named: "buletbutton_Inactive")
        imgViewFamilyBullet.image = UIImage(named: "buletbutton_Active")
        imgViewFriendBullet.image = UIImage(named: "buletbutton_Inactive")
    }

    @IBAction func friendRelationButtonPressed(_ sender: Any) {
        relationshipEnum = FRIEND
        imgViewparentBullet.image = UIImage(named: "buletbutton_Inactive")
        imgViewFamilyBullet.image = UIImage(named: "buletbutton_Inactive")
        imgViewFriendBullet.image = UIImage(named: "buletbutton_Active")
    }

    @IBAction func createChild(onRelationViewButtonPressed sender: Any) {
        popUpBGCloseButton.isHidden = true
        popUpBGImageView.setHidden(animated: true)
        relationOptionView.setHidden(animated: true)
        if txtfieldusername.text.validateNotEmpty() && txtfieldPassword.text.validateNotEmpty() && txtfieldFirstname.text.validateNotEmpty() && txtfieldEmailAddress.text.validateNotEmpty() && txtfieldDob.text.validateNotEmpty() {
            if txtfieldEmailAddress.text.validateEmail() {
                if !registrationInfoDictionary.isEmpty {
                    registrationInfoDictionary[kParamKeyUsername] = txtfieldusername.text
                    registrationInfoDictionary[kParamKeyDateOfBirth] = selectedDOBStr
                    registrationInfoDictionary[kParamKeyEmail] = txtfieldEmailAddress.text
                    registrationInfoDictionary[kParamKeyFirstname] = txtfieldFirstname.text
                    if txtfieldLastname.text.validateNotEmpty() {
                        registrationInfoDictionary[kParamKeyLastname] = txtfieldLastname.text
                    }
                    registrationInfoDictionary[kParamKeyPassword] = txtfieldPassword.text
                    registrationInfoDictionary[kParamKeyIsParent] = "no"
                    registrationInfoDictionary[kParamKeyAction] = kAPIActionRegister
                    registrationInfoDictionary["relation_type"] = Int(relationshipEnum)
                    var httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: false)
                    httpReq.sendAsyncPostRequest(STASHER_BASE_URL, params: registrationInfoDictionary, json: true)
                }
            }
            else {
                UIAlertView.show(withTitle: "", message: "Enter a valid E-mail address.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                    if buttonIndex == alertView.cancelButtonIndex {
                        self.txtfieldEmailAddress.becomeFirstResponder()
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
// MARK: ----- Textfield Methods

    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextfield = textField
        if !IS_STANDARD_IPHONE_6_PLUS {
            if textField == txtfieldDob || textField == txtfieldLastname || textField == txtfieldFirstname {
                var viewFrame: CGRect = view.frame
                viewFrame.origin.y = -130.0
                //[self.view setFrame:viewFrame];
                scrollViewTextFields.setContentOffset(CGPoint(x: CGFloat(0), y: CGFloat(130.0)), animated: true)
            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        var viewFrame: CGRect = view.frame
        viewFrame.origin.y = 0.0
        //[self.view setFrame:viewFrame];
        scrollViewTextFields.setContentOffset(CGPoint(x: CGFloat(0), y: CGFloat(0)), animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtfieldEmailAddress {
            txtfieldusername.becomeFirstResponder()
        }
        else if textField == txtfieldusername {
            txtfieldPassword.becomeFirstResponder()
        }
        else if textField == txtfieldPassword {
            txtfieldFirstname.becomeFirstResponder()
        }
        else if textField == txtfieldFirstname {
            txtfieldLastname.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }

        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var shouldChange: Bool = true
        if textField == txtfieldFirstname || textField == txtfieldLastname {
            if string.validateAlpha() {
                shouldChange = true
            }
            else {
                shouldChange = false
            }
        }
        else if textField == txtfieldusername || textField == txtfieldPassword {
            if string.validateAlphanumeric() {
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
// MARK: ----- Custm Methods

    func countryNamesViewOkPressed(withCountryId selectedCountryIndex: Int) {
        if countryNamesDictsArray.count > selectedCountryIndex {
            txtfieldCountry.text = countryNamesDictsArray[selectedCountryIndex]["country_name"]
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

    func prepareCountriesActionsheet() {
        if countryNamesActionSheet != nil {
            countryNamesActionSheet = nil
        }
        countryNamesActionSheet = UIActionSheet(title: {0
        for countryDict: [AnyHashable: Any] in countryNamesDictsArray {
            countryNamesActionSheet?.addButton(withTitle: "\(countryDict["country_name"])")
        }
        countryNamesActionSheet?.addButton(withTitle: "Cancel")
        countryNamesActionSheet?.cancelButtonIndex = countryNamesDictsArray.count
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
            performSelector(#selector(self.addProfileImageDataToRequestDict), withObject: nil, afterDelay: 0.1)
        }
        else {
            picker.dismiss(animated: true, completion: { _ in })
            var image: UIImage? = (info["UIImagePickerControllerOriginalImage"] as? UIImage)
            profilePicButton.setBackgroundImage(image, for: .normal)
            profilePickerImageData = Data(data: .uiImageJPEGRepresentation())
            performSelector(#selector(self.addProfileImageDataToRequestDict), withObject: nil, afterDelay: 0.1)
        }
    }

    func addProfileImageDataToRequestDict() {
        registrationInfoDictionary[kParamKeyAvatar] = profilePickerImageData?.base64EncodedString(withOptions: 0)
    }
// MARK: ----- AvatarVC Delegate

    func avatarSelected(withImgName imgNameStr: String) {
        profilePicButton.setBackgroundImage(UIImage(named: imgNameStr), for: .normal)
        profilePickerImageData = UIImagePNGRepresentation(UIImage(named: imgNameStr))
    }
// MARK: ----- Actionsheet Delegate

    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonat buttonIndex: Int) {
        if actionSheet == countryNamesActionSheet {
            if countryNamesDictsArray.count > buttonIndex {
                txtfieldCountry.text = countryNamesDictsArray[buttonIndex]["country_name"]
                countryID = CInt(countryNamesDictsArray[buttonIndex]["id"])
            }
        }
        else if actionSheet == genderActionSheet {
            if buttonIndex != actionSheet.cancelButtonIndex {
                txtfieldGender.text = actionSheet.buttonTitle(at: buttonIndex)
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
                            if avatarSelectVC != nil {
                                avatarSelectVC?.delegate = nil
                                avatarSelectVC = nil
                            }
                            avatarSelectVC = STAvatarsViewController(nibName: "STAvatarsViewController", bundle: nil)
                            avatarSelectVC?.delegate = self
                            navigationController?.pushViewController(avatarSelectVC, animated: true)
                    }

                default:
                    break
            }
        }

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
                    if responseDictionary?["success"] != nil {
                        if responseDictionary?["success"] {
                            UIAlertView.show(withTitle: "", message: responseDictionary?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                                if buttonIndex == alertView.cancelButtonIndex {
                                    navigationController?.popViewController(animated: true)
                                }
                            })
                        }
                    }
                    else if responseDictionary?["error"] != nil {
                        if responseDictionary?["error"] {
                            UIAlertView.show(withTitle: "", message: responseDictionary?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                                if buttonIndex == alertView.cancelButtonIndex {

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