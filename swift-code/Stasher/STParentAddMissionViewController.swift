//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STParentAddMissionViewController.swift
//  Stasher
//
//  Created by bhushan on 24/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol ParentAddMissionDelegate: NSObjectProtocol {
    func missionUpdatedAdded()
}
class STParentAddMissionViewController: UIViewController, UINavigationControllerDelegate {
    var httpReq: BOABHttpReq?
    var childIdsArray = [Any]()
    var childBUttonArray = [Any]()

    weak var delegate: ParentAddMissionDelegate?
    var requestParamsDictionary = [AnyHashable: Any]()
    @IBOutlet var scrollViewChildrens: UIScrollView!
    @IBOutlet var scrollViewContainer: UIScrollView!
    @IBOutlet var missionTitleTextField: UITextField!
    @IBOutlet var missionDescriptionTextView: UITextView!
    @IBOutlet var missionDateTimePicker: UIDatePicker!
    @IBOutlet var missionSetDateButton: UIButton!
    @IBOutlet var switchRewardType: UISwitch!
    @IBOutlet var rewardTextField: UITextField!
    @IBOutlet var assignMissionButton: UIButton!
    @IBOutlet var saveDraftMissionButton: UIButton!
    @IBOutlet var switchTimeBased: UISwitch!
    @IBOutlet var switchMissionScope: UISwitch!
    @IBOutlet var dateTimePickerContainerView: UIView!
    var isEditMode: Bool = false
    var isMissionDetailMode: Bool = false
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var transparentImageView: UIImageView!
    @IBOutlet var buttonClosePopUp: UIButton!
    @IBOutlet var labelMissionDescCharLimit: UILabel!
    @IBOutlet var labelMissionNameCharLimit: UILabel!
    @IBOutlet var controlsContainerView: UIView!
    @IBOutlet var labelHeadingSelectChild: UILabel!
    @IBOutlet var labelHeadingIsTimeBased: UILabel!
    @IBOutlet var labelHeadingReward: UILabel!
    @IBOutlet var labelHeadingMissionScope: UILabel!
    @IBOutlet var buttonDatePickerOk: UIButton!
    @IBOutlet var buttonDatePickerCancel: UIButton!
    @IBOutlet var labelSelectMissionDate: UILabel!
    @IBOutlet var labelSelectDueDateTime: UILabel!
    @IBOutlet var rewardCustomSwitch: UIView!
    @IBOutlet var buttonSwitchCash: UIButton!
    @IBOutlet var buttonSwitchGift: UIButton!
    @IBOutlet var imgViewGreen: UIImageView!
    @IBOutlet var timeBasedCustomSwitchView: UIView!
    @IBOutlet var buttonSwitchYes: UIButton!
    @IBOutlet var buttonSwitchNo: UIButton!
    @IBOutlet var imgViewGreenTimeSwitch: UIImageView!
    @IBOutlet var scopeCustomSwitchView: UIView!
    @IBOutlet var buttonSwitchPublic: UIButton!
    @IBOutlet var buttonSwitchPrivate: UIButton!
    @IBOutlet var imgViewGreenScopeSwitch: UIImageView!

    func editMissionRefreshView(withDictionary dict: [AnyHashable: Any]) {
        requestParamsDictionary = dict
    }


