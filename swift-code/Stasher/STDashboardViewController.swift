//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STDashboardViewController.swift
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STDashboardViewController: UIViewController, ParentDashboardDelegate, BearPopUpDelegate, AddParentDelegate, AddChildDelegate, ParentPaymentFlowDelegate {
    var parentdashboardVC: STParentDashboardViewController?
    var childDashboardVC: STChildDashboardViewController?
    var childDetailsVC: STParentAccountChildDetailsViewController?
    var bearPopUpVC: STBearPopUpViewController?
    var httpReq: BOABHttpReq?

    @IBOutlet var dashboardContainerView: UIView!
    @IBOutlet var headerlabel: UILabel!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        performSelector(#selector(self.requestUserDetails), withObject: nil, afterDelay: 0.1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        headerlabel.font = UIFont()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
// MARK: ----- Request User Details

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
                if deviceTokenStr != nil {
                    paramDict["uid"] = deviceTokenStr
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
// MARK: ----- ParentDashboardDelegates

    func parentDashboardChildDetailsSelected(withDictionary dict: [AnyHashable: Any]) {
        if childDetailsVC != nil {
            childDetailsVC = nil
        }
        childDetailsVC = STParentAccountChildDetailsViewController(nibName: "STParentAccountChildDetailsViewController", bundle: Bundle.main, withChildDetailsDictionary: dict)
        navigationController?.pushViewController(childDetailsVC, animated: true)
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
                print("usertype \(STUserIdentity.sharedInstance().userIdentity())")
                if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
                    var childsArray = [Any]()
                    if responseDictionary[kParamKeyChild] {
                        if (responseDictionary[kParamKeyChild] is [Any]) {
                            childsArray = [Any](arrayLiteral: responseDictionary[kParamKeyChild])
                        }
                    }
                    if childsArray != nil {

                    }
                    if parentdashboardVC != nil {
                        parentdashboardVC?.view?.removeFromSuperview()
                        parentdashboardVC?.delegate = nil
                        parentdashboardVC = nil
                    }
                    parentdashboardVC = STParentDashboardViewController(nibName: "STParentDashboardViewController", bundle: Bundle.main, withDashboardChildArray: childsArray)
                    parentdashboardVC?.delegate = self
                    parentdashboardVC?.view?.frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(dashboardContainerView.frame.size.width), height: CGFloat(dashboardContainerView.frame.size.height))
                    dashboardContainerView.addSubview(parentdashboardVC?.view, withAnimation: true)
                    if parentdashboardVC != nil {
                        parentdashboardVC?.requestParentGraphData()
                    }
                    if STUserIdentity.sharedInstance().shouldShowTutorials() {
                        if childsArray.count > 0 {

                        }
                        else {
                            if bearPopUpVC == nil {
                                bearPopUpVC = STBearPopUpViewController(nibName: "STBearPopUpViewController", bundle: Bundle.main)
                                bearPopUpVC?.bearPopUpKind = ADDCHILDBEARPOPUP
                                bearPopUpVC?.delegate = self
                                bearPopUpVC?.view?.frame = view.frame
                                bearPopUpVC?.view?.addPopUpOnKeyWindow()
                            }
                        }
                    }
                }
                else if STUserIdentity.sharedInstance().userIdentity() == CHILDUSER {
                    var parentsArray = [Any]()
                    if responseDictionary[kParamKeyParent] {
                        if (responseDictionary[kParamKeyParent] is [Any]) {
                            parentsArray = responseDictionary[kParamKeyParent]
                        }
                    }
                    if parentsArray != nil {

                    }
                    if childDashboardVC != nil {
                        childDashboardVC?.view?.removeFromSuperview()
                        childDashboardVC = nil
                    }
                    childDashboardVC = STChildDashboardViewController(nibName: "STChildDashboardViewController", bundle: Bundle.main, withDashboardParentArray: parentsArray)
                    childDashboardVC?.view?.frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(dashboardContainerView.frame.size.width), height: CGFloat(dashboardContainerView.frame.size.height))
                    dashboardContainerView.addSubview(childDashboardVC?.view, withAnimation: true)
                    if childDashboardVC != nil {
                        childDashboardVC?.requestChildGraphDetails()
                    }
                    if STUserIdentity.sharedInstance().shouldShowTutorials() {
                        if bearPopUpVC == nil {
                            bearPopUpVC = STBearPopUpViewController(nibName: "STBearPopUpViewController", bundle: Bundle.main)
                            bearPopUpVC?.bearPopUpKind = ADDPARENTBEARPOPUP
                            bearPopUpVC?.delegate = self
                            bearPopUpVC?.view?.frame = view.frame
                            bearPopUpVC?.view?.addPopUpOnKeyWindow()
                        }
                    }
                    if STUserIdentity.sharedInstance().shouldShowBadgeAlert() {
                        UIAlertView.show(withTitle: "", message: "Congratulations! You just earned your first badge!", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                            if buttonIndex == alertView.cancelButtonIndex {

                            }
                        })
                    }
                }
            }
        }
    }
