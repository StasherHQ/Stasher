//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STParentAccountChildDetailsViewController.swift
//  Stasher
//
//  Created by bhushan on 02/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STParentAccountChildDetailsViewController: UIViewController, STSharedCustomsDelegate, ParentPaymentFlowDelegate {
    var httpReq: BOABHttpReq?
    var linkBankAccountVC: STPaymentLinkBankViewController?

    var childDetailsDictionary = [AnyHashable: Any]()
    @IBOutlet var tableOtherCommanders: UITableView!
    var otherCommandersArray = [Any]()
    @IBOutlet var labelUsername: UILabel!
    @IBOutlet var labelCompleteName: UILabel!
    @IBOutlet var labelAge: UILabel!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var historyButton: UIButton!
    @IBOutlet var transferButton: UIButton!
    @IBOutlet var childProfilePicImgView: UIImageView!
    @IBOutlet var otherChallengersLabel: UILabel!
    @IBOutlet var childSavingsLabel: UILabel!
    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet var controlsContainerView: UIView!
    @IBOutlet weak var constraintHeightControlContainerView: NSLayoutConstraint!

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, withChildDetailsDictionary thisChildsDictionary: [AnyHashable: Any]) {
        super.init(nibName: "STParentAccountChildDetailsViewController", bundle: Bundle.main)
        
        if !thisChildsDictionary.isEmpty {
            childDetailsDictionary = thisChildsDictionary
            requestChildDetails()
        }
    
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if childDetailsDictionary[kParamKeyUsername] {
            labelUsername.text = childDetailsDictionary[kParamKeyUsername]
        }
        if childDetailsDictionary[kParamKeyFirstname] && childDetailsDictionary[kParamKeyLastname] {
            labelCompleteName.text = "\(childDetailsDictionary[kParamKeyFirstname]) \(childDetailsDictionary[kParamKeyLastname])"
        }
        if childDetailsDictionary[kParamKeyDateOfBirth] {
            var dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            var theDate: Date? = dateFormat.date(fromString: (childDetailsDictionary[kParamKeyDateOfBirth] as? Date))
            if age(fromBirthday: theDate) > 0 {
                labelAge.text = "\(Int(age(fromBirthday: theDate))) years old"
            }
            else {
                labelAge.text = ""
            }
        }
        if !(childDetailsDictionary[kParamKeyAvatar] is NSNull) && !(childDetailsDictionary[kParamKeyAvatar] == "") {
            childProfilePicImgView.setImageWith(URL(string: childDetailsDictionary[kParamKeyAvatar]), placeholderImage: UIImage(named: "account_face_placeholder"))
        }
        else {
            childProfilePicImgView.image = UIImage(named: "account_face_placeholder")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        headerLabel.font = UIFont()
        labelAge.font = UIFont.fontGothamRoundedMedium(withSize: 9.0)
        labelCompleteName.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        labelUsername.font = UIFont.fontGothamRoundedMedium(withSize: 18.0)
        otherChallengersLabel.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        otherChallengersLabel.textColor = UIColor.stasherText()
        childSavingsLabel.font = UIFont.fontGothamRoundedMedium(withSize: 11.0)
        childSavingsLabel.textColor = UIColor.stasherText()
        labelAge.textColor = UIColor.stasherText()
        labelCompleteName.textColor = UIColor.stasherTextFieldPlaceHolder()
        labelUsername.textColor = UIColor.stasherText()
        historyButton.titleLabel?.font = UIFont(size: 11.0)
        transferButton.titleLabel?.font = UIFont(size: 11.0)
        childProfilePicImgView.clipsToBounds = true
        childProfilePicImgView.layer.cornerRadius = 80 / 2.0
        childProfilePicImgView.layer.borderColor = UIColor.clear.cgColor
        childProfilePicImgView.layer.borderWidth = 0.5
        childProfilePicImgView.contentMode = .scaleAspectFill
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
// MARK: ----- Custom Methods

    func adjustHeightOfTableview() {
        var height: CGFloat = tableOtherCommanders.contentSize.height
        var maxHeight: CGFloat? = tableOtherCommanders.superview?.frame?.size?.height - tableOtherCommanders.frame.origin.y
        // if the height of the content is greater than the maxHeight of
        // total space on the screen, limit the height to the size of the
        // superview.
        if height > maxHeight {
            height = maxHeight
        }
            // now set the frame accordingly
        var frame: CGRect = tableOtherCommanders.frame
        frame.size.height = height
        tableOtherCommanders.frame = frame
        // if you have other controls that should be resized/moved to accommodate
        // the resized tableview, do that here, too
        tableHeightConstraint.constant = tableOtherCommanders.contentSize.height
        constraintHeightControlContainerView.constant = tableOtherCommanders.frame.origin.y + tableOtherCommanders.contentSize.height + 8.0
    }

    func requestChildDetails() {
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: false)
        var paramDict = [AnyHashable: Any]()
        if childDetailsDictionary[kParamKeyUserID] != nil {
            paramDict[kParamKeyUserID] = childDetailsDictionary[kParamKeyUserID]
            paramDict[kParamKeyAction] = kAPIActionProfile
            paramDict[kParamKeySaveResponseLocally] = "no"
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
            paramDict = nil
        }
    }

    func age(fromBirthday birthdate: Date) -> Int {
        if birthdate != nil {
            var today = Date()
            var ageComponents: DateComponents? = Calendar.current.dateComponents(.year, from: birthdate, to: today, options: [])
            return ageComponents?.year!
        }
        return 0
    }
// MARK: ----- Actions

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func transferFundsButtonPressed(_ sender: Any) {
        if childDetailsDictionary[kParamKeyUserFirstKnoxTID] != nil && !(childDetailsDictionary[kParamKeyUserFirstKnoxTID] == "") {

        }
        else {
            UIAlertView.show(withTitle: "", message: "You must link the Child's savings account before transferring funds. Would you like to link one now?", cancelButtonTitle: "No", otherButtonTitles: ["Yes"], tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex != alertView.cancelButtonIndex {
                    self.addBankAccountButtonPressed(forBankAccountType: 2, andUserInfoDict: self.childDetailsDictionary)
                }
            })
            return
        }
        if STUserIdentity.sharedInstance().userKnoxFirstTransactionID() != nil && !(STUserIdentity.sharedInstance().userKnoxFirstTransactionID() == "") {
            if childDetailsDictionary[kParamKeyUserFirstKnoxTID] != nil && !(childDetailsDictionary[kParamKeyUserFirstKnoxTID] == "") {
                var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                var parentMakePaymentVC: STParentMakePaymentViewController? = storyboard.instantiateViewController(withIdentifier: "STParentMakePaymentViewController")
                parentMakePaymentVC?.childDictionary = childDetailsDictionary
                navigationController?.pushViewController(parentMakePaymentVC, animated: true)
            }
            else {
                UIAlertView.show(withTitle: "", message: "You must link the Child's savings account before transferring funds. Would you like to link one now?", cancelButtonTitle: "No", otherButtonTitles: ["Yes"], tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                    if buttonIndex != alertView.cancelButtonIndex {
                        self.addBankAccountButtonPressed(forBankAccountType: 2, andUserInfoDict: self.childDetailsDictionary)
                    }
                })
            }
        }
        else {
            UIAlertView.show(withTitle: "", message: "You must link your bank account before transfering funds to child. Would you like to link one now?", cancelButtonTitle: "No", otherButtonTitles: ["Yes"], tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex != alertView.cancelButtonIndex {
                    self.addBankAccountButtonPressed(forBankAccountType: 1, andUserInfoDict: self.childDetailsDictionary)
                }
            })
        }
    }

    @IBAction func viewHistoryButtonPressed(_ sender: Any) {
        UIAlertView.show(withTitle: "", message: "Under Development!", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
            if buttonIndex == alertView.cancelButtonIndex {

            }
        })
    }

    func addBankAccountButtonPressed(forBankAccountType bankAccType: Int, andUserInfoDict dict: [AnyHashable: Any]) {
        if bankAccType == 1 {
            /*
                    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    STParentPaymentFlowViewController *parentPaymentFlowVC = [storyboard instantiateViewControllerWithIdentifier:@"STParentPaymentFlowViewController"];
                    parentPaymentFlowVC.paymentParamsDict  = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0.01",@"amount",@"Add parent bank account",@"description", nil];
                    parentPaymentFlowVC.delegate = self;
                    parentPaymentFlowVC.bankAccountTypeInt = 1;
                    [self.navigationController pushViewController:parentPaymentFlowVC animated:YES];
                     */
            if linkBankAccountVC != nil {
                linkBankAccountVC = nil
            }
            linkBankAccountVC = STPaymentLinkBankViewController(nibName: "STPaymentLinkBankViewController", bundle: Bundle.main)
            navigationController?.pushViewController(linkBankAccountVC, animated: true)
        }
        else if bankAccType == 2 {
            /*
                    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    STParentPaymentFlowViewController *parentPaymentFlowVC = [storyboard instantiateViewControllerWithIdentifier:@"STParentPaymentFlowViewController"];
                    parentPaymentFlowVC.paymentParamsDict  = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0.01",@"amount",@"Add child bank account",@"description", dict,@"childInfoDict",nil];
                    parentPaymentFlowVC.delegate = self;
                    parentPaymentFlowVC.bankAccountTypeInt = 2;
                    [self.navigationController pushViewController:parentPaymentFlowVC animated:YES];
                     */
            if linkBankAccountVC != nil {
                linkBankAccountVC = nil
            }
            linkBankAccountVC = STPaymentLinkBankViewController(nibName: "STPaymentLinkBankViewController", bundle: Bundle.main)
            navigationController?.pushViewController(linkBankAccountVC, animated: true)
        }

    }

    func addAccountSuccessFull(withDict dict: [AnyHashable: Any], andBankAccountUserType bankAccType: Int) {
        //NSLog(@"Add account successful %@",dict);
        if bankAccType == 1 {
            UIAlertView.show(withTitle: "", message: "Parent's Account linked!", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {

                }
            })
        }
        else if bankAccType == 2 {
            UIAlertView.show(withTitle: "", message: "Child's Account linked!", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {

                }
            })
        }

    }

    func rightGestureHandle() {
        navigationController?.popViewController(animated: true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: nil)
    }