    override func viewWillAppear(_ animated: Bool) {
        if isEditMode {
            headerLabel.text = "Edit Mission"
            prePopulateControlsForEditMission()
            assignMissionButton.setTitle("Save", for: .normal)
        }
        else if isMissionDetailMode {
            headerLabel.text = "Mission Details"
            prePopulateControlsForEditMission()
        }
        else {
            headerLabel.text = "Add Mission"
            assignMissionButton.setTitle("Assign Mission", for: .normal)
        }

        refreshViewForMissionDetails()
        buttonSwitchPrivate.titleLabel?.font = UIFont(size: 9.0)
        buttonSwitchPublic.titleLabel?.font = UIFont(size: 9.0)
        buttonSwitchYes.titleLabel?.font = UIFont(size: 9.0)
        buttonSwitchNo.titleLabel?.font = UIFont(size: 9.0)
        buttonSwitchCash.titleLabel?.font = UIFont(size: 9.0)
        buttonSwitchGift.titleLabel?.font = UIFont(size: 9.0)
        labelSelectDueDateTime.font = UIFont(size: 9.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        scrollViewContainer.contentSize = CGSize(width: CGFloat(view.frame.size.width), height: CGFloat(view.frame.size.height - 20.0))
        if requestParamsDictionary.isEmpty {
            requestParamsDictionary = [AnyHashable: Any]()
        }
        missionSetDateButton.isEnabled = true
        headerLabel.font = UIFont()
        saveDraftMissionButton.titleLabel?.font = UIFont(size: 13.0)
        assignMissionButton.titleLabel?.font = UIFont(size: 11.0)
        dateTimePickerContainerView.clipsToBounds = true
        dateTimePickerContainerView.layer.cornerRadius = 10.0
        dateTimePickerContainerView.layer.borderColor = UIColor.lightGray.cgColor
        dateTimePickerContainerView.layer.borderWidth = 1.0
        dateTimePickerContainerView.backgroundColor = UIColor.stasherPopUpBG()
        labelSelectMissionDate.font = UIFont.fontGothamRoundedMedium(withSize: 9.0)
        setUpChildrenScrollView()
        for txtFields: Any in controlsContainerView.subviews {
            if (txtFields is UITextField) {
                var textField: UITextField? = (txtFields as? UITextField)
                textField?.font = UIFont()
                textField?.attributedPlaceholder = NSAttributedString(string: textField?.placeholder, attributes: [NSForegroundColorAttributeName: UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0)), NSFontAttributeName: UIFont()])
                textField?.textColor = UIColor.stasherText()
            }
        }
        missionTitleTextField.autocapitalizationType = .sentences
        missionDescriptionTextView.autocapitalizationType = .sentences
        labelMissionDescCharLimit.textColor = UIColor.stasherTextFieldPlaceHolder()
        labelMissionNameCharLimit.textColor = UIColor.stasherTextFieldPlaceHolder()
        labelMissionDescCharLimit.font = UIFont.fontGothamRounded(withSize: 9.0)
        labelMissionNameCharLimit.font = UIFont.fontGothamRounded(withSize: 9.0)
        missionDescriptionTextView.textColor = UIColor.stasherTextFieldPlaceHolder()
        missionDescriptionTextView.font = UIFont()
        missionSetDateButton.titleLabel?.font = UIFont()
        missionSetDateButton.setTitleColor(UIColor.stasherTextFieldPlaceHolder(), for: .normal)
        labelHeadingSelectChild.font = UIFont(for: 9.0)
        labelHeadingIsTimeBased.font = UIFont(for: 9.0)
        labelHeadingReward.font = UIFont(for: 9.0)
        labelHeadingMissionScope.font = UIFont(for: 9.0)
        labelHeadingIsTimeBased.textColor = UIColor.stasherText()
        labelHeadingMissionScope.textColor = UIColor.stasherText()
        labelHeadingReward.textColor = UIColor.stasherText()
        labelHeadingSelectChild.textColor = UIColor.stasherText()
        buttonDatePickerOk.titleLabel?.font = UIFont(size: 11.0)
        buttonDatePickerCancel.titleLabel?.font = UIFont(size: 11.0)
        rewardTextField.keyboardType = .numbersAndPunctuation
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
            //[[STSharedCustoms sharedAddGestureInstanceWithDelegate:self] addRightSwipeGestureRecognizerToMe];
        var rewardSwitchFrame: CGRect = switchRewardType.frame
        rewardSwitchFrame.origin.x = view.frame.size.width - rewardCustomSwitch.frame.size.width - 12.0
        rewardSwitchFrame.size.width = rewardCustomSwitch.frame.size.width
        rewardSwitchFrame.size.height = rewardCustomSwitch.frame.size.height
        rewardCustomSwitch.frame = rewardSwitchFrame
        controlsContainerView.addSubview(rewardCustomSwitch)
        var timeBasedSwitchFrame: CGRect = switchTimeBased.frame
        timeBasedSwitchFrame.origin.x = view.frame.size.width - timeBasedCustomSwitchView.frame.size.width - 12.0
        timeBasedSwitchFrame.size.width = timeBasedCustomSwitchView.frame.size.width
        timeBasedSwitchFrame.size.height = timeBasedCustomSwitchView.frame.size.height
        timeBasedCustomSwitchView.frame = timeBasedSwitchFrame
        controlsContainerView.addSubview(timeBasedCustomSwitchView)
        var scopeSwitchFrame: CGRect = switchMissionScope.frame
        scopeSwitchFrame.origin.x = view.frame.size.width - scopeCustomSwitchView.frame.size.width - 12.0
        scopeSwitchFrame.size.width = scopeCustomSwitchView.frame.size.width
        scopeSwitchFrame.size.height = scopeCustomSwitchView.frame.size.height
        scopeCustomSwitchView.frame = scopeSwitchFrame
        controlsContainerView.addSubview(scopeCustomSwitchView)
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

