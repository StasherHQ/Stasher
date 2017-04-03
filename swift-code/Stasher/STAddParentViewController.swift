//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STAddParentViewController.swift
//  Stasher
//
//  Created by bhushan on 20/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol AddParentDelegate: NSObjectProtocol {
    func parentAdded(withUserDetailsDictionary infoDict: [AnyHashable: Any])
}
class STAddParentViewController: UIViewController, STSharedCustomsDelegate {
    var httpReq: BOABHttpReq?
    var searchResultsArray = [Any]()
    var selectedIndexPath: IndexPath?
    var isSearchContainsAt: Bool = false

    weak var delegate: AddParentDelegate?
    var relationshipEnum = RelationShipToChild()
    @IBOutlet var txtFieldSearch: UITextField!
    @IBOutlet var searchResultsTableView: UITableView!
    @IBOutlet var addParentSelectRelationView: UIView!
    @IBOutlet var labelInviteParent: UILabel!
    @IBOutlet var inviteParentButton: UIButton!
    @IBOutlet var parentRelationButton: UIButton!
    @IBOutlet var familyRelationButton: UIButton!
    @IBOutlet var friendRelationButton: UIButton!
    @IBOutlet var headerlabel: UILabel!
    @IBOutlet var relationControlContainerView: UIView!
    @IBOutlet var imgViewparentBullet: UIImageView!
    @IBOutlet var imgViewFamilyBullet: UIImageView!
    @IBOutlet var imgViewFriendBullet: UIImageView!
    @IBOutlet var labelHeadingChooseRelation: UILabel!
    @IBOutlet var addChildButton: UIButton!
    @IBOutlet var inviteParentView: UIView!
    @IBOutlet var inviteParentPopUpImgView: UIImageView!
    @IBOutlet var inviteParentMailIdTxtField: UITextField!
    @IBOutlet var sendInvitationButton: UIButton!
    @IBOutlet var relationPopUpCancelBtn: UIButton!


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        addParentSelectRelationView.isHidden = true
        relationshipEnum = PARENT
        STSharedCustoms.sharedAddGestureInstance(withDelegate: self).addRightSwipeGestureRecognizerToMe()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide), name: UIKeyboardDidHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        headerlabel.font = UIFont()
        for txtFields: Any in view.subviews {
            if (txtFields is UITextField) {
                var textField: UITextField? = (txtFields as? UITextField)
                textField?.font = UIFont.fontGothamRoundedBook(withSize: 9.0)
                textField?.attributedPlaceholder = NSAttributedString(string: textField?.placeholder, attributes: [NSForegroundColorAttributeName: UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0)), NSFontAttributeName: UIFont.fontGothamRoundedBook(withSize: 9.0)])
                textField?.textColor = UIColor.stasherText()
            }
        }
        inviteParentMailIdTxtField.font = UIFont.fontGothamRoundedBook(withSize: 9.0)
        inviteParentMailIdTxtField.attributedPlaceholder = NSAttributedString(string: inviteParentMailIdTxtField.placeholder, attributes: [NSForegroundColorAttributeName: UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0)), NSFontAttributeName: UIFont.fontGothamRoundedBook(withSize: 9.0)])
        inviteParentMailIdTxtField.textColor = UIColor.stasherText()
        relationControlContainerView.clipsToBounds = true
        relationControlContainerView.layer.cornerRadius = 10.0
        relationControlContainerView.layer.borderColor = UIColor.lightGray.cgColor
        relationControlContainerView.layer.borderWidth = 2.0
        relationControlContainerView.backgroundColor = UIColor.stasherPopUpBG()
        labelHeadingChooseRelation.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        labelHeadingChooseRelation.textColor = UIColor.stasherText()
        parentRelationButton.setTitleColor(UIColor.stasherText(), for: .normal)
        friendRelationButton.setTitleColor(UIColor.stasherText(), for: .normal)
        familyRelationButton.setTitleColor(UIColor.stasherText(), for: .normal)
        addChildButton.titleLabel?.font = UIFont(size: 11.0)
        parentRelationButton.titleLabel?.font = UIFont(size: 11.0)
        familyRelationButton.titleLabel?.font = UIFont(size: 11.0)
        friendRelationButton.titleLabel?.font = UIFont(size: 11.0)
        sendInvitationButton.titleLabel?.font = UIFont(size: 11.0)
        inviteParentButton.titleLabel?.font = UIFont(size: 11.0)
        labelInviteParent.font = UIFont(for: 10.0)
        relationPopUpCancelBtn.titleLabel?.font = UIFont(size: 11.0)
        labelInviteParent.textColor = UIColor.stasherText()
        txtFieldSearch.autocorrectionType = .no
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
        navigationController?.popToRootViewController(animated: true)
    }

    func rightGestureHandle() {
        navigationController?.popViewController(animated: true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: nil)
    }

    @IBAction func addParent(onRelationViewButtonPressed sender: Any) {
        addParentSelectRelationView.isHidden = true
        if searchResultsArray.count > selectedIndexPath?.row {
            if httpReq != nil {
                httpReq?.delegate = nil
                httpReq = nil
            }
            httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
            var paramDict = [AnyHashable: Any]()
            paramDict["parentId"] = searchResultsArray[selectedIndexPath?.row]?[kParamKeyUserID]
            paramDict["childId"] = STUserIdentity.sharedInstance().userId()
            paramDict["relation_type"] = Int(relationshipEnum)
            paramDict[kParamKeyAction] = kAPIActionAddParent
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
            paramDict = nil
        }
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

    @IBAction func closeRelationshippopUpContainerView(_ sender: Any) {
        addParentSelectRelationView.setHidden(animated: true)
    }

    @IBAction func inviteParentButtonPressed(_ sender: Any) {
        txtFieldSearch.resignFirstResponder()
        inviteParentView.setHidden(animated: false)
    }

    @IBAction func inviteParentClosePopUpButtonPressed(_ sender: Any) {
        inviteParentMailIdTxtField.resignFirstResponder()
        inviteParentView.setHidden(animated: true)
    }

    @IBAction func sendInvitationButtonPressed(_ sender: Any) {
        inviteParentMailIdTxtField.resignFirstResponder()
        if !inviteParentMailIdTxtField.text.validateEmail() {
            UIAlertView.show(withTitle: "", message: "Please enter valid email address.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
            })
        }
        else {
            inviteParentView.setHidden(animated: true)
            if httpReq != nil {
                httpReq?.delegate = nil
                httpReq = nil
            }
            httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
            var paramDict = [AnyHashable: Any]()
            paramDict[kParamKeyEmail] = inviteParentMailIdTxtField.text
            paramDict[kParamKeyChildID] = STUserIdentity.sharedInstance().userId()
            paramDict[kParamKeyAction] = kAPIActionInviteParent
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
            paramDict = nil
        }
    }
