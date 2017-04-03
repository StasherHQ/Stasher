//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STEditProfileViewController.swift
//  Stasher
//
//  Created by bhushan on 19/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol EditProfileDelegate: NSObjectProtocol {
    func profileSuccessfullyEdited()

    func passwordChangedLogInAgain()
}
class STEditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ChangePasswordDelegate, STSharedCustomsDelegate, UIActionSheetDelegate {
    var currentTextField: UITextField?
    var httpReq: BOABHttpReq?
    var profilePhotoActionSheet: UIActionSheet?
    var selectedDOBDateStr: String = ""

    weak var delegate: EditProfileDelegate?
    @IBOutlet var headerlabel: UILabel!
    var editProfileParamDictionary = [AnyHashable: Any]()
    @IBOutlet var dobDatePicker: UIDatePicker!
    @IBOutlet var dobPickerContainerView: UIView!
    @IBOutlet var txtFieldUsername: UITextField!
    @IBOutlet var txtFieldFirstName: UITextField!
    @IBOutlet var txtFieldLastName: UITextField!
    @IBOutlet var txtFieldBob: UITextField!
    @IBOutlet var profilePicButton: UIButton!
    @IBOutlet var profilePicImageView: UIImageView!
    @IBOutlet var backButton: UIButton!
    var profilePickerImageData: Data?
    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet var saveProfileButton: UIButton!
    @IBOutlet var changePasswordButton: UIButton!
    @IBOutlet var transparentImageView: UIImageView!
    @IBOutlet var buttonClosePopUp: UIButton!
    @IBOutlet var selectDOBPopUpLabel: UILabel!
    @IBOutlet var okButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var labelHeadingUsername: UILabel!
    @IBOutlet var labelHeadingFirstName: UILabel!
    @IBOutlet var labelHeadingLastName: UILabel!
    @IBOutlet var labelHeadingDOB: UILabel!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        txtFieldUsername.text = STUserIdentity.sharedInstance().username
        txtFieldFirstName.text = STUserIdentity.sharedInstance().firstName
        txtFieldLastName.text = STUserIdentity.sharedInstance().lastName
        var dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        var theDate: Date? = dateFormat.date(fromString: STUserIdentity.sharedInstance().dateOfBirth())
        var dateFormat2 = DateFormatter()
        dateFormat2.dateFormat = "MMMM d, YYYY"
        var dateStr: String = dateFormat2.string(from: theDate)
        txtFieldBob.text = dateStr
        if !editProfileParamDictionary.isEmpty {
            editProfileParamDictionary = nil
        }
        editProfileParamDictionary = [AnyHashable: Any]()
        if !(STUserIdentity.sharedInstance().avatarUrlString() is NSNull) && !(STUserIdentity.sharedInstance().avatarUrlString() == "") {
            profilePicImageView.setImageWith(URL(string: STUserIdentity.sharedInstance().avatarUrlString()), placeholderImage: UIImage(named: "account_face_placeholder"))
        }
        else {
            profilePicImageView.image = UIImage(named: "account_face_placeholder")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        headerlabel.font = UIFont()
        for txtFields: Any in containerScrollView.subviews {
            if (txtFields is UITextField) {
                var textField: UITextField? = (txtFields as? UITextField)
                textField?.font = UIFont()
                textField?.attributedPlaceholder = NSAttributedString(string: textField?.placeholder, attributes: [NSForegroundColorAttributeName: UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0)), NSFontAttributeName: UIFont()])
                textField?.textColor = UIColor.stasherText()
            }
        }
        txtFieldFirstName.autocapitalizationType = .words
        txtFieldLastName.autocapitalizationType = .words
        //Clip/Clear the other pieces whichever outside the rounded corner
        profilePicButton.clipsToBounds = true
        profilePicButton.layer.cornerRadius = 80 / 2.0
        profilePicButton.layer.borderColor = UIColor.clear.cgColor
        profilePicButton.layer.borderWidth = 0.5
        profilePicImageView.clipsToBounds = true
        profilePicImageView.layer.cornerRadius = 80 / 2.0
        profilePicImageView.layer.borderColor = UIColor.clear.cgColor
        profilePicImageView.layer.borderWidth = 2.0
        profilePicImageView.contentMode = .scaleAspectFill
        changePasswordButton.titleLabel?.font = UIFont(size: 11.0)
        saveProfileButton.titleLabel?.font = UIFont(size: 11.0)
        dobPickerContainerView.clipsToBounds = true
        dobPickerContainerView.layer.cornerRadius = 10.0
        dobPickerContainerView.layer.borderColor = UIColor.lightGray.cgColor
        dobPickerContainerView.layer.borderWidth = 2.0
        dobPickerContainerView.backgroundColor = UIColor.stasherPopUpBG()
        okButton.titleLabel?.font = UIFont.fontGothamRoundedMedium(withSize: 13.0)
        cancelButton.titleLabel?.font = UIFont.fontGothamRoundedMedium(withSize: 13.0)
        selectDOBPopUpLabel.font = UIFont.fontGothamRoundedMedium(withSize: 13.0)
        selectDOBPopUpLabel.textColor = UIColor.stasherText()
        labelHeadingFirstName.textColor = UIColor.stasherText()
        labelHeadingLastName.textColor = UIColor.stasherText()
        labelHeadingUsername.textColor = UIColor.stasherText()
        labelHeadingDOB.textColor = UIColor.stasherText()
        labelHeadingFirstName.font = UIFont()
        labelHeadingLastName.font = UIFont()
        labelHeadingUsername.font = UIFont()
        labelHeadingDOB.font = UIFont()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: self).addRightSwipeGestureRecognizerToMe()
        if editProfileParamDictionary[kParamKeyAvatar] != nil {
            var data = Data(base64Encoded: (editProfileParamDictionary[kParamKeyAvatar] as? Data), options: 0)
            profilePicImageView.image = UIImage(data: data!)
        }
        containerScrollView.frame = CGRect(x: CGFloat(containerScrollView.frame.origin.x), y: CGFloat(containerScrollView.frame.origin.y), width: CGFloat(view.frame.size.width), height: CGFloat(containerScrollView.frame.size.height))
        containerScrollView.contentSize = CGSize(width: CGFloat(containerScrollView.frame.size.width), height: CGFloat(changePasswordButton.frame.origin.y + changePasswordButton.frame.size.height + 12.0))
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

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func rightGestureHandle() {
        navigationController?.popViewController(animated: true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: nil)
    }

    @IBAction func dateOfBirthButtonPressed(_ sender: Any) {
        if currentTextField != nil {
            currentTextField?.resignFirstResponder()
        }
        dobPickerContainerView.clipsToBounds = true
        dobPickerContainerView.layer.cornerRadius = 10.0
        dobPickerContainerView.layer.borderColor = UIColor.lightGray.cgColor
        dobPickerContainerView.layer.borderWidth = 1.0
        dobPickerContainerView.isHidden = false
        transparentImageView.setHidden(animated: false)
        buttonClosePopUp.isHidden = false
        //[self.dobDatePicker setMaximumDate:[NSDate date]];
    }

    @IBAction func dobPickerDoneButtonPressed(_ sender: Any) {
        dobPickerContainerView.isHidden = true
        transparentImageView.setHidden(animated: true)
        buttonClosePopUp.isHidden = true
        var dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        var theDate: String = dateFormat.string(from: dobDatePicker.date)
        //send this to server
        selectedDOBDateStr = theDate
        var dateFormat2 = DateFormatter()
        dateFormat2.dateFormat = "MMMM d, YYYY"
        var dateStr: String = dateFormat2.string(from: dateFormat.date(fromString: theDate))
        txtFieldBob.text = dateStr
    }

    @IBAction func dobPickerCancelButtonPressed(_ sender: Any) {
        dobPickerContainerView.isHidden = true
        transparentImageView.setHidden(animated: true)
        buttonClosePopUp.isHidden = true
    }

    @IBAction func saveEditedProfileButtonPressed(_ sender: Any) {
        editProfileParamDictionary[kParamKeyFirstname] = txtFieldFirstName.text
        if txtFieldLastName.text.validateNotEmpty() {
            editProfileParamDictionary[kParamKeyLastname] = txtFieldLastName.text
        }
        if selectedDOBDateStr == nil || (selectedDOBDateStr == "") {
            editProfileParamDictionary[kParamKeyDateOfBirth] = STUserIdentity.sharedInstance().dateOfBirth()
        }
        else {
            editProfileParamDictionary[kParamKeyDateOfBirth] = selectedDOBDateStr
        }
        editProfileParamDictionary[kParamKeyUsername] = txtFieldUsername.text
        if STUserIdentity.sharedInstance().country {
            editProfileParamDictionary[kParamKeyCountry] = STUserIdentity.sharedInstance().country
        }
        if STUserIdentity.sharedInstance().emailAddress() {
            editProfileParamDictionary[kParamKeyEmail] = STUserIdentity.sharedInstance().emailAddress()
        }
        if STUserIdentity.sharedInstance().userId() {
            editProfileParamDictionary[kParamKeyUserID] = STUserIdentity.sharedInstance().userId()
        }
        editProfileParamDictionary[kParamKeyAction] = kAPIActionEditProfile
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: editProfileParamDictionary, json: true)
    }

    @IBAction func changePasswordButtonPressed(_ sender: Any) {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var changePasswordVC: STChangePasswordViewController? = storyboard.instantiateViewController(withIdentifier: "STChangePasswordViewController")
        changePasswordVC?.delegate = self
        navigationController?.pushViewController(changePasswordVC, animated: true)
    }
