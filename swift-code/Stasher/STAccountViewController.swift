//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STAccountViewController.swift
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STAccountViewController: UIViewController, ParentAccountDeleegate, ChildAccountDelegate, AddChildDelegate, AddParentDelegate, EditProfileDelegate, LogInManagerDelegate {
    var httpReq: BOABHttpReq?
    var parentAccountVC: STParentAccountViewController?
    var childAccountVC: STChildAccountViewController?

    @IBOutlet var accountContainerView: UIView!
    @IBOutlet var headerlabel: UILabel!
    @IBOutlet var settingsButton: UIButton!

    func requestUserDetails() {
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        if httpReq?.reachable {
            var paramDict = [AnyHashable: Any]()
            if STUserIdentity.sharedInstance().userId() != nil {
                paramDict[kParamKeyUserID] = STUserIdentity.sharedInstance().userId()
                if STUserIdentity.sharedInstance().userKnoxFirstTransactionID() != nil && !(STUserIdentity.sharedInstance().userKnoxFirstTransactionID() == "") {
                    paramDict[kParamKeyUserFirstKnoxTID] = STUserIdentity.sharedInstance().userKnoxFirstTransactionID()
                }
                paramDict[kParamKeyAction] = kAPIActionProfile
                paramDict[kParamKeySaveResponseLocally] = "yes"
                httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
                paramDict = nil
            }
        }
        else {
            var data = STCacheManager.sharedInstance().getJSONData(forAPIName: kAPIActionProfile)
            if data != nil {
                var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: data, options: kNilOptions)
                if responseDictionary != nil {
                    callUserViews(forResponseDict: responseDictionary)
                }
            }
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //[self.revealViewController rightRevealToggle:_settingsButton];
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tabBarController?.tabBar?.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //[_settingsButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        // Set the gesture
        //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        // Do any additional setup after loading the view.
        headerlabel.font = UIFont()
        requestUserDetails()
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

    @IBAction func logOutButtonPressed(_ sender: Any) {
        UIAlertView.show(withTitle: "", message: "Do you want to Log Out of Stasher?", cancelButtonTitle: "Cancel", otherButtonTitles: ["Log Out"], tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
            if buttonIndex != alertView.cancelButtonIndex {
                STLogInManager.sharedInstance().logOut()
            }
        })
    }

    @IBAction func settingsButtonPressed(_ sender: Any) {
        var settingsVC = STSettingsViewController(nibName: "STSettingsViewController", bundle: Bundle.main)
        navigationController?.pushViewController(settingsVC, animated: true)
    }
// MARK: ----- Custom Methods
// MARK: ----- ParentAccountDelegate

    func addChildButtonPressed(_ btn: UIButton) {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var addChildVC: STAddChildViewController? = storyboard.instantiateViewController(withIdentifier: "STAddChildViewController")
        addChildVC?.delegate = self
        navigationController?.pushViewController(addChildVC, animated: true)
    }

    func editProfileButtonPressed(_ btn: UIButton) {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var editProfileVC: STEditProfileViewController? = storyboard.instantiateViewController(withIdentifier: "STEditProfileViewController")
        editProfileVC?.delegate = self
        navigationController?.pushViewController(editProfileVC, animated: true)
    }

    func childDetailsSelected(withDict dict: [AnyHashable: Any]) {
        var childDetailsVC = STParentAccountChildDetailsViewController(nibName: "STParentAccountChildDetailsViewController", bundle: Bundle.main, withChildDetailsDictionary: dict)
        navigationController?.pushViewController(childDetailsVC, animated: true)
    }

    func createChildButtonPressed() {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var editProfileVC: STCreateChildViewController? = storyboard.instantiateViewController(withIdentifier: "STCreateChildViewController")
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
// MARK: ---- Add Child Delegate

    func childAdded(withUserDetailsDictionary infoDict: [AnyHashable: Any]) {
        requestUserDetails()
    }
// MARK: ----- Child Account Delegate

    func childAccountAddParentButtonPressed(_ sender: UIButton) {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var addParentVC: STAddParentViewController? = storyboard.instantiateViewController(withIdentifier: "STAddParentViewController")
        addParentVC?.delegate = self
        navigationController?.pushViewController(addParentVC, animated: true)
    }

    func childAccountEditProfileButtonPressed(_ sender: UIButton) {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var editProfileVC: STEditProfileViewController? = storyboard.instantiateViewController(withIdentifier: "STEditProfileViewController")
        editProfileVC?.delegate = self
        navigationController?.pushViewController(editProfileVC, animated: true)
    }

    func childAccountParentDetailsSelected(withDictionary dict: [AnyHashable: Any]) {
        var childAccountParentDetailsVC = STChildAccountParentDetailsViewController(nibName: "STChildAccountParentDetailsViewController", bundle: Bundle.main, andParentDetailsDictionary: dict)
        navigationController?.pushViewController(childAccountParentDetailsVC, animated: true)
    }
// MARK: ----- Add Parent Delegate

    func parentAdded(withUserDetailsDictionary infoDict: [AnyHashable: Any]) {
        requestUserDetails()
    }
// MARK: ----- EditProfile Delegate

    func profileSuccessfullyEdited() {
        requestUserDetails()
    }

    func passwordChangedLogInAgain() {
        /*
            [UIAlertView showWithTitle:@""
                               message:@"Password Changed, You will be logged out!"
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  if (buttonIndex == [alertView cancelButtonIndex]) {
                                       [self logOutButtonPressed:nil];
                                  }
                              }];
             */
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            print("Profile responseDict \(responseDictionary)")
            if responseDictionary != nil {
                callUserViews(forResponseDict: responseDictionary)
            }
        }
    }

    func boabHttpReqFailedWithError(_ error: Error?) {
        if error != nil {
            var data = STCacheManager.sharedInstance().getJSONData(forAPIName: kAPIActionProfile)
            if data != nil {
                var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: data, options: kNilOptions)
                if responseDictionary != nil {
                    callUserViews(forResponseDict: responseDictionary)
                }
            }
        }
    }

    func callUserViews(forResponseDict responseDictionary: [AnyHashable: Any]) {
        if !responseDictionary.isEmpty {
            if responseDictionary["usedetails"] && (responseDictionary["usedetails"] is [AnyHashable: Any]) {
                STUserIdentity.sharedInstance().userInformationDictionary = responseDictionary["usedetails"]
                var logInInfoDictionary: [AnyHashable: Any]? = (responseDictionary["usedetails"] as? [AnyHashable: Any])?
                logInInfoDictionary?[kUserDefaultsIsUserLoggedIn] = Int(1)
                STLogInManager.sharedInstance().updateUserDefaultsInLogInManager(withDictionary: logInInfoDictionary)
                var frameForAccountView: CGRect = accountContainerView.frame
                frameForAccountView.origin.y = 0.0
                print("usertype \(STUserIdentity.sharedInstance().userIdentity())")
                if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
                    if parentAccountVC != nil {
                        parentAccountVC?.delegate = nil
                        parentAccountVC?.view?.removeFromSuperview()
                        parentAccountVC = nil
                    }
                    parentAccountVC = STParentAccountViewController(nibName: "STParentAccountViewController", bundle: Bundle.main, withChildArray: nil)
                    if responseDictionary[kParamKeyChild] {
                        if (responseDictionary[kParamKeyChild] is [Any]) {
                            parentAccountVC?.childArray = responseDictionary[kParamKeyChild]
                        }
                    }
                    parentAccountVC?.view?.frame = frameForAccountView
                    var parentViewRect: CGRect? = parentAccountVC?.view?.frame
                    parentViewRect?.size?.width = accountContainerView.frame.size.width
                    parentViewRect?.size?.height = accountContainerView.frame.size.height
                    accountContainerView.addSubview(parentAccountVC?.view, withAnimation: false)
                    parentAccountVC?.delegate = self
                    parentAccountVC?.childNamesTable?.reloadData()
                    parentAccountVC?.refreshViewForEditedProfile()
                    parentAccountVC?.refreshViewOnForNewChilds()
                }
                else if STUserIdentity.sharedInstance().userIdentity() == CHILDUSER {
                    if childAccountVC != nil {
                        childAccountVC?.delegate = nil
                        childAccountVC?.view?.removeFromSuperview()
                        childAccountVC = nil
                    }
                    var vcIdentifier: String
                    vcIdentifier = "STChildAccountViewController"
                    childAccountVC = STChildAccountViewController(nibName: vcIdentifier, bundle: Bundle.main)
                    if responseDictionary[kParamKeyParent] {
                        if (responseDictionary[kParamKeyParent] is [Any]) {
                            childAccountVC?.parentArray = responseDictionary[kParamKeyParent]
                        }
                    }
                    childAccountVC?.view?.frame = frameForAccountView
                    var childViewRect: CGRect? = childAccountVC?.view?.frame
                    childViewRect?.size?.width = accountContainerView.frame.size.width
                    childViewRect?.size?.height = accountContainerView.frame.size.height
                    accountContainerView.addSubview(childAccountVC?.view, withAnimation: false)
                    childAccountVC?.delegate = self
                    childAccountVC?.parentNamesTable?.reloadData()
                    childAccountVC?.refreshViewForNewParents()
                    childAccountVC?.refreshViewLabelsOnEditProfile()
                }
            }
        }
    }
// MARK: ----- LogInManager Delegate

    func userLoggedOutSuccessfully() {
    }
}