    @IBAction func customYesNoSwitchOverlayButtonPressed(_ sender: Any) {
        if switchTimeBased.isOn() {
            customSwitchNoButtonPressed(nil)
        }
        else {
            customSwitchYesButtonPressed(nil)
        }
    }

    @IBAction func customCashGiftSwitchOverlayButtonPressed(_ sender: Any) {
        if switchRewardType.isOn() {
            buttonSecondPressed(nil)
        }
        else {
            buttonFirstPressed(nil)
        }
    }

    @IBAction func customPublicPrivateSwitchOverlayButtonPressed(_ sender: Any) {
        if switchMissionScope.isOn() {
            customSwitchPrivateButtonPressed(nil)
        }
        else {
            customSwitchPublicButtonPressed(nil)
        }
    }

    @IBAction func buttonFirstPressed(_ sender: Any) {
        UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
            self.imgViewGreen.center = buttonSwitchCash.center
            self.switchRewardType.on = true
            self.rewardTypeSwitchValueChanged(self.switchRewardType)
        })
    }

    @IBAction func buttonSecondPressed(_ sender: Any) {
        UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
            self.imgViewGreen.center = buttonSwitchGift.center
            self.switchRewardType.on = false
            self.rewardTypeSwitchValueChanged(self.switchRewardType)
        })
    }

    @IBAction func customSwitchYesButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
            self.imgViewGreenTimeSwitch.center = buttonSwitchYes.center
            self.switchTimeBased.on = true
            self.timeBasedSwitchValueChanged(self.switchTimeBased)
        })
    }

    @IBAction func customSwitchNoButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
            self.imgViewGreenTimeSwitch.center = buttonSwitchNo.center
            self.switchTimeBased.on = false
            self.timeBasedSwitchValueChanged(self.switchTimeBased)
        })
    }

    @IBAction func customSwitchPublicButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
            self.imgViewGreenScopeSwitch.center = buttonSwitchPublic.center
            self.switchMissionScope.on = true
            self.missionScopeSwitchSwitchValueChanged(self.switchMissionScope)
        })
    }

    @IBAction func customSwitchPrivateButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
            self.imgViewGreenScopeSwitch.center = buttonSwitchPrivate.center
            self.switchMissionScope.on = false
            self.missionScopeSwitchSwitchValueChanged(self.switchMissionScope)
        })
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        if isMissionDetailMode == false {
            UIAlertView.show(withTitle: "", message: "Are you sure you want to exit this screen? Your changes have not been saved.", cancelButtonTitle: "Yes", otherButtonTitles: ["No"], tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {
                    navigationController?.popViewController(animated: true)
                }
                else {

                }
            })
        }
        else {
            navigationController?.popViewController(animated: true)
        }
    }

    func rightGestureHandle() {
        navigationController?.popViewController(animated: true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: nil)
    }

    @IBAction func setDateTimeButtonPressed(_ sender: Any) {
        missionDateTimePicker.minimumDate = Date()
        transparentImageView.setHidden(animated: false)
        buttonClosePopUp.isHidden = false
        dateTimePickerContainerView.isHidden = false
        view.bringSubview(toFront: dateTimePickerContainerView)
    }

    @IBAction func assignMissionButtonPressed(_ sender: Any) {
        requestParamsDictionary[kAddMissionParamKeyIsDraft] = "no"
        addMissionSendRequest()
    }

    @IBAction func save(asDraftButtonPressed sender: Any) {
        requestParamsDictionary[kAddMissionParamKeyIsDraft] = "yes"
        addMissionSendRequest()
    }

    @IBAction func timeBasedSwitchValueChanged(_ sender: Any) {
        if switchTimeBased.isOn() {
            missionSetDateButton.isEnabled = true
            labelSelectDueDateTime.textColor = UIColor.stasherTextFieldPlaceHolder()
        }
        else {
            missionSetDateButton.isEnabled = false
            labelSelectDueDateTime.textColor = UIColor.stasherTextFieldPlaceHolder()
            labelSelectDueDateTime.text = "Select Due Date and Time"
        }
    }

    @IBAction func rewardTypeSwitchValueChanged(_ sender: Any) {
        if switchRewardType.isOn() {
            rewardTextField.placeholder = "Enter reward (numbers only)"
            rewardTextField.keyboardType = .numbersAndPunctuation
        }
        else {
            rewardTextField.placeholder = "Enter reward"
            rewardTextField.keyboardType = .default
        }
    }

    @IBAction func missionScopeSwitchSwitchValueChanged(_ sender: Any) {
        if switchMissionScope.isOn() {
            requestParamsDictionary[kAddMissionParamKeyIsPublic] = "yes"
        }
        else {
            requestParamsDictionary[kAddMissionParamKeyIsPublic] = "no"
        }
    }

    @IBAction func pickerContainerDoneButtonPressed(_ sender: Any) {
        dateTimePickerContainerView.isHidden = true
            /*
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
               [dateFormat setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
                [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
                NSString *theDate = [dateFormat stringFromDate:self.missionDateTimePicker.date];
                */
        var dateFormat2 = DateFormatter()
        dateFormat2.dateFormat = "MM/dd/yy hh:mm"
        dateFormat2.timeZone = NSTimeZone.local()
        var theDate2: String = dateFormat2.string(from: missionDateTimePicker.date)
        labelSelectDueDateTime.text = theDate2
        requestParamsDictionary[kAddMissionParamKeyTotalTime] = theDate2
        transparentImageView.setHidden(animated: true)
        buttonClosePopUp.isHidden = true
    }

    @IBAction func dobPickerCancelButtonPressed(_ sender: Any) {
        dateTimePickerContainerView.isHidden = true
        transparentImageView.setHidden(animated: true)
        buttonClosePopUp.isHidden = true
    }
