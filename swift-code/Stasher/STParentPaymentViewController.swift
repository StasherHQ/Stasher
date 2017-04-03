//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STParentPaymentViewController.swift
//  Stasher
//
//  Created by bhushan on 02/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol ParentPaymentDelegate: NSObjectProtocol {
    func addChildButtonPressed()

    func childNameSelected(withDictionary childDict: [AnyHashable: Any])

    func addBankAccountButtonPressed()
}
class STParentPaymentViewController: UIViewController {
    var httpReq: BOABHttpReq?

    weak var delegate: ParentPaymentDelegate?
    var childrenArray = [Any]()
    @IBOutlet var childNamesListTableView: UITableView!
    @IBOutlet var headerlabel: UILabel!
    @IBOutlet var addChildButton: UIButton!
    @IBOutlet var addBankAccountButton: UIButton!
    @IBOutlet var myChildrenLabel: UILabel!
    @IBOutlet var myCardsLabel: UILabel!
    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet var controlsContainerView: UIView!
    @IBOutlet weak var constraintHeightControlContainerView: NSLayoutConstraint!
    @IBOutlet var labelHeadingMyChildren: UILabel!
    @IBOutlet var imgViewNoBankAcc: UIImageView!
    @IBOutlet var labelNoBankAccTitle: UILabel!
    @IBOutlet var labelNoBankAcc: UILabel!
    @IBOutlet var labelHeadingMyCards: UILabel!
    @IBOutlet var tableViewBankAccounts: UITableView!
    var dictBankAccountInfo = [AnyHashable: Any]()
    @IBOutlet weak var constraintBankAccountsTableHeight: NSLayoutConstraint!

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, andChildNamesArray thisChildsArray: [Any]) {
        super.init(nibName: "STParentPaymentViewController", bundle: Bundle.main)
        
        childrenArray = [Any](arrayLiteral: thisChildsArray)
    
    }

    func refreshViewOnLinkedAccount() {
        if STUserIdentity.sharedInstance().userKnoxFirstTransactionID() != nil && !(STUserIdentity.sharedInstance().userKnoxFirstTransactionID() == "") {
            labelHeadingMyCards.isHidden = false
            tableViewBankAccounts.isHidden = false
            tableViewBankAccounts.reloadData()
            imgViewNoBankAcc.isHidden = true
            labelNoBankAccTitle.isHidden = true
            labelNoBankAcc.isHidden = true
            addBankAccountButton.isHidden = false
        }
        else {
            imgViewNoBankAcc.isHidden = false
            labelNoBankAccTitle.isHidden = false
            labelNoBankAcc.isHidden = false
            addBankAccountButton.isHidden = false
            labelHeadingMyCards.isHidden = true
            tableViewBankAccounts.isHidden = true
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        headerlabel.font = UIFont()
        addChildButton.titleLabel?.font = UIFont(size: 11.0)
        addBankAccountButton.titleLabel?.font = UIFont(size: 11.0)
        myCardsLabel.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        myChildrenLabel.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        labelHeadingMyCards.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        labelHeadingMyChildren.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        labelHeadingMyCards.textColor = UIColor.stasherText()
        labelHeadingMyChildren.textColor = UIColor.stasherText()
        labelNoBankAccTitle.font = UIFont.fontGothamRoundedBook(withSize: 10.88)
        labelNoBankAcc.font = UIFont.fontGothamRoundedBook(withSize: 9.83)
        labelNoBankAccTitle.sizeToFit()
        labelNoBankAcc.sizeToFit()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if STUserIdentity.sharedInstance().userKnoxFirstTransactionID() != nil && !(STUserIdentity.sharedInstance().userKnoxFirstTransactionID() == "") {
            if httpReq != nil {
                httpReq?.delegate = nil
                httpReq = nil
            }
            httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
            var userIdString: String
            var apiActionString: String
            userIdString = kParamKeyParentID
            apiActionString = kAPIActionAddBankAccount
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
                userIdString : Int(CInt(STUserIdentity.sharedInstance().userId())),
                kParamKeyAction : apiActionString,
                kParamKeyTransactionID : STUserIdentity.sharedInstance().userKnoxFirstTransactionID()
            ]
, json: true)
        }
        refreshViewOnLinkedAccount()
        if childrenArray.count == 0 {
            myChildrenLabel.isHidden = true
        }
        else {
            myChildrenLabel.isHidden = false
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        adjustHeightOfTableview()
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

    func adjustHeightOfTableview() {
        var height: CGFloat = childNamesListTableView.contentSize.height
        var maxHeight: CGFloat? = childNamesListTableView.superview?.frame?.size?.height - childNamesListTableView.frame.origin.y
        // if the height of the content is greater than the maxHeight of
        // total space on the screen, limit the height to the size of the
        // superview.
        if height > maxHeight {
            height = maxHeight
        }
            // now set the frame accordingly
        var frame: CGRect = childNamesListTableView.frame
        frame.size.height = height
        childNamesListTableView.frame = frame
        // if you have other controls that should be resized/moved to accommodate
        // the resized tableview, do that here, too
        tableHeightConstraint.constant = childNamesListTableView.contentSize.height
        var addChildButtonFrame: CGRect = addChildButton.frame
        addChildButtonFrame.origin.y = childNamesListTableView.frame.origin.y + childNamesListTableView.contentSize.height + 12.0
        addChildButton.frame = addChildButtonFrame
        constraintHeightControlContainerView.constant = addChildButton.frame.origin.y + addChildButton.frame.size.height + 12.0
    }

    @IBAction func addChildButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.addChildButtonPressed)) {
            delegate?.addChildButtonPressed()
        }
    }

    @IBAction func addBankAccountPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.addBankAccountButtonPressed)) {
            delegate?.addBankAccountButtonPressed()
        }
    }
