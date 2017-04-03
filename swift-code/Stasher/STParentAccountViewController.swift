//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STParentAccountViewController.swift
//  Stasher
//
//  Created by bhushan on 18/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol ParentAccountDeleegate: NSObjectProtocol {
    func addChildButtonPressed(_ btn: UIButton)

    func editProfileButtonPressed(_ btn: UIButton)

    func childDetailsSelected(withDict dict: [AnyHashable: Any])

    func createChildButtonPressed()
}
class STParentAccountViewController: UIViewController {

    weak var delegate: ParentAccountDeleegate?
    @IBOutlet var profilePicButton: UIButton!
    @IBOutlet var profilePicImageView: UIImageView!
    @IBOutlet var labelUsername: UILabel!
    @IBOutlet var labelFullname: UILabel!
    @IBOutlet var editProfileButton: UIButton!
    @IBOutlet var addChildButton: UIButton!
    @IBOutlet var addChildButtonNoTable: UIButton!
    @IBOutlet var childNamesTable: UITableView!
    @IBOutlet var myChildrenslabel: UILabel!
    var childArray = [Any]()
    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet var controlsContainerView: UIView!
    @IBOutlet weak var constraintHeightControlContainerView: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightParentTableView: NSLayoutConstraint!
    @IBOutlet var createChildButton: UIButton!

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, withChildArray thisChildArray: [Any]) {
        super.init(nibName: "STParentAccountViewController", bundle: Bundle.main)
        
        childArray = [Any](arrayLiteral: thisChildArray)
    
    }

    func refreshViewOnForNewChilds() {
        if childArray.count == 0 {
            childNamesTable.isHidden = true
            addChildButtonNoTable.isHidden = false
            myChildrenslabel.isHidden = true
        }
        else {
            childNamesTable.isHidden = false
            addChildButtonNoTable.isHidden = true
            myChildrenslabel.isHidden = false
        }
        adjustHeightOfTableview()
    }

    func refreshViewForEditedProfile() {
        labelFullname.text = "\(STUserIdentity.sharedInstance().firstName) \(STUserIdentity.sharedInstance().lastName)"
        labelUsername.text = STUserIdentity.sharedInstance().username
        if !(STUserIdentity.sharedInstance().avatarUrlString() is NSNull) && !(STUserIdentity.sharedInstance().avatarUrlString() == "") {
            profilePicImageView.setImageWith(URL(string: STUserIdentity.sharedInstance().avatarUrlString()), placeholderImage: UIImage(named: "account_face_placeholder"))
        }
        else {
            profilePicImageView.image = UIImage(named: "account_face_placeholder")
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refreshViewOnForNewChilds()
        refreshViewForEditedProfile()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        // Do any additional setup after loading the view.
        profilePicButton.clipsToBounds = true
        profilePicButton.layer.cornerRadius = 80 / 2.0
        profilePicButton.layer.borderColor = UIColor.clear.cgColor
        profilePicButton.layer.borderWidth = 0.5
        profilePicImageView.clipsToBounds = true
        profilePicImageView.layer.cornerRadius = 80 / 2.0
        profilePicImageView.layer.borderColor = UIColor.clear.cgColor
        profilePicImageView.layer.borderWidth = 2.0
        profilePicImageView.contentMode = .scaleAspectFill
        labelUsername.font = UIFont.fontGothamRoundedMedium(withSize: 18.0)
        labelFullname.textColor = UIColor.stasherTextFieldPlaceHolder()
        labelUsername.textColor = UIColor.stasherText()
        myChildrenslabel.textColor = UIColor.stasherText()
        labelFullname.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        editProfileButton.titleLabel?.font = UIFont(size: 11.0)
        addChildButton.titleLabel?.font = UIFont(size: 11.0)
        addChildButtonNoTable.titleLabel?.font = UIFont(size: 11.0)
        myChildrenslabel.font = UIFont.fontGothamRoundedMedium(withSize: 11.0)
        createChildButton.titleLabel?.font = UIFont(size: 11.0)
        editProfileButton.setTitleColor(UIColor.stasherTextFieldPlaceHolder(), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK: ----- Actions

    @IBAction func editMyProfileButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.editProfileButtonPressed)) {
            delegate?.editProfileButtonPressed(sender)
        }
    }

    @IBAction func addChildButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.addChildButtonPressed)) {
            delegate?.addChildButtonPressed(sender)
        }
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
        var height: CGFloat = childNamesTable.contentSize.height
        constraintHeightParentTableView.constant = childNamesTable.contentSize.height
        var maxHeight: CGFloat? = childNamesTable.superview?.frame?.size?.height - childNamesTable.frame.origin.y
        // if the height of the content is greater than the maxHeight of
        // total space on the screen, limit the height to the size of the
        // superview.
        if height > maxHeight {
            height = maxHeight
        }
            // now set the frame accordingly
        var frame: CGRect = childNamesTable.frame
        frame.size.height = height
        childNamesTable.frame = frame
            // if you have other controls that should be resized/moved to accommodate
            // the resized tableview, do that here, too
        var addChildButtonFrame: CGRect = addChildButton.frame
        addChildButtonFrame.origin.y = childNamesTable.frame.origin.y + childNamesTable.contentSize.height + 8
        //[self.addChildButton setFrame:addChildButtonFrame];
        constraintHeightControlContainerView.constant = addChildButtonFrame.origin.y + addChildButtonFrame.size.height + 8
    }

    @IBAction func createChildButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.createChildButtonPressed)) {
            delegate?.createChildButtonPressed()
        }
    }
// MARK: ----- Table Child Names

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var stUserCellIdentifier: String = "STUserCustomTableViewCell"
        var cell: STUserCustomTableViewCell? = tableView.dequeueReusableCell(withIdentifier: stUserCellIdentifier)
        if cell == nil {
            cell = (Bundle.main.loadNibNamed(NSStringFromClass(STUserCustomTableViewCell.self), owner: self, options: [])[0] as? STUserCustomTableViewCell)
        }
        if childArray != nil {
            if childArray.count > indexPath.row {
                cell?.selectionStyle = []
                cell?.labelName?.text = "\(childArray[indexPath.row][kParamKeyFirstname]) \(childArray[indexPath.row][kParamKeyLastname])"
                cell?.labelName?.textColor = UIColor.stasherText()
                cell?.imgViewDivider?.isHidden = true
                cell?.labelName?.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
                if !(childArray[indexPath.row][kParamKeyAvatar] is NSNull) {
                    cell?.imgViewProfilePic?.setImageWith(URL(string: childArray[indexPath.row][kParamKeyAvatar]), placeholderImage: UIImage(named: "Stasher_FacePlaceHolder"))
                }
            }
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if delegate?.responds(to: #selector(self.childDetailsSelectedWithDict)) {
            delegate?.childDetailsSelected(withDict: childArray[indexPath.row])
        }
    }
}