// MARK: ------ TextView Delegate

    func textView(_ textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        var shouldChange: Bool = true
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        if textView == missionDescriptionTextView {
            var missionTitleString: String = textView.text + (text)
            if (missionTitleString.characters.count ?? 0) > 250 {
                shouldChange = false
            }
        }
        return shouldChange
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == missionDescriptionTextView {
            if (missionDescriptionTextView.text == "Mission Description (Optional) (Ex: Don’t forget to close the lid of the trash bin when you’re done!)") {
                textView.text = ""
            }
        }
        textView.textColor = UIColor.stasherText()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == missionDescriptionTextView {
            if !textView.text.validateNotEmpty() {
                textView.textColor = UIColor.stasherTextFieldPlaceHolder()
                textView.text = "Mission Description (Optional) (Ex: Don’t forget to close the lid of the trash bin when you’re done!)"
            }
        }
    }
// MARK: ----- Textfield Methods

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if isMissionDetailMode {
            return false
        }
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !IS_STANDARD_IPHONE_6 && !IS_STANDARD_IPHONE_6_PLUS {
            if textField == rewardTextField {
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
            if textField == rewardTextField {
                if switchRewardType.isOn() {
                    if textField.text.length > 0 && !textField.text.containsString("$") {
                        rewardTextField.text = "$\(rewardTextField.text)"
                    }
                }
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == rewardTextField {
            if switchRewardType.isOn() {
                if textField.text.length > 0 && !textField.text.containsString("$") {
                    textField.text = "$\(textField.text)"
                }
            }
        }
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var shouldChange: Bool = true
        if textField == rewardTextField {
            if switchRewardType.isOn() {
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
            else {
                if string.validateAlphanumericSpace() {
                    shouldChange = true
                }
                else {
                    shouldChange = false
                }
            }
        }
        else if textField == missionTitleTextField {
            var missionTitleString: String = textField.text + (string)
            if (missionTitleString.characters.count ?? 0) > 50 {
                shouldChange = false
            }
        }

        return shouldChange
    }
// MARK: ----- Custom Methods

    func setUpChildrenScrollView() {
        var childrenArray: [Any]
        if isMissionDetailMode {
            childrenArray = [Any]()
            if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
                childrenArray.append(requestParamsDictionary[kParamKeyChild])
            }
            else {
                childrenArray.append(requestParamsDictionary[kParamKeyParent])
            }
        }
        else {
            childrenArray = [Any](arrayLiteral: STUserIdentity.sharedInstance().getChildrenArray())
        }
        if childrenArray && childrenArray.count > 0 {
            var buttonFrame = CGRect(x: CGFloat(12.0), y: CGFloat(0), width: CGFloat(49.0), height: CGFloat(49.0))
            for dict: [AnyHashable: Any] in childrenArray {
                var childButton = UIButton(type: .custom)
                childButton.tag = CInt(dict[kParamKeyUserID])
                childButton.backgroundColor = UIColor.clear
                childButton.frame = buttonFrame
                childButton.addTarget(self, action: #selector(self.childButtonPressed), for: .touchUpInside)
                if isMissionDetailMode {
                    if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
                        if requestParamsDictionary[kParamKeyChild] {
                            if requestParamsDictionary[kParamKeyChild][kParamKeyUserID] {
                                if CInt(dict[kParamKeyUserID]) == CInt(requestParamsDictionary[kParamKeyChild][kParamKeyUserID]) {
                                    performSelector(#selector(self.childButtonPressed), withObject: childButton, afterDelay: 0.5)
                                }
                            }
                        }
                    }
                    else {
                        if requestParamsDictionary[kParamKeyParent] {
                            if requestParamsDictionary[kParamKeyParent][kParamKeyUserID] {
                                if CInt(dict[kParamKeyUserID]) == CInt(requestParamsDictionary[kParamKeyParent][kParamKeyUserID]) {
                                    performSelector(#selector(self.childButtonPressed), withObject: childButton, afterDelay: 0.5)
                                }
                            }
                        }
                    }
                }
                else {
                    if requestParamsDictionary[kParamKeyChild] {
                        if requestParamsDictionary[kParamKeyChild][kParamKeyUserID] {
                            if CInt(dict[kParamKeyUserID]) == CInt(requestParamsDictionary[kParamKeyChild][kParamKeyUserID]) {
                                performSelector(#selector(self.childButtonPressed), withObject: childButton, afterDelay: 0.5)
                            }
                        }
                    }
                    else {
                        performSelector(#selector(self.childButtonPressed), withObject: childButton, afterDelay: 0.5)
                    }
                }
                var profilePicImageView = UIImageView(frame: childButton.frame)
                if !(dict[kParamKeyAvatar] is NSNull) {
                    profilePicImageView.setImageWith(URL(string: dict[kParamKeyAvatar]), placeholderImage: UIImage(named: "Stasher_FacePlaceHolder"))
                }
                var imgViewFrame: CGRect = profilePicImageView.frame
                imgViewFrame.size.width = 48.0
                imgViewFrame.size.height = 48.0
                profilePicImageView.frame = imgViewFrame
                var childNameLabel = UILabel(frame: CGRect(x: CGFloat(buttonFrame.origin.x), y: CGFloat(52.0), width: CGFloat(49.0), height: CGFloat(80.0)))
                childNameLabel.numberOfLines = 0
                if isMissionDetailMode {
                    childNameLabel.text = "\(dict[kParamKeyFirstname]) \(dict[kParamKeyLastname])"
                }
                else {
                    childNameLabel.text = dict[kParamKeyUsername]
                }
                childNameLabel.textColor = UIColor.stasherText()
                childNameLabel.font = UIFont.fontGothamRoundedMedium(withSize: 11.0)
                scrollViewChildrens.addSubview(childNameLabel)
                childNameLabel.textAlignment = .center
                childNameLabel.sizeToFit()
                childNameLabel.center = CGPoint(x: CGFloat(profilePicImageView.center.x), y: CGFloat(childNameLabel.center.y))
                scrollViewChildrens.addSubview(profilePicImageView)
                scrollViewChildrens.addSubview(childButton)
                childButton.clipsToBounds = true
                childButton.layer.cornerRadius = childButton.frame.size.width / 2.0
                childButton.layer.borderColor = UIColor.clear.cgColor
                childButton.layer.borderWidth = 2.0
                profilePicImageView.clipsToBounds = true
                profilePicImageView.layer.cornerRadius = childButton.frame.size.width / 2.0
                profilePicImageView.contentMode = .scaleAspectFill
                profilePicImageView.layer.borderColor = UIColor.clear.cgColor
                profilePicImageView.layer.borderWidth = 2.0
                buttonFrame.origin.x += buttonFrame.size.width + 8.0
            }
            var contentSize: CGSize = scrollViewChildrens.frame.size
            contentSize.width = buttonFrame.origin.x
            scrollViewChildrens.contentSize = contentSize
        }
        childrenArray = nil
    }

    func childButtonPressed(_ sender: Any) {
        if isMissionDetailMode == true {
            return
        }
        var btn: UIButton? = (sender as? UIButton)
        if childBUttonArray.isEmpty {
            childBUttonArray = [Any]()
        }
        if childIdsArray.isEmpty {
            childIdsArray = [Any]()
        }
        if !childBUttonArray.contains(btn) {
            //[btn setBackgroundColor:[UIColor greenColor]];
            btn?.clipsToBounds = true
            btn?.layer?.cornerRadius = btn?.frame?.size?.width / 2.0
            btn?.layer?.borderColor = UIColor(red: CGFloat(101.0 / 255), green: CGFloat(194.0 / 255), blue: CGFloat(15.0 / 255), alpha: CGFloat(1.0)).cgColor
            btn?.layer?.borderWidth = 2.0
            childBUttonArray.append(btn)
            if childIdsArray.isEmpty {
                childIdsArray = [Any]()
            }
            childIdsArray.append(Int(btn?.tag))
        }
        else {
            //[btn setBackgroundColor:[UIColor clearColor]];
            btn?.clipsToBounds = true
            btn?.layer?.cornerRadius = btn?.frame?.size?.width / 2.0
            btn?.layer?.borderColor = UIColor.clear.cgColor
            btn?.layer?.borderWidth = 2.0
            childBUttonArray.remove(at: childBUttonArray.index(of: btn)!)
            childIdsArray.remove(at: childIdsArray.index(of: Int(btn?.tag))!)
        }
    }

    func addMissionSendRequest() {
        if !missionTitleTextField.text.validateNotEmpty() {
            UIAlertView.show(withTitle: "", message: "Enter Mission Title", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {

                }
            })
            return
        }
        if !rewardTextField.text.validateNotEmpty() {
            UIAlertView.show(withTitle: "", message: "Enter Reward", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {

                }
            })
            return
        }
        if childIdsArray == nil || childIdsArray.count == 0 {
            UIAlertView.show(withTitle: "", message: "Choose child for mission", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {

                }
            })
            return
        }
        if switchTimeBased.isOn() {
            requestParamsDictionary[kAddMissionParamKeyIsTimeBased] = "yes"
        }
        else {
            requestParamsDictionary[kAddMissionParamKeyIsTimeBased] = "no"
        }
        if switchRewardType.isOn() {
            requestParamsDictionary[kAddMissionParamKeyRewardType] = "cash"
        }
        else {
            requestParamsDictionary[kAddMissionParamKeyRewardType] = "gift"
        }
        if switchMissionScope.isOn() {
            requestParamsDictionary[kAddMissionParamKeyIsPublic] = "yes"
        }
        else {
            requestParamsDictionary[kAddMissionParamKeyIsPublic] = "no"
        }
        requestParamsDictionary[kAddMissionParamKeyTitle] = missionTitleTextField.text
        if !(missionDescriptionTextView.text == "Mission Description (Optional) (Ex: Don’t forget to close the lid of the trash bin when you’re done!)") {
            requestParamsDictionary[kAddMissionParamKeyDescription] = missionDescriptionTextView.text
        }
        requestParamsDictionary[kParamKeyParentID] = Int(CInt(STUserIdentity.sharedInstance().userId()))
        requestParamsDictionary[kParamKeyChildID] = (childIdsArray as NSArray).componentsJoined(byString: ",")
        requestParamsDictionary[kAddMissionParamKeyRewards] = rewardTextField.text.trimmingCharacters(in: CharacterSet.symbols)
        var dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormat.timeZone = NSTimeZone.local()
        var dtStr: String = dateFormat.string(from: Date())
        var dateFormat2 = DateFormatter()
        dateFormat2.dateFormat = "MM/dd/yyyy HH:mm:ss"
        dateFormat2.timeZone = NSTimeZone.local()
        requestParamsDictionary["inserted_date"] = dateFormat2.string(from: dateFormat.date(fromString: dtStr))
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        if !isEditMode {
            requestParamsDictionary[kParamKeyAction] = kAPIActionAddMission
        }
        else {
            requestParamsDictionary[kParamKeyAction] = kAPIActionEditMission
        }
        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: requestParamsDictionary, json: true)
    }

    func refreshViewForMissionDetails() {
        if isMissionDetailMode {
            assignMissionButton.isHidden = true
            missionDescriptionTextView.isEditable = false
            missionDateTimePicker.isEnabled = false
            missionSetDateButton.isEnabled = false
            rewardCustomSwitch.isUserInteractionEnabled = false
            rewardCustomSwitch.alpha = 0.7
            scopeCustomSwitchView.isUserInteractionEnabled = false
            scopeCustomSwitchView.alpha = 0.7
            timeBasedCustomSwitchView.isUserInteractionEnabled = false
            timeBasedCustomSwitchView.alpha = 0.7
            if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
                labelHeadingSelectChild.text = "Mission Assigned to:"
            }
            else {
                labelHeadingSelectChild.text = "Mission Assigned by:"
            }
            labelSelectDueDateTime.textColor = UIColor.stasherText()
        }
        else {
            assignMissionButton.isHidden = false
            missionDescriptionTextView.isEditable = true
            missionDateTimePicker.isEnabled = true
            missionSetDateButton.isEnabled = true
            rewardCustomSwitch.isUserInteractionEnabled = true
            rewardCustomSwitch.alpha = 1
            scopeCustomSwitchView.isUserInteractionEnabled = true
            scopeCustomSwitchView.alpha = 1
            timeBasedCustomSwitchView.isUserInteractionEnabled = true
            timeBasedCustomSwitchView.alpha = 1
            labelSelectDueDateTime.textColor = UIColor.stasherTextFieldPlaceHolder()
        }
    }

    func prePopulateControlsForEditMission() {
        if requestParamsDictionary[kAddMissionParamKeyTitle] {
            missionTitleTextField.textColor = UIColor.stasherText()
            missionTitleTextField.text = requestParamsDictionary[kAddMissionParamKeyTitle]
        }
        if requestParamsDictionary[kAddMissionParamKeyDescription] {
            missionDescriptionTextView.textColor = UIColor.stasherText()
            missionDescriptionTextView.text = requestParamsDictionary[kAddMissionParamKeyDescription]
        }
        if requestParamsDictionary[kAddMissionParamKeyIsPublic] {
            if (requestParamsDictionary[kAddMissionParamKeyIsPublic] == "yes") {
                switchMissionScope.on = true
            }
            else {
                switchMissionScope.on = false
            }
        }
        if requestParamsDictionary[kAddMissionParamKeyIsTimeBased] {
            if (requestParamsDictionary[kAddMissionParamKeyIsTimeBased] == "yes") {
                switchTimeBased.on = true
                if requestParamsDictionary[kAddMissionParamKeyTotalTime] {
                    labelSelectDueDateTime.text = requestParamsDictionary[kAddMissionParamKeyTotalTime]
                    var dateFormat2 = DateFormatter()
                    dateFormat2.dateFormat = "yyyy-MM-dd hh:mm:ss"
                    dateFormat2.timeZone = NSTimeZone.local()
                    var theDate2: Date? = dateFormat2.date(fromString: (requestParamsDictionary[kAddMissionParamKeyTotalTime] as? Date))
                    var dateFormat3 = DateFormatter()
                    dateFormat3.dateFormat = "MM/dd/yy hh:mm"
                    dateFormat3.timeZone = NSTimeZone.local()
                    labelSelectDueDateTime.text = dateFormat3.string(from: theDate2)
                }
            }
            else {
                switchTimeBased.on = false
            }
        }
        if requestParamsDictionary[kAddMissionParamKeyRewardType] {
            if (requestParamsDictionary[kAddMissionParamKeyRewardType] == "cash") {
                if requestParamsDictionary[kAddMissionParamKeyRewards] {
                    rewardTextField.text = "$\(requestParamsDictionary[kAddMissionParamKeyRewards])"
                }
                switchRewardType.on = true
            }
            else {
                if requestParamsDictionary[kAddMissionParamKeyRewards] {
                    rewardTextField.text = requestParamsDictionary[kAddMissionParamKeyRewards]
                }
                switchRewardType.on = false
            }
        }
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDictionary != nil {
                if responseDictionary?["success"] {
                    UIAlertView.show(withTitle: "", message: responseDictionary?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        if buttonIndex == alertView.cancelButtonIndex {
                            if self.delegate?.responds(to: #selector(self.missionUpdatedAdded)) {
                                self.delegate?.missionUpdatedAdded()
                                navigationController?.popViewController(animated: true)
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