// MARK: ----- Table Child Names

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewBankAccounts {
            return 1
        }
        return childrenArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewBankAccounts {
            var simpleTableIdentifier: String = "SimpleTableCell"
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: simpleTableIdentifier)
            }
            cell?.textLabel?.textColor = UIColor.stasherText()
            cell?.textLabel?.font = UIFont(size: 11.0)
            if !(dictBankAccountInfo is NSNull) {
                if !(dictBankAccountInfo["transaction"]["name"] is NSNull) {
                    cell?.textLabel?.text = dictBankAccountInfo["transaction"]["name"]
                }
            }
            return cell!
        }
        var stUserCellIdentifier: String = "STUserCustomTableViewCell"
        var cell: STUserCustomTableViewCell? = tableView.dequeueReusableCell(withIdentifier: stUserCellIdentifier)
        if cell == nil {
            cell = (Bundle.main.loadNibNamed(NSStringFromClass(STUserCustomTableViewCell.self), owner: self, options: [])[0] as? STUserCustomTableViewCell)
        }
        if childrenArray != nil {
            if childrenArray.count > indexPath.row {
                cell?.selectionStyle = []
                cell?.labelName?.text = "\(childrenArray[indexPath.row][kParamKeyFirstname]) \(childrenArray[indexPath.row][kParamKeyLastname])"
                cell?.labelName?.textColor = UIColor.stasherText()
                cell?.imgViewDivider?.isHidden = true
                cell?.labelName?.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
                if !(childrenArray[indexPath.row][kParamKeyAvatar] is NSNull) {
                    cell?.imgViewProfilePic?.setImageWith(URL(string: childrenArray[indexPath.row][kParamKeyAvatar]), placeholderImage: UIImage(named: "Stasher_FacePlaceHolder"))
                }
            }
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if tableView == childNamesListTableView {
            if delegate?.responds(to: #selector(self.childNameSelectedWithDictionary)) {
                delegate?.childNameSelected(withDictionary: childrenArray[indexPath.row])
            }
        }
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDictionary != nil {
                if !(responseDictionary? is NSNull) {
                    if responseDictionary?["transaction"]["name"] {
                        dictBankAccountInfo = responseDictionary?
                        refreshViewOnLinkedAccount()
                    }
                }
            }
        }
    }
}