// MARK: ----- Table Parent names

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherCommandersArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var stUserCellIdentifier: String = "STUserCustomTableViewCell"
        var cell: STUserCustomTableViewCell? = tableView.dequeueReusableCell(withIdentifier: stUserCellIdentifier)
        if cell == nil {
            cell = (Bundle.main.loadNibNamed(NSStringFromClass(STUserCustomTableViewCell.self), owner: self, options: [])[0] as? STUserCustomTableViewCell)
        }
        if otherCommandersArray != nil {
            if otherCommandersArray.count > indexPath.row {
                cell?.selectionStyle = []
                cell?.labelName?.text = "\(otherCommandersArray[indexPath.row][kParamKeyFirstname]) \(otherCommandersArray[indexPath.row][kParamKeyLastname])"
                cell?.labelName?.textColor = UIColor.stasherText()
                cell?.imgViewDivider?.isHidden = true
                cell?.labelName?.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
                if !(otherCommandersArray[indexPath.row][kParamKeyAvatar] is NSNull) {
                    cell?.imgViewProfilePic?.setImageWith(URL(string: otherCommandersArray[indexPath.row][kParamKeyAvatar]), placeholderImage: UIImage(named: "Stasher_FacePlaceHolder"))
                }
                cell?.imgViewCellDetail?.isHidden = true
            }
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print("selected parent \("\(otherCommandersArray[indexPath.row][kParamKeyFirstname]) \(otherCommandersArray[indexPath.row][kParamKeyLastname])")")
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDictionary != nil {
                if responseDictionary?["usedetails"] && (responseDictionary?["usedetails"] is [AnyHashable: Any]) {
                    if responseDictionary?[kParamKeyParent] {
                        if (responseDictionary?[kParamKeyParent] is [Any]) {
                            otherCommandersArray = responseDictionary?[kParamKeyParent]
                            for dict: [AnyHashable: Any] in otherCommandersArray {
                                if (dict[kParamKeyUserID] == STUserIdentity.sharedInstance().userId()) {
                                    otherCommandersArray.remove(at: otherCommandersArray.index(of: dict)!)
                                }
                            }
                            if otherCommandersArray.count < 1 {
                                otherChallengersLabel.isHidden = true
                            }
                            else {
                                otherChallengersLabel.isHidden = false
                            }
                            tableOtherCommanders.reloadData()
                            adjustHeightOfTableview()
                        }
                    }
                }
            }
        }
    }
}