//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STChildAccountViewController.swift
//  Stasher
//
//  Created by bhushan on 18/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol ChildAccountDelegate: NSObjectProtocol {
    func childAccountAddParentButtonPressed(_ sender: UIButton)

    func childAccountEditProfileButtonPressed(_ sender: UIButton)

    func childAccountParentDetailsSelected(withDictionary dict: [AnyHashable: Any])
}
class STChildAccountViewController: UIViewController {

    weak var delegate: ChildAccountDelegate?
    var parentArray = [Any]()
    @IBOutlet var profilePicButton: UIButton!
    @IBOutlet var profilePicImageView: UIImageView!
    @IBOutlet var labelUsername: UILabel!
    @IBOutlet var labelFullname: UILabel!
    @IBOutlet var editProfileButton: UIButton!
    @IBOutlet var parentNamesTable: UITableView!
    @IBOutlet var addCommandersNoTableButton: UIButton!
    @IBOutlet var addCommandersButton: UIButton!
    @IBOutlet var noCommandersLabel: UILabel!
    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet var labelMyCommanders: UILabel!
    @IBOutlet var labelMySavings: UILabel!
    @IBOutlet var controlsContainerView: UIView!
    @IBOutlet weak var constraintHeightControlContainerView: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightParentTableView: NSLayoutConstraint!

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, withParentArray thisParentArray: [Any]) {
        super.init(nibName: "STChildAccountViewController", bundle: Bundle.main)
        
        parentArray = [Any](arrayLiteral: thisParentArray)
    
    }

    func refreshViewForNewParents() {
        if parentArray.count == 0 {
            parentNamesTable.isHidden = true
            addCommandersNoTableButton.isHidden = false
            noCommandersLabel.isHidden = false
        }
        else {
            parentNamesTable.isHidden = false
            addCommandersNoTableButton.isHidden = true
            noCommandersLabel.isHidden = true
        }
        adjustHeightOfTableview()
    }

    func refreshViewLabelsOnEditProfile() {
        labelFullname.text = "\(STUserIdentity.sharedInstance().firstName) \(STUserIdentity.sharedInstance().lastName)"
        labelUsername.text = STUserIdentity.sharedInstance().username
        labelMySavings.text = "My Savings : $\(STUserIdentity.sharedInstance().savingsAmount())"
        if !(STUserIdentity.sharedInstance().avatarUrlString() is NSNull) && !(STUserIdentity.sharedInstance().avatarUrlString() == "") {
            profilePicImageView.setImageWith(URL(string: STUserIdentity.sharedInstance().avatarUrlString()), placeholderImage: UIImage(named: "account_face_placeholder"))
        }
        else {
            profilePicImageView.image = UIImage(named: "account_face_placeholder")
        }
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        adjustHeightOfTableview()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refreshViewForNewParents()
        refreshViewLabelsOnEditProfile()
        if !(STUserIdentity.sharedInstance().avatarUrlString() is NSNull) && !(STUserIdentity.sharedInstance().avatarUrlString() == "") {
            profilePicImageView.setImageWith(URL(string: STUserIdentity.sharedInstance().avatarUrlString()), placeholderImage: UIImage(named: "account_face_placeholder"))
        }
        else {
            profilePicImageView.image = UIImage(named: "account_face_placeholder")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        profilePicImageView.clipsToBounds = true
        profilePicImageView.layer.cornerRadius = 80 / 2.0
        profilePicImageView.layer.borderColor = UIColor.clear.cgColor
        profilePicImageView.layer.borderWidth = 2.0
        profilePicImageView.contentMode = .scaleAspectFill
        profilePicButton.clipsToBounds = true
        profilePicButton.layer.cornerRadius = 80 / 2.0
        profilePicButton.layer.borderColor = UIColor.clear.cgColor
        profilePicButton.layer.borderWidth = 0.5
        labelUsername.font = UIFont.fontGothamRoundedMedium(withSize: 18.0)
        labelFullname.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        editProfileButton.titleLabel?.font = UIFont(size: 11.0)
        addCommandersButton.titleLabel?.font = UIFont(size: 11.0)
        addCommandersNoTableButton.titleLabel?.font = UIFont(size: 11.0)
        noCommandersLabel.font = UIFont.fontGothamRounded(withSize: 10.0)
        labelMyCommanders.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        labelMySavings.font = UIFont.fontGothamRoundedMedium(withSize: 16.0)
        labelMyCommanders.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        labelUsername.textColor = UIColor.stasherText()
        labelFullname.textColor = UIColor.stasherTextFieldPlaceHolder()
        labelMyCommanders.textColor = UIColor.stasherText()
        labelMySavings.textColor = UIColor.stasherText()
        editProfileButton.setTitleColor(UIColor.stasherTextFieldPlaceHolder(), for: .normal)
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

    @IBAction func editMyProfileButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.childAccountEditProfileButtonPressed)) {
            delegate?.childAccountEditProfileButtonPressed(sender)
        }
    }

    @IBAction func addCommanderButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.childAccountAddParentButtonPressed)) {
            delegate?.childAccountAddParentButtonPressed(sender)
        }
    }
// MARK: ----- Custom Methods

    func adjustHeightOfTableview() {
        var height: CGFloat = parentNamesTable.contentSize.height
        constraintHeightParentTableView.constant = parentNamesTable.contentSize.height
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
        var addCommanderButtonFrame: CGRect = addCommandersButton.frame
        addCommanderButtonFrame.origin.y = parentNamesTable.frame.origin.y + parentNamesTable.contentSize.height + 8
        //[self.addCommandersButton setFrame:addCommanderButtonFrame];
        constraintHeightControlContainerView.constant = addCommanderButtonFrame.origin.y + addCommanderButtonFrame.size.height + 8
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
                cell?.imgViewDivider?.isHidden = true
                cell?.labelName?.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
                if !(parentArray[indexPath.row][kParamKeyAvatar] is NSNull) {
                    cell?.imgViewProfilePic?.setImageWith(URL(string: parentArray[indexPath.row][kParamKeyAvatar]), placeholderImage: UIImage(named: "Stasher_FacePlaceHolder"))
                }
            }
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if delegate?.responds(to: #selector(self.childAccountParentDetailsSelectedWithDictionary)) {
            delegate?.childAccountParentDetailsSelected(withDictionary: parentArray[indexPath.row])
        }
    }
}