// MARK: ----- ImagePicker Delegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPicking image: UIImage, editingInfo: [AnyHashable: Any]) {
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [AnyHashable: Any]) {
        if picker.sourceType == .camera {
            picker.dismiss(animated: true, completion: { _ in })
            var image: UIImage? = (info["UIImagePickerControllerOriginalImage"] as? UIImage)
            profilePicImageView.image = image
            profilePickerImageData = Data(data: .uiImageJPEGRepresentation())
            performSelector(#selector(self.addProfileImageDataToRequestDict), withObject: nil, afterDelay: 0.1)
        }
        else {
            picker.dismiss(animated: true, completion: { _ in })
            var image: UIImage? = (info["UIImagePickerControllerOriginalImage"] as? UIImage)
            profilePicImageView.image = image
            profilePickerImageData = Data(data: .uiImageJPEGRepresentation())
            performSelector(#selector(self.addProfileImageDataToRequestDict), withObject: nil, afterDelay: 0.1)
        }
    }

    func addProfileImageDataToRequestDict() {
        editProfileParamDictionary[kParamKeyAvatar] = profilePickerImageData?.base64EncodedString(withOptions: 0)
    }
// MARK: ----- Textfield Methods

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !IS_STANDARD_IPHONE_6 && !IS_STANDARD_IPHONE_6_PLUS {
            var viewFrame: CGRect = view.frame
            viewFrame.origin.y = -80.0
            view.frame = viewFrame
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
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        currentTextField = textField
        var shouldChange: Bool = true
        if textField == txtFieldUsername {
            if string.validateAlphanumeric() {
                shouldChange = true
            }
            else {
                shouldChange = false
            }
        }
        else if textField == txtFieldFirstName || textField == txtFieldLastName {
            if string.validateAlpha() {
                shouldChange = true
            }
            else {
                shouldChange = false
            }
        }

        return shouldChange
    }
// MARK: ----- Password Changed

    func passwordHasBeenChanged() {
        if delegate?.responds(to: #selector(self.passwordChangedLogInAgain)) {
            delegate?.passwordChangedLogInAgain()
            navigationController?.popViewController(animated: false)
        }
    }
// MARK: ----- Actionsheet Delegate

    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonat buttonIndex: Int) {
        if actionSheet == profilePhotoActionSheet {
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
                    }

                default:
                    break
            }
        }
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDict: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDict?["success"] {
                if delegate?.responds(to: #selector(self.profileSuccessfullyEdited)) {
                    delegate?.profileSuccessfullyEdited()
                }
                UIAlertView.show(withTitle: "", message: responseDict?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                    if buttonIndex == alertView.cancelButtonIndex {
                        navigationController?.popViewController(animated: true)
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