// MARK: ----- Search Textfield

    func keyboardDidHide(_ notif: Notification) {
        if txtFieldSearch.text.containsString("@") {
            isSearchContainsAt = true
        }
        else {
            isSearchContainsAt = false
        }
        var characterSet = CharacterSet.whitespacesAndNewlines
        if txtFieldSearch.text.trimmingCharacters(in: characterSet).length != 0 {
            initiateSearching(txtFieldSearch)
        }
        else {
            txtFieldSearch.text = ""
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func initiateSearching(_ textField: UITextField) {
        if textField.text.length > 0 {
            if httpReq != nil {
                httpReq?.delegate = nil
                httpReq = nil
            }
            httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
            var paramDict = [AnyHashable: Any]()
            paramDict["q"] = textField.text
            paramDict[kParamKeyAction] = kAPIActionSearchParent
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
            paramDict = nil
        }
        else {

        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var shouldChange: Bool = true
        if textField == txtFieldSearch {
            if string.validateAlphanumericSpaceAndAt() {
                shouldChange = true
                var searchString: String = ""
                if string.validateNotEmpty() {
                    searchString = textField.text + (string)
                }
                else {
                    if textField.text.length > 0 {
                        searchString = (textField.text as? NSString)?.substring(to: textField.text.length - 1)
                    }
                    else {
                        searchString = textField.text
                    }
                }
                /*
                            if (httpReq) {
                                httpReq.delegate = nil;
                                httpReq = nil;
                            }
                            httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
                            NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
                            [paramDict setObject:searchString forKey:@"q"];
                            [paramDict setObject:kAPIActionSearchParent forKey:kParamKeyAction];
                            [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
                            paramDict = nil;
                             */
            }
            else {
                shouldChange = false
            }
        }
        else if textField == inviteParentMailIdTxtField {
            if string.validateEmail() {
                shouldChange = true
            }
        }

        return shouldChange
    }
// MARK: ----- Table Search Results

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var stUserCellIdentifier: String = "STUserCustomTableViewCell"
        var cell: STUserCustomTableViewCell? = tableView.dequeueReusableCell(withIdentifier: stUserCellIdentifier)
        if cell == nil {
            cell = (Bundle.main.loadNibNamed(NSStringFromClass(STUserCustomTableViewCell.self), owner: self, options: [])[0] as? STUserCustomTableViewCell)
        }
        if searchResultsArray != nil {
            if searchResultsArray.count > indexPath.row {
                //cell.LabelName.text = [NSString stringWithFormat:@"%@ %@",[[searchResultsArray objectAtIndex:indexPath.row] objectForKey:kParamKeyFirstname],[[searchResultsArray objectAtIndex:indexPath.row] objectForKey:kParamKeyLastname]];
                if isSearchContainsAt {
                    cell?.labelName?.text = searchResultsArray[indexPath.row][kParamKeyEmail]
                }
                else {
                    cell?.labelName?.text = searchResultsArray[indexPath.row][kParamKeyUsername]
                }
                cell?.labelName?.textColor = UIColor.stasherText()
                cell?.labelName?.font = UIFont.fontGothamRoundedMedium(withSize: 11.0)
                if !(searchResultsArray[indexPath.row][kParamKeyAvatar] is NSNull) {
                    cell?.imgViewProfilePic?.setImageWith(URL(string: searchResultsArray[indexPath.row][kParamKeyAvatar]), placeholderImage: UIImage(named: "Stasher_FacePlaceHolder"))
                }
                cell?.selectionStyle = []
                cell?.imgViewCellDetail?.isHidden = true
            }
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: false)
        txtFieldSearch.resignFirstResponder()
        addParentSelectRelationView.setHidden(animated: false)
    }
// MARK: - BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            if (conn.userInfo?["params"]["action"] == kAPIActionSearchParent) {
                if !searchResultsArray.isEmpty {
                    searchResultsArray.removeAll()
                    searchResultsArray = nil
                }
                searchResultsArray = [Any]()
                var thisSearchResultsArray: [Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
                if (thisSearchResultsArray? is [Any]) {
                    if thisSearchResultsArray != nil && thisSearchResultsArray?.count > 0 {
                        for dict: [AnyHashable: Any] in thisSearchResultsArray {
                            if CInt(dict[kParamKeyUserType]) == PARENTUSER {
                                searchResultsArray.append(dict)
                            }
                        }
                        searchResultsTableView.reloadData()
                    }
                }
                else {
                    var responseDict: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
                    if !responseDict?["error"]["message"].containsString("compulsory") {
                        UIAlertView.show(withTitle: "", message: responseDict?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                            if buttonIndex == alertView.cancelButtonIndex {

                            }
                        })
                    }
                    searchResultsTableView.reloadData()
                }
            }
            else if (conn.userInfo?["params"]["action"] == kAPIActionAddParent) {
                var responseDict: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
                if responseDict?["success"] {
                    UIAlertView.show(withTitle: "", message: responseDict?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        if buttonIndex == alertView.cancelButtonIndex {
                            if self.delegate?.responds(to: #selector(self.parentAddedWithUserDetailsDictionary)) {
                                if self.searchResultsArray.count > self.selectedIndexPath?.row {
                                    self.delegate?.parentAdded(withUserDetailsDictionary: self.searchResultsArray[self.selectedIndexPath?.row])
                                }
                            }
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
            else if (conn.userInfo?["params"]["action"] == kAPIActionInviteParent) {
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
        }
    }

    func boabHttpReqFailedWithError(_ error: Error?) {
        if error != nil {

        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        txtFieldSearch.resignFirstResponder()
    }
}