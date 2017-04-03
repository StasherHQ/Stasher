//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STAddChildViewController.swift
//  Stasher
//
//  Created by bhushan on 18/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol AddChildDelegate: NSObjectProtocol {
    func childAdded(withUserDetailsDictionary infoDict: [AnyHashable: Any])
}
class STAddChildViewController: UIViewController, STSharedCustomsDelegate {
    var httpReq: BOABHttpReq?
    var searchResultsArray = [Any]()
    var selectedIndexPath: IndexPath?
    var isSearchContainsAt: Bool = false

    weak var delegate: AddChildDelegate?
    var relationshipEnum = RelationShipToChild()
    @IBOutlet var addChildSelectRelationView: UIView!
    @IBOutlet var createChildAccountButton: UIButton!
    @IBOutlet var labelNoChildFound: UILabel!
    @IBOutlet var txtFieldSearch: UITextField!
    @IBOutlet var searchResultsTableView: UITableView!
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
    @IBOutlet var relationPopUpCancelBtn: UIButton!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addChildSelectRelationView.isHidden = true
        labelNoChildFound.text = ""
        labelNoChildFound.isHidden = true
        createChildAccountButton.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        txtFieldSearch.becomeFirstResponder()
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
        // Do any additional setup after loading the view from its nib.
        headerlabel.font = UIFont()
        createChildAccountButton.titleLabel?.font = UIFont(size: 11.0)
        labelNoChildFound.textColor = UIColor.stasherText()
        for txtFields: Any in view.subviews {
            if (txtFields is UITextField) {
                var textField: UITextField? = (txtFields as? UITextField)
                textField?.font = UIFont.fontGothamRoundedBook(withSize: 9.0)
                textField?.attributedPlaceholder = NSAttributedString(string: textField?.placeholder, attributes: [NSForegroundColorAttributeName: UIColor(red: CGFloat(125.0 / 255), green: CGFloat(125.0 / 255), blue: CGFloat(125.0 / 255), alpha: CGFloat(1.0)), NSFontAttributeName: UIFont.fontGothamRoundedBook(withSize: 9.0)])
                textField?.textColor = UIColor.stasherText()
            }
        }
        labelNoChildFound.font = UIFont(for: 10.0)
        labelNoChildFound.textColor = UIColor.stasherText()
        relationControlContainerView.clipsToBounds = true
        relationControlContainerView.layer.cornerRadius = 10.0
        relationControlContainerView.layer.borderColor = UIColor.lightGray.cgColor
        relationControlContainerView.layer.borderWidth = 2.0
        relationControlContainerView.backgroundColor = UIColor.stasherPopUpBG()
        labelHeadingChooseRelation.font = UIFont.fontGothamRoundedMedium(withSize: 13.0)
        labelHeadingChooseRelation.textColor = UIColor.stasherText()
        parentRelationButton.setTitleColor(UIColor.stasherText(), for: .normal)
        friendRelationButton.setTitleColor(UIColor.stasherText(), for: .normal)
        familyRelationButton.setTitleColor(UIColor.stasherText(), for: .normal)
        addChildButton.titleLabel?.font = UIFont(size: 11.0)
        parentRelationButton.titleLabel?.font = UIFont(size: 11.0)
        familyRelationButton.titleLabel?.font = UIFont(size: 11.0)
        friendRelationButton.titleLabel?.font = UIFont(size: 11.0)
        relationPopUpCancelBtn.titleLabel?.font = UIFont(size: 11.0)
        txtFieldSearch.autocorrectionType = .no
    }

    func rightGestureHandle() {
        navigationController?.popViewController(animated: true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK: ----- Actions

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func addChildRelationViewButtonPressed(_ sender: Any) {
        addChildSelectRelationView.setHidden(animated: true)
        /*
            if ([self.delegate respondsToSelector:@selector(childAddedWithUserDetailsDictionary:)]) {
                if ([searchResultsArray count] > selectedIndexPath.row) {
                     [self.delegate childAddedWithUserDetailsDictionary:[searchResultsArray objectAtIndex:selectedIndexPath.row]];
                }
            }
             */
        if searchResultsArray.count > selectedIndexPath?.row {
            if httpReq != nil {
                httpReq?.delegate = nil
                httpReq = nil
            }
            httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
            var paramDict = [AnyHashable: Any]()
            paramDict["childId"] = searchResultsArray[selectedIndexPath?.row]?[kParamKeyUserID]
            paramDict["parentId"] = STUserIdentity.sharedInstance().userId()
            paramDict["relation_type"] = Int(relationshipEnum)
            paramDict[kParamKeyAction] = kAPIActionAddChild
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
            paramDict = nil
        }
    }

    @IBAction func closeRelationshippopUpContainerView(_ sender: Any) {
        addChildSelectRelationView.setHidden(animated: true)
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

    @IBAction func createChildAccountButtonPressed(_ sender: Any) {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var editProfileVC: STCreateChildViewController? = storyboard.instantiateViewController(withIdentifier: "STCreateChildViewController")
        navigationController?.pushViewController(editProfileVC, animated: true)
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

    func initiateSearching(_ textField: UITextField) {
        if textField.text.length > 0 {
            labelNoChildFound.text = "Can't find \(textField.text)? Create your child account to use stasher now."
            labelNoChildFound.isHidden = false
            createChildAccountButton.isHidden = false
            if httpReq != nil {
                httpReq?.delegate = nil
                httpReq = nil
            }
            httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
            var paramDict = [AnyHashable: Any]()
            paramDict["q"] = textField.text
            paramDict[kParamKeyAction] = kAPIActionSearchChild
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
            paramDict = nil
        }
        else {
            labelNoChildFound.text = ""
            labelNoChildFound.isHidden = true
            createChildAccountButton.isHidden = true
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
                            NSLog(@"searching for %@ ", searchString);
                            [paramDict setObject:kAPIActionSearchChild forKey:kParamKeyAction];
                            [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
                            paramDict = nil;
                             */
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
                cell?.selectionStyle = []
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
                cell?.imgViewCellDetail?.isHidden = true
            }
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: false)
        txtFieldSearch.resignFirstResponder()
        addChildSelectRelationView.setHidden(animated: false)
        imgViewparentBullet.image = UIImage(named: "buletbutton_Active")
        imgViewFamilyBullet.image = UIImage(named: "buletbutton_Inactive")
        imgViewFriendBullet.image = UIImage(named: "buletbutton_Inactive")
    }
// MARK: - BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            if (conn.userInfo?["params"]["action"] == kAPIActionSearchChild) {
                if !searchResultsArray.isEmpty {
                    searchResultsArray.removeAll()
                    searchResultsArray = nil
                }
                searchResultsArray = [Any]()
                var thisSearchResultsArray: [Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
                if (thisSearchResultsArray? is [Any]) {
                    if thisSearchResultsArray != nil && thisSearchResultsArray?.count > 0 {
                        for dict: [AnyHashable: Any] in thisSearchResultsArray {
                            if CInt(dict[kParamKeyUserType]) == CHILDUSER {
                                searchResultsArray.append(dict)
                            }
                        }
                        searchResultsTableView.reloadData()
                    }
                }
                else {
                    var responseDict: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
                    if responseDict?["error"] {
                        if !responseDict?["error"]["message"].containsString("compulsory") {
                            UIAlertView.show(withTitle: "", message: responseDict?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                                if buttonIndex == alertView.cancelButtonIndex {

                                }
                            })
                        }
                    }
                    searchResultsTableView.reloadData()
                }
            }
            else if (conn.userInfo?["params"]["action"] == kAPIActionAddChild) {
                var responseDict: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
                if responseDict?["success"] {
                    UIAlertView.show(withTitle: "", message: responseDict?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        if buttonIndex == alertView.cancelButtonIndex {
                            if self.delegate?.responds(to: #selector(self.childAddedWithUserDetailsDictionary)) {
                                if self.searchResultsArray.count > self.selectedIndexPath?.row {
                                    self.delegate?.childAdded(withUserDetailsDictionary: self.searchResultsArray[self.selectedIndexPath?.row])
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