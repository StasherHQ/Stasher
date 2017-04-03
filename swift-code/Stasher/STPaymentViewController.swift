//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STPaymentViewController.swift
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STPaymentViewController: UIViewController, ParentPaymentDelegate, AddChildDelegate, ChildPaymentDelegate, ParentPaymentFlowDelegate {
    var parentPaymentVC: STParentPaymentViewController?
    var childPaymentVC: STChildPaymentViewController?
    var httpReq: BOABHttpReq?
    var linkBankAccountVC: STPaymentLinkBankViewController?

    @IBOutlet var containerView: UIView!
    @IBOutlet var paymentsScrollview: UIScrollView!
    @IBOutlet var headerLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.font = UIFont()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
            var childsArray = [Any](arrayLiteral: STUserIdentity.sharedInstance().getChildrenArray())
            if parentPaymentVC == nil {
                parentPaymentVC = STParentPaymentViewController(nibName: "STParentPaymentViewController", bundle: Bundle.main, andChildNamesArray: childsArray)
            }
            parentPaymentVC?.view?.frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(containerView?.frame?.size?.width), height: CGFloat(containerView?.frame?.size?.height))
            parentPaymentVC?.delegate = self
            containerView?.addSubview(parentPaymentVC?.view, withAnimation: false)
        }
        else if STUserIdentity.sharedInstance().userIdentity() == CHILDUSER {
            var parentsArray = [Any](arrayLiteral: STUserIdentity.sharedInstance().getParentsArray())
            if childPaymentVC == nil {
                childPaymentVC = STChildPaymentViewController(nibName: "STChildPaymentViewController", bundle: Bundle.main, andParentnamesArray: parentsArray)
            }
            childPaymentVC?.delegate = self
            childPaymentVC?.view?.frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(containerView?.frame?.size?.width), height: CGFloat(containerView?.frame?.size?.height))
            containerView?.addSubview(childPaymentVC?.view, withAnimation: false)
        }

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
// MARK: ---------------------- Parent ----------------------

    func addChildButtonPressed() {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var addChildVC: STAddChildViewController? = storyboard.instantiateViewController(withIdentifier: "STAddChildViewController")
        addChildVC?.delegate = self
        navigationController?.pushViewController(addChildVC, animated: true)
    }

    func childAdded(withUserDetailsDictionary infoDict: [AnyHashable: Any]) {
        requestUserDetails()
    }

    func childNameSelected(withDictionary childDict: [AnyHashable: Any]) {
        print("child dict \(childDict)")
        if childDict[kParamKeyUserFirstKnoxTID] != nil && !(childDict[kParamKeyUserFirstKnoxTID] == "") {

        }
        else {
            UIAlertView.show(withTitle: "", message: "You must link the Child's savings account before transferring funds. Would you like to link one now?", cancelButtonTitle: "No", otherButtonTitles: ["Yes"], tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex != alertView.cancelButtonIndex {
                    self.addBankAccountButtonPressed(forBankAccountType: 2, andUserInfoDict: childDict)
                }
            })
            return
        }
        if STUserIdentity.sharedInstance().userKnoxFirstTransactionID() != nil && !(STUserIdentity.sharedInstance().userKnoxFirstTransactionID() == "") {
            if childDict[kParamKeyUserFirstKnoxTID] != nil && !(childDict[kParamKeyUserFirstKnoxTID] == "") {
                var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                var parentMakePaymentVC: STParentMakePaymentViewController? = storyboard.instantiateViewController(withIdentifier: "STParentMakePaymentViewController")
                parentMakePaymentVC?.childDictionary = childDict
                navigationController?.pushViewController(parentMakePaymentVC, animated: true)
            }
            else {
                UIAlertView.show(withTitle: "", message: "You must link the Child's savings account before transferring funds. Would you like to link one now?", cancelButtonTitle: "No", otherButtonTitles: ["Yes"], tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                    if buttonIndex != alertView.cancelButtonIndex {
                        self.addBankAccountButtonPressed(forBankAccountType: 2, andUserInfoDict: childDict)
                    }
                })
            }
        }
        else {
            UIAlertView.show(withTitle: "", message: "You must link your bank account before transfering funds to child. Would you like to link one now?", cancelButtonTitle: "No", otherButtonTitles: ["Yes"], tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex != alertView.cancelButtonIndex {
                    self.addBankAccountButtonPressed(forBankAccountType: 1, andUserInfoDict: nil)
                }
            })
        }
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

    func addBankAccountButtonPressed() {
        addBankAccountButtonPressed(forBankAccountType: 1, andUserInfoDict: nil)
    }

    func addAccountSuccessFull(withDict dict: [AnyHashable: Any], andBankAccountUserType bankAccType: Int) {
        if bankAccType == 1 {
            if parentPaymentVC != nil {
                parentPaymentVC?.dictBankAccountInfo = dict
                parentPaymentVC?.refreshViewOnLinkedAccount()
            }
        }
        else if bankAccType == 2 {
            var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            var parentMakePaymentVC: STParentMakePaymentViewController? = storyboard.instantiateViewController(withIdentifier: "STParentMakePaymentViewController")
            parentMakePaymentVC?.childDictionary = dict
            navigationController?.pushViewController(parentMakePaymentVC, animated: true)
        }

    }
// MARK: ---------------------- Child -----------------------

    func childPaymentRequestPaymentParentSelected(withDictionary dict: [AnyHashable: Any]) {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var childPaymentRequestVC: STChildPaymentRequestViewController? = storyboard.instantiateViewController(withIdentifier: "STChildPaymentRequestViewController")
        childPaymentRequestVC?.parentInfoDict = dict
        navigationController?.pushViewController(childPaymentRequestVC, animated: true)
    }
// MARK: ----- Custom Methods

    func requestUserDetails() {
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        var paramDict = [AnyHashable: Any]()
        if STUserIdentity.sharedInstance().userId() != nil {
            paramDict[kParamKeyUserID] = STUserIdentity.sharedInstance().userId()
            paramDict[kParamKeyAction] = kAPIActionProfile
            paramDict[kParamKeySaveResponseLocally] = "yes"
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
            paramDict = nil
        }
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDictionary != nil {
                if responseDictionary?["usedetails"] && (responseDictionary?["usedetails"] is [AnyHashable: Any]) {
                    STUserIdentity.sharedInstance().userInformationDictionary = responseDictionary?["usedetails"]
                    var logInInfoDictionary: [AnyHashable: Any]? = (responseDictionary?["usedetails"] as? [AnyHashable: Any])?
                    logInInfoDictionary?[kUserDefaultsIsUserLoggedIn] = Int(1)
                    STLogInManager.sharedInstance().updateUserDefaultsInLogInManager(withDictionary: logInInfoDictionary)
                    print("usertype \(STUserIdentity.sharedInstance().userIdentity())")
                    if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
                        if parentPaymentVC != nil {
                            if responseDictionary?[kParamKeyChild] {
                                if (responseDictionary?[kParamKeyChild] is [Any]) {
                                    parentPaymentVC?.childrenArray = responseDictionary?[kParamKeyChild]
                                }
                            }
                            parentPaymentVC?.childNamesListTableView?.reloadData()
                        }
                    }
                    else if STUserIdentity.sharedInstance().userIdentity() == CHILDUSER {

                    }
                }
            }
        }
    }
}