// MARK: ----- BearPopUp Delegate

    func bearPopUpButtonPressed(withPopUpKind bearPopUpKind: BearPopUpType) {
        if bearPopUpVC != nil {
            if bearPopUpKind == ADDPARENTBEARPOPUP {
                if bearPopUpVC != nil {
                    bearPopUpVC?.view?.removePopUpOnKeyWindow()
                    bearPopUpVC?.delegate = nil
                    bearPopUpVC = nil
                }
                var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                var addParentVC: STAddParentViewController? = storyboard.instantiateViewController(withIdentifier: "STAddParentViewController")
                addParentVC?.delegate = self
                navigationController?.pushViewController(addParentVC, animated: true)
            }
            else if bearPopUpKind == THANKSFORADDINGPARENTBEARPOPUP {
                if bearPopUpVC != nil {
                    bearPopUpVC?.view?.removePopUpOnKeyWindow()
                    bearPopUpVC?.delegate = nil
                    bearPopUpVC = nil
                }
                bearPopUpVC = STBearPopUpViewController(nibName: "STBearPopUpViewController", bundle: Bundle.main)
                bearPopUpVC?.bearPopUpKind = ADDCHILDBEARPOPUP
                bearPopUpVC?.delegate = self
                bearPopUpVC?.view?.frame = view.frame
                bearPopUpVC?.view?.addPopUpOnKeyWindow()
            }
            else if bearPopUpKind == ADDCHILDBEARPOPUP {
                if bearPopUpVC != nil {
                    bearPopUpVC?.view?.removePopUpOnKeyWindow()
                    bearPopUpVC?.delegate = nil
                    bearPopUpVC = nil
                }
                tabBarController?.selectedIndex = 4
            }
            else if bearPopUpKind == BANKACCOUNTLATERBEARPOPUP {
                if bearPopUpVC != nil {
                    bearPopUpVC?.view?.removePopUpOnKeyWindow()
                    bearPopUpVC?.delegate = nil
                    bearPopUpVC = nil
                }
            }
            else if bearPopUpKind == BANKACCOUNTDONEBEARPOPUP {
                if bearPopUpVC != nil {
                    bearPopUpVC?.view?.removePopUpOnKeyWindow()
                    bearPopUpVC?.delegate = nil
                    bearPopUpVC = nil
                }
            }
            else if bearPopUpKind == THANKSFORADDINGACHILDNOBANKBEARPOPUP {
                if bearPopUpVC != nil {
                    bearPopUpVC?.view?.removePopUpOnKeyWindow()
                    bearPopUpVC?.delegate = nil
                    bearPopUpVC = nil
                }
            }
        }
    }
// MARK: ----- AddParentDelegates

    func parentAdded(withUserDetailsDictionary infoDict: [AnyHashable: Any]) {
        if bearPopUpVC != nil {
            bearPopUpVC?.view?.removePopUpOnKeyWindow()
            bearPopUpVC?.delegate = nil
            bearPopUpVC = nil
        }
        bearPopUpVC = STBearPopUpViewController(nibName: "STBearPopUpViewController", bundle: Bundle.main)
        bearPopUpVC?.bearPopUpKind = THANKSFORADDINGPARENTBEARPOPUP
        bearPopUpVC?.delegate = self
        bearPopUpVC?.view?.frame = view.frame
        bearPopUpVC?.view?.addPopUpOnKeyWindow()
    }

    func bearPopUpLaterButtonPressed() {
        if bearPopUpVC != nil {
            bearPopUpVC?.view?.removePopUpOnKeyWindow()
            bearPopUpVC?.delegate = nil
            bearPopUpVC = nil
        }
        bearPopUpVC = STBearPopUpViewController(nibName: "STBearPopUpViewController", bundle: Bundle.main)
        bearPopUpVC?.bearPopUpKind = BANKACCOUNTLATERBEARPOPUP
        bearPopUpVC?.delegate = self
        bearPopUpVC?.view?.frame = view.frame
        bearPopUpVC?.view?.addPopUpOnKeyWindow()
    }

    func bearPopUpSetUpButtonPressed() {
        if bearPopUpVC != nil {
            bearPopUpVC?.view?.removePopUpOnKeyWindow()
            bearPopUpVC?.delegate = nil
            bearPopUpVC = nil
        }
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var parentPaymentFlowVC: STParentPaymentFlowViewController? = storyboard.instantiateViewController(withIdentifier: "STParentPaymentFlowViewController")
        parentPaymentFlowVC?.delegate = self
        parentPaymentFlowVC?.bankAccountTypeInt = 1
        navigationController?.pushViewController(parentPaymentFlowVC, animated: true)
    }
// MARK: ----- AddChildDelegates

    func childAdded(withUserDetailsDictionary infoDict: [AnyHashable: Any]) {
        if bearPopUpVC != nil {
            bearPopUpVC?.view?.removePopUpOnKeyWindow()
            bearPopUpVC?.delegate = nil
            bearPopUpVC = nil
        }
        if (STUserIdentity.sharedInstance().userKnoxFirstTransactionID() is NSNull) || (STUserIdentity.sharedInstance().userKnoxFirstTransactionID() == "") {
            bearPopUpVC = STBearPopUpViewController(nibName: "STBearPopUpViewController", bundle: Bundle.main)
            bearPopUpVC?.bearPopUpKind = THANKSFORADDINGACHILDBEARPOPUP
            bearPopUpVC?.delegate = self
            bearPopUpVC?.view?.frame = view.frame
            bearPopUpVC?.view?.addPopUpOnKeyWindow()
        }
        else {
            bearPopUpVC = STBearPopUpViewController(nibName: "STBearPopUpViewController", bundle: Bundle.main)
            bearPopUpVC?.bearPopUpKind = THANKSFORADDINGACHILDNOBANKBEARPOPUP
            bearPopUpVC?.delegate = self
            bearPopUpVC?.view?.frame = view.frame
            bearPopUpVC?.view?.addPopUpOnKeyWindow()
        }
    }
// MARK: ----- ParentPaymentFlowDelegates

    func addAccountSuccessFull(withDict dict: [AnyHashable: Any], andBankAccountUserType bankAccType: Int) {
        if bearPopUpVC != nil {
            bearPopUpVC?.view?.removePopUpOnKeyWindow()
            bearPopUpVC?.delegate = nil
            bearPopUpVC = nil
        }
        bearPopUpVC = STBearPopUpViewController(nibName: "STBearPopUpViewController", bundle: Bundle.main)
        bearPopUpVC?.bearPopUpKind = BANKACCOUNTDONEBEARPOPUP
        bearPopUpVC?.delegate = self
        bearPopUpVC?.view?.frame = view.frame
        bearPopUpVC?.view?.addPopUpOnKeyWindow()
    }
}