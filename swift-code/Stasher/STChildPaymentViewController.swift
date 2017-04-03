//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STChildPaymentViewController.swift
//  Stasher
//
//  Created by bhushan on 02/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol ChildPaymentDelegate: NSObjectProtocol {
    func childPaymentRequestPaymentParentSelected(withDictionary dict: [AnyHashable: Any])
}
class STChildPaymentViewController: UIViewController {

    weak var delegate: ChildPaymentDelegate?
    var parentArray = [Any]()
    @IBOutlet var parentNamesTable: UITableView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var mySavingsLabel: UILabel!
    @IBOutlet var requestFromLabel: UILabel!
    @IBOutlet var savingsAmountLabel: UILabel!
    @IBOutlet var savingsDollarLabel: UILabel!
    @IBOutlet var myHistoryLabel: UIButton!
    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet var controlsContainerView: UIView!
    @IBOutlet weak var constraintHeightControlContainerView: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightParentTableView: NSLayoutConstraint!

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, andParentnamesArray thisParentsArray: [Any]) {
        super.init(nibName: "STChildPaymentViewController", bundle: Bundle.main)
        
        parentArray = [Any](arrayLiteral: thisParentsArray)
        //[self performSelector:@selector(adjustHeightOfTableview) withObject:self afterDelay:1.01];
    
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        headerLabel.font = UIFont.fontGothamRoundedBook(withSize: 20.0)
        var font1 = UIFont()
        var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
        var aAttrString1 = NSMutableAttributedString(string: "My ", attributes: arialDict)
        var font2 = UIFont.fontGothamRoundedBold(withSize: 20.0)
        var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
        var aAttrString2 = NSMutableAttributedString(string: "Savings", attributes: arialDict2)
        aAttrString1.append(aAttrString2)
        mySavingsLabel.attributedText = aAttrString1
        mySavingsLabel.textColor = UIColor.stasherText()
        requestFromLabel.textColor = UIColor.stasherText()
        requestFromLabel.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        var font4 = UIFont.fontGothamRoundedMedium(withSize: 11.5)
        var arialDict4: [AnyHashable: Any] = [ NSFontAttributeName : font4 ]
        var aAttrString4 = NSMutableAttributedString(string: "\("$")", attributes: arialDict4)
        var font5 = UIFont.fontGothamRoundedBold(withSize: 21.21)
        var arialDict5: [AnyHashable: Any] = [ NSFontAttributeName : font5 ]
        var aAttrString5 = NSMutableAttributedString(string: "\("\(STUserIdentity.sharedInstance().savingsAmount())")", attributes: arialDict5)
        aAttrString4.append(aAttrString5)
        savingsAmountLabel.attributedText = aAttrString4
        myHistoryLabel.titleLabel?.font = UIFont(size: 11.0)
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
        var height: CGFloat = parentNamesTable.contentSize.height
        var maxHeight: CGFloat? = parentNamesTable.superview?.frame?.size?.height - parentNamesTable.frame.origin.y
        // if the height of the content is greater than the maxHeight of
        // total space on the screen, limit the height to the size of the
        // superview.
        if height > maxHeight {
            height = maxHeight
        }
            // now set the frame accordingly
        var frame: CGRect = parentNamesTable.frame
        frame.size.height = height
        parentNamesTable.frame = frame
        // if you have other controls that should be resized/moved to accommodate
        // the resized tableview, do that here, too
        tableHeightConstraint.constant = parentNamesTable.contentSize.height + 100.0
        constraintHeightControlContainerView.constant = parentNamesTable.frame.origin.y + parentNamesTable.contentSize.height + 8.0 + 100.0
    }
// MARK: ----- Actions

    @IBAction func myHistoryButtonPressed(_ sender: Any) {
        UIAlertView.show(withTitle: "", message: "Under Development!", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
            if buttonIndex == alertView.cancelButtonIndex {

            }
        })
    }
// MARK: ----- Table Parent names

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var stUserCellIdentifier: String = "STUserCustomTableViewCell"
        var cell: STUserCustomTableViewCell? = tableView.dequeueReusableCell(withIdentifier: stUserCellIdentifier)
        if cell == nil {
            cell = (Bundle.main.loadNibNamed(NSStringFromClass(STUserCustomTableViewCell.self), owner: self, options: [])[0] as? STUserCustomTableViewCell)
        }
        if parentArray != nil {
            if parentArray.count > indexPath.row {
                cell?.selectionStyle = []
                cell?.labelName?.text = "\(parentArray[indexPath.row][kParamKeyFirstname]) \(parentArray[indexPath.row][kParamKeyLastname])"
                cell?.labelName?.textColor = UIColor.stasherText()
                cell?.labelName?.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
                cell?.imgViewDivider?.isHidden = true
                if !(parentArray[indexPath.row][kParamKeyAvatar] is NSNull) {
                    cell?.imgViewProfilePic?.setImageWith(URL(string: parentArray[indexPath.row][kParamKeyAvatar]), placeholderImage: UIImage(named: "Stasher_FacePlaceHolder"))
                }
            }
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if delegate?.responds(to: #selector(self.childPaymentRequestPaymentParentSelectedWithDictionary)) {
            delegate?.childPaymentRequestPaymentParentSelected(withDictionary: parentArray[indexPath.row])
        }
    }
}