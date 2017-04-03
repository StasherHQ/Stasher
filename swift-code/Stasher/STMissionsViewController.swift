//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STMissionsViewController.swift
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STMissionsViewController: UIViewController, ParentMissionListDelegate, ParentAddMissionDelegate, ChildMissionListDelegate {
    var httpReq: BOABHttpReq?
    var addMissionParentVC: STParentAddMissionViewController?
    var parentMissionListVC: STParentMissionsListViewController?
    var childMissionListVC: STChildMissionListViewController?
    var childMissionListVC1: STChildMissionListViewController?
    var childMissionListVC2: STChildMissionListViewController?
    var childMissionListVC3: STChildMissionListViewController?
    var searchMissionVC: STSearchMissionViewController?
    var parentMissionListVC1: STParentMissionsListViewController?
    var parentMissionListVC2: STParentMissionsListViewController?
    var parentMissionListVC3: STParentMissionsListViewController?

    @IBOutlet var containerView: UIView!
    @IBOutlet var addMissionButton: UIButton!
    @IBOutlet var addMissionSmallBtn: UIButton!
    @IBOutlet var scrollViewMissions: UIScrollView!
    @IBOutlet var pageControlMissions: UIPageControl!
    var missionTypeString: String = ""
    @IBOutlet var headingMissions: UILabel!
    @IBOutlet var remindViewPopUpView: UIView!
    @IBOutlet var popUpBagImgView: UIImageView!
    @IBOutlet var btnRemindClosePopUp: UIButton!
    @IBOutlet var btnSkipRemind: UIButton!
    @IBOutlet var btnSendRemind: UIButton!
    @IBOutlet var notesTextView: UITextView!
    var remindDict = [AnyHashable: Any]()
    @IBOutlet var imgViewNoMission: UIImageView!
    @IBOutlet var labelNoMissionTitle: UILabel!
    @IBOutlet var labelNoMission: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
            addMissionButton.isHidden = false
            addMissionSmallBtn.isHidden = false
        }
        else {
            addMissionButton.isHidden = true
            addMissionSmallBtn.isHidden = true
        }
        setUpMissionNamesScrollView()
        remindViewPopUpView.clipsToBounds = true
        remindViewPopUpView.layer.cornerRadius = 10.0
        remindViewPopUpView.layer.borderColor = UIColor.lightGray.cgColor
        remindViewPopUpView.layer.borderWidth = 2.0
        remindViewPopUpView.backgroundColor = UIColor.stasherPopUpBG()
        btnSendRemind.titleLabel?.font = UIFont(size: 13.0)
        btnSkipRemind.titleLabel?.font = UIFont(size: 13.0)
        notesTextView.font = UIFont()
        labelNoMissionTitle.font = UIFont.fontGothamRoundedBook(withSize: 19.88)
        labelNoMission.font = UIFont.fontGothamRoundedBook(withSize: 8.83)
        labelNoMissionTitle.sizeToFit()
        labelNoMission.sizeToFit()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        imgViewNoMission.isHidden = true
        labelNoMission.isHidden = true
        labelNoMissionTitle.isHidden = true
        setHeaderLabelText()
        for view: UIView in scrollViewMissions.subviews {
            view.removeFromSuperview()
        }
        if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
            if (missionTypeString == kMissionBarActiveMission) {
                if parentMissionListVC1 == nil {
                    addMissionsListView(withMissionType: missionTypeString)
                }
                else {
                    parentMissionListVC1?.view?.removeFromSuperview()
                    parentMissionListVC1 = nil
                    addMissionsListView(withMissionType: missionTypeString)
                }
            }
            else if (missionTypeString == kMissionBarPendingMission) {
                if parentMissionListVC2 == nil {
                    addMissionsListView(withMissionType: missionTypeString)
                }
                else {
                    parentMissionListVC2?.view?.removeFromSuperview()
                    parentMissionListVC2 = nil
                    addMissionsListView(withMissionType: missionTypeString)
                }
            }
            else if (missionTypeString == kMissionBarCompletedMission) {
                if parentMissionListVC3 == nil {
                    addMissionsListView(withMissionType: missionTypeString)
                }
                else {
                    parentMissionListVC3?.view?.removeFromSuperview()
                    parentMissionListVC3 = nil
                    addMissionsListView(withMissionType: missionTypeString)
                }
            }
            else {
                if parentMissionListVC1 == nil {
                    addMissionsListView(withMissionType: missionTypeString)
                }
                else {
                    parentMissionListVC1?.view?.removeFromSuperview()
                    parentMissionListVC1 = nil
                    addMissionsListView(withMissionType: missionTypeString)
                }
            }
        }
        else {
            if (missionTypeString == kMissionBarActiveMission) {
                if childMissionListVC1 == nil {
                    addMissionsListView(withMissionType: missionTypeString)
                }
                else {
                    childMissionListVC1?.view?.removeFromSuperview()
                    childMissionListVC1 = nil
                    addMissionsListView(withMissionType: missionTypeString)
                }
            }
            else if (missionTypeString == kMissionBarPendingMission) {
                if childMissionListVC2 == nil {
                    addMissionsListView(withMissionType: missionTypeString)
                }
                else {
                    childMissionListVC2?.view?.removeFromSuperview()
                    childMissionListVC2 = nil
                    addMissionsListView(withMissionType: missionTypeString)
                }
            }
            else if (missionTypeString == kMissionBarCompletedMission) {
                if childMissionListVC3 == nil {
                    addMissionsListView(withMissionType: missionTypeString)
                }
                else {
                    childMissionListVC3?.view?.removeFromSuperview()
                    childMissionListVC3 = nil
                    addMissionsListView(withMissionType: missionTypeString)
                }
            }
            else {
                if childMissionListVC1 == nil {
                    addMissionsListView(withMissionType: missionTypeString)
                }
                else {
                    childMissionListVC1?.view?.removeFromSuperview()
                    childMissionListVC1 = nil
                    addMissionsListView(withMissionType: missionTypeString)
                }
            }
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
// MARK: -----------------Common---------------------
// MARK: ----- Custom Methods

    func setUpMissionNamesScrollView() {
        var namesArray: [Any] = ["Active Missions", "Pending Missions", "Completed Missions"]
        var missionNameButtonFrame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(UIScreen.main.bounds.size.width), height: CGFloat(containerView?.frame?.size?.height))
        for c in 0..<3 {
            var missionNameButton = UIButton(type: .custom)
            switch c {
                case 0:
                    break
                case 1:
                    missionNameButton.setTitle("\(namesArray[c]) (\(STUserIdentity.sharedInstance().pendingMissionsCount()))", for: .normal)
                case 2:
                    missionNameButton.setTitle("\(namesArray[c]) (\(STUserIdentity.sharedInstance().completedMissionsCount()))", for: .normal)
                default:
                    break
            }

            missionNameButton.titleLabel?.textColor = UIColor.stasherText()
            missionNameButton.titleLabel?.font = UIFont.boldSystemFontOfSize(CGFloat(13.0))
            missionNameButton.frame = missionNameButtonFrame
            missionNameButton.addTarget(self, action: #selector(self.missionNameButtonPressed), for: .touchUpInside)
            scrollViewMissions.addSubview(missionNameButton)
            missionNameButtonFrame?.origin?.x += missionNameButtonFrame?.size?.width
        }
        var contentSize: CGSize = scrollViewMissions.frame.size
        contentSize.width = missionNameButtonFrame?.origin?.x
        contentSize.height = 0.0
        scrollViewMissions.contentSize = contentSize
        pageControlMissions.numberOfPages = 3
    }

    func missionNameButtonPressed(_ sender: Any) {
    }

    func addMissionsListView(withMissionType typeString: String) {
        if typeString == nil {
            missionTypeString = kMissionBarActiveMission
            scrollViewMissions.setContentOffset(CGPoint.zero, animated: true)
            pageControlMissions.currentPage = 0
        }
        var currentIndex = Int(pageControlMissions.currentPage)
        if currentIndex == 0 {
            pageControlMissions.currentPage = 0
            missionTypeString = kMissionBarActiveMission
        }
        else if currentIndex == 1 {
            pageControlMissions.currentPage = 1
            missionTypeString = kMissionBarPendingMission
        }
        else {
            pageControlMissions.currentPage = 2
            missionTypeString = kMissionBarCompletedMission
        }

        requestMissionListOfType(missionTypeString)
    }

    func requestMissionListOfType(_ thisMissionTypeString: String) {
        var typeString: String
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        var userIdString: String
        if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
            userIdString = kParamKeyParentID
            if (thisMissionTypeString == kMissionBarActiveMission) {
                typeString = kAPIActionParentActiveMissions
            }
            else if (thisMissionTypeString == kMissionBarCompletedMission) {
                typeString = kAPIActionParentCompletedMissions
            }
            else {
                typeString = kAPIActionParentPendingMissions
            }
        }
        else if STUserIdentity.sharedInstance().userIdentity() == CHILDUSER {
            userIdString = kParamKeyChildID
            if (thisMissionTypeString == kMissionBarActiveMission) {
                typeString = kAPIActionChildActiveMissions
            }
            else if (thisMissionTypeString == kMissionBarCompletedMission) {
                typeString = kAPIActionChildCompletedMissions
            }
            else {
                typeString = kAPIActionChildPendingMissions
            }
        }

        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
            userIdString : Int(CInt(STUserIdentity.sharedInstance().userId())),
            kParamKeyAction : typeString
        ]
, json: true)
    }

    func setHeaderLabelText() {
        if (missionTypeString == kMissionBarActiveMission) {
            var font1 = UIFont()
            var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
            var aAttrString1 = NSMutableAttributedString(string: "Active ", attributes: arialDict)
            var font2 = UIFont()
            var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
            var aAttrString2 = NSMutableAttributedString(string: "\("Missions") (\(STUserIdentity.sharedInstance().activeMissionsCount()))", attributes: arialDict2)
            aAttrString1.append(aAttrString2)
            headingMissions.attributedText = aAttrString1
        }
        else if (missionTypeString == kMissionBarPendingMission) {
            var font1 = UIFont()
            var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
            var aAttrString1 = NSMutableAttributedString(string: "Pending ", attributes: arialDict)
            var font2 = UIFont()
            var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
            var aAttrString2 = NSMutableAttributedString(string: "\("Missions") (\(STUserIdentity.sharedInstance().pendingMissionsCount()))", attributes: arialDict2)
            aAttrString1.append(aAttrString2)
            headingMissions.attributedText = aAttrString1
        }
        else if (missionTypeString == kMissionBarCompletedMission) {
            var font1 = UIFont()
            var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
            var aAttrString1 = NSMutableAttributedString(string: "Completed ", attributes: arialDict)
            var font2 = UIFont()
            var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
            var aAttrString2 = NSMutableAttributedString(string: "\("Missions") (\(STUserIdentity.sharedInstance().completedMissionsCount()))", attributes: arialDict2)
            aAttrString1.append(aAttrString2)
            headingMissions.attributedText = aAttrString1
        }
        else {
            var font1 = UIFont()
            var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
            var aAttrString1 = NSMutableAttributedString(string: "Active ", attributes: arialDict)
            var font2 = UIFont()
            var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
            var aAttrString2 = NSMutableAttributedString(string: "\("Missions") (\(STUserIdentity.sharedInstance().activeMissionsCount()))", attributes: arialDict2)
            aAttrString1.append(aAttrString2)
            headingMissions.attributedText = aAttrString1
        }

    }

    func setHeaderLabelTextWithCount(_ missionCount: Int) {
        if (missionTypeString == kMissionBarActiveMission) {
            var font1 = UIFont()
            var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
            var aAttrString1 = NSMutableAttributedString(string: "Active ", attributes: arialDict)
            var font2 = UIFont()
            var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
            var aAttrString2 = NSMutableAttributedString(string: "\("Missions") (\(missionCount))", attributes: arialDict2)
            aAttrString1.append(aAttrString2)
            headingMissions.attributedText = aAttrString1
        }
        else if (missionTypeString == kMissionBarPendingMission) {
            var font1 = UIFont()
            var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
            var aAttrString1 = NSMutableAttributedString(string: "Pending ", attributes: arialDict)
            var font2 = UIFont()
            var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
            var aAttrString2 = NSMutableAttributedString(string: "\("Missions") (\(missionCount))", attributes: arialDict2)
            aAttrString1.append(aAttrString2)
            headingMissions.attributedText = aAttrString1
        }
        else if (missionTypeString == kMissionBarCompletedMission) {
            var font1 = UIFont()
            var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
            var aAttrString1 = NSMutableAttributedString(string: "Completed ", attributes: arialDict)
            var font2 = UIFont()
            var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
            var aAttrString2 = NSMutableAttributedString(string: "\("Missions") (\(missionCount))", attributes: arialDict2)
            aAttrString1.append(aAttrString2)
            headingMissions.attributedText = aAttrString1
        }
        else {
            var font1 = UIFont()
            var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
            var aAttrString1 = NSMutableAttributedString(string: "Active ", attributes: arialDict)
            var font2 = UIFont()
            var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
            var aAttrString2 = NSMutableAttributedString(string: "\("Missions") (\(STUserIdentity.sharedInstance().activeMissionsCount()))", attributes: arialDict2)
            aAttrString1.append(aAttrString2)
            headingMissions.attributedText = aAttrString1
        }

    }
// MARK: ----- Actions

    @IBAction func searchMissionButtonPressed(_ sender: Any) {
        if searchMissionVC != nil {
            searchMissionVC = nil
        }
        searchMissionVC = STSearchMissionViewController(nibName: "STSearchMissionViewController", bundle: Bundle.main)
        navigationController?.pushViewController(searchMissionVC, animated: true)
    }
// MARK: ----- Scrollview Delegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        imgViewNoMission.isHidden = true
        labelNoMission.isHidden = true
        labelNoMissionTitle.isHidden = true
        var currentIndex = Int(scrollViewMissions.contentOffset.x / scrollViewMissions.frame.size.width)
        pageControlMissions.currentPage = currentIndex
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var currentIndex = Int(pageControlMissions.currentPage)
        if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
            if currentIndex == 0 {
                missionTypeString = kMissionBarActiveMission
                if parentMissionListVC1 != nil {
                    parentMissionListVC1?.view?.removeFromSuperview()
                    parentMissionListVC1 = nil
                }
                addMissionsListView(withMissionType: missionTypeString)
            }
            else if currentIndex == 1 {
                missionTypeString = kMissionBarPendingMission
                if parentMissionListVC2 != nil {
                    parentMissionListVC2?.view?.removeFromSuperview()
                    parentMissionListVC2 = nil
                }
                addMissionsListView(withMissionType: missionTypeString)
            }
            else {
                missionTypeString = kMissionBarCompletedMission
                if parentMissionListVC3 != nil {
                    parentMissionListVC3?.view?.removeFromSuperview()
                    parentMissionListVC3 = nil
                }
                addMissionsListView(withMissionType: missionTypeString)
            }
        }
        else {
            if currentIndex == 0 {
                missionTypeString = kMissionBarActiveMission
                if childMissionListVC1 != nil {
                    childMissionListVC1?.view?.removeFromSuperview()
                    childMissionListVC1 = nil
                }
                addMissionsListView(withMissionType: missionTypeString)
            }
            else if currentIndex == 1 {
                missionTypeString = kMissionBarPendingMission
                if childMissionListVC2 != nil {
                    childMissionListVC2?.view?.removeFromSuperview()
                    childMissionListVC2 = nil
                }
                addMissionsListView(withMissionType: missionTypeString)
            }
            else {
                missionTypeString = kMissionBarCompletedMission
                if childMissionListVC3 != nil {
                    childMissionListVC3?.view?.removeFromSuperview()
                    childMissionListVC3 = nil
                }
                addMissionsListView(withMissionType: missionTypeString)
            }
        }
        setHeaderLabelText()
    }
// MARK: ------------------ PARENT -------------------

    @IBAction func addMissionButtonPressed(_ sender: Any) {
        if addMissionParentVC != nil {
            addMissionParentVC = nil
        }
        addMissionParentVC = STParentAddMissionViewController(nibName: "STParentAddMissionViewController", bundle: Bundle.main)
        addMissionParentVC?.isEditMode = false
        addMissionParentVC?.isMissionDetailMode = false
        addMissionParentVC?.delegate = self
        navigationController?.pushViewController(addMissionParentVC, animated: true)
    }

    func parentCellEditMissionButtonPressed(withMissionDict dict: [AnyHashable: Any]) {
        if addMissionParentVC != nil {
            addMissionParentVC = nil
        }
        addMissionParentVC = STParentAddMissionViewController(nibName: "STParentAddMissionViewController", bundle: Bundle.main)
        addMissionParentVC?.isEditMode = true
        addMissionParentVC?.isMissionDetailMode = false
        addMissionParentVC?.delegate = self
        addMissionParentVC?.editMissionRefreshView(withDictionary: dict)
        navigationController?.pushViewController(addMissionParentVC, animated: true)
    }

    func parentCellCompleteMissionButtonPressed(withMissionDict dict: [AnyHashable: Any]) {
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        var userIdString: String
        var apiActionString: String
        if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
            userIdString = kParamKeyParentID
            apiActionString = kAPIActionParentCompleteMission
        }
        else if STUserIdentity.sharedInstance().userIdentity() == CHILDUSER {
            userIdString = kParamKeyChildID
            apiActionString = kAPIActionChildCompleteMission
        }

        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
            userIdString : Int(CInt(STUserIdentity.sharedInstance().userId())),
            kParamKeyAction : apiActionString,
            kParamKeyMissionId : dict[kParamKeyMissionId]
        ]
, json: true)
    }

    func parentCellRemindMissionButtonPressed(withMissionDict dict: [AnyHashable: Any]) {
        btnRemindClosePopUp.setHidden(animated: false)
        popUpBagImgView.setHidden(animated: false)
        remindViewPopUpView.setHidden(animated: false)
        notesTextView.becomeFirstResponder()
        if !remindDict.isEmpty {
            remindDict = nil
        }
        remindDict = dict
    }

    func parentMissionListCellDidSelect(withDict dict: [AnyHashable: Any]) {
        /*
            STMissionDetailsViewController *missionDetailsVC = [[STMissionDetailsViewController alloc] initWithNibName:@"STMissionDetailsViewController" bundle:[NSBundle mainBundle] detailsDict:dict];
            [self.navigationController pushViewController:missionDetailsVC animated:YES];
             */
        if addMissionParentVC != nil {
            addMissionParentVC = nil
        }
        addMissionParentVC = STParentAddMissionViewController(nibName: "STParentAddMissionViewController", bundle: Bundle.main)
        addMissionParentVC?.isEditMode = false
        addMissionParentVC?.isMissionDetailMode = true
        addMissionParentVC?.delegate = self
        addMissionParentVC?.editMissionRefreshView(withDictionary: dict)
        navigationController?.pushViewController(addMissionParentVC, animated: true)
    }

    @IBAction func remindPopUpSkipButtonPressed(_ sender: Any) {
        btnRemindClosePopUp.setHidden(animated: true)
        popUpBagImgView.setHidden(animated: true)
        remindViewPopUpView.setHidden(animated: true)
        notesTextView.resignFirstResponder()
    }

    @IBAction func remindPopUpSendButtonPressed(_ sender: Any) {
        notesTextView.resignFirstResponder()
        btnRemindClosePopUp.setHidden(animated: true)
        popUpBagImgView.setHidden(animated: true)
        remindViewPopUpView.setHidden(animated: true)
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
            kParamKeyParentID : Int(CInt(STUserIdentity.sharedInstance().userId())),
            kParamKeyMissionId : remindDict[kParamKeyMissionId],
            kParamKeyChildID : remindDict[kParamKeyChild][kParamKeyUserID],
            kParamKeyAction : kAPIActionRemindMission,
            "message" : notesTextView.text
        ]
, json: true)
    }

    func missionUpdatedAdded() {
        addMissionsListView(withMissionType: nil)
    }
// MARK: ------------------ CHILD --------------------

    func childMissionListCellDidSelect(withDict dict: [AnyHashable: Any]) {
        /*
            STMissionDetailsViewController *missionDetailsVC = [[STMissionDetailsViewController alloc] initWithNibName:@"STMissionDetailsViewController" bundle:[NSBundle mainBundle] detailsDict:dict];
            [self.navigationController pushViewController:missionDetailsVC animated:YES];
             */
        if addMissionParentVC != nil {
            addMissionParentVC = nil
        }
        addMissionParentVC = STParentAddMissionViewController(nibName: "STParentAddMissionViewController", bundle: Bundle.main)
        addMissionParentVC?.isEditMode = false
        addMissionParentVC?.isMissionDetailMode = true
        addMissionParentVC?.delegate = self
        addMissionParentVC?.editMissionRefreshView(withDictionary: dict)
        navigationController?.pushViewController(addMissionParentVC, animated: true)
    }

    func childCellCompleteMissionButtonPressed(withMissionDict dict: [AnyHashable: Any]) {
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        var userIdString: String
        var apiActionString: String
        userIdString = kParamKeyChildID
        apiActionString = kAPIActionChildCompleteMission
        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
            userIdString : Int(CInt(STUserIdentity.sharedInstance().userId())),
            kParamKeyAction : apiActionString,
            kParamKeyMissionId : dict[kParamKeyMissionId]
        ]
, json: true)
    }

    func childCellAcceptMissionButtonPressed(withMissionDict dict: [AnyHashable: Any]) {
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        var userIdString: String
        var apiActionString: String
        userIdString = kParamKeyChildID
        apiActionString = kAPIActionChildAcceptMission
        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
            userIdString : Int(CInt(STUserIdentity.sharedInstance().userId())),
            kParamKeyAction : apiActionString,
            kParamKeyMissionId : dict[kParamKeyMissionId]
        ]
, json: true)
    }

    func childCellCancelMissionButtonPressed(withMissionDict dict: [AnyHashable: Any]) {
        print("Canceled with dict \(dict)")
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
            kParamKeyChildID : Int(CInt(STUserIdentity.sharedInstance().userId())),
            kParamKeyAction : kAPIActionDeleteMission,
            kParamKeyMissionId : dict[kParamKeyMissionId],
            kParamKeyParentID : dict[kParamKeyParent][kParamKeyUserID]
        ]
, json: true)
    }
// MARK: ------ TextView Delegate

    func textView(_ textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        var shouldChange: Bool = true
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        if textView == notesTextView {
            var notesDescription: String = textView.text + (text)
            if (notesDescription.characters.count ?? 0) > 250 {
                shouldChange = false
            }
        }
        return shouldChange
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == notesTextView {
            if (notesTextView.text == "Add Note") {
                textView.text = ""
            }
        }
        textView.textColor = UIColor.stasherText()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == notesTextView {
            if !textView.text.validateNotEmpty() {
                textView.textColor = UIColor.stasherTextFieldPlaceHolder()
                textView.text = "Add Note"
            }
        }
    }
// MARK: ----- BOABRequestDelegate Delegate

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDict: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDict != nil {
                if (conn.userInfo?["params"]["action"] == kAPIActionParentCompletedMissions) || (conn.userInfo?["params"]["action"] == kAPIActionParentActiveMissions) || (conn.userInfo?["params"]["action"] == kAPIActionParentPendingMissions) || (conn.userInfo?["params"]["action"] == kAPIActionChildActiveMissions) || (conn.userInfo?["params"]["action"] == kAPIActionChildPendingMissions) || (conn.userInfo?["params"]["action"] == kAPIActionChildCompletedMissions) {
                    if (responseDict? is [Any]) {
                        if !(responseDict? is NSNull) {
                            setHeaderLabelTextWithCount(Int(responseDict?.count))
                        }
                        if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
                            var missionNameButtonFrame: CGRect
                            if (missionTypeString == kMissionBarActiveMission) {
                                missionNameButtonFrame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(containerView?.frame?.size?.height))
                                parentMissionListVC1 = STParentMissionsListViewController(nibName: "STParentMissionsListViewController", bundle: Bundle.main, missionListType: missionTypeString, andMissionListArray: responseDict?)
                                var rect: CGRect? = parentMissionListVC1?.view?.frame
                                rect?.size?.width = containerView?.frame?.size?.width
                                rect?.size?.height = containerView?.frame?.size?.height
                                parentMissionListVC1?.view?.frame = missionNameButtonFrame
                                scrollViewMissions.addSubview(parentMissionListVC1?.view, withAnimation: true)
                                parentMissionListVC1?.missionListTableView?.reloadData()
                                parentMissionListVC1?.delegate = self
                            }
                            else if (missionTypeString == kMissionBarPendingMission) {
                                if IS_STANDARD_IPHONE_6_PLUS {
                                    missionNameButtonFrame = CGRect(x: CGFloat(view.frame.size.width - 10), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(containerView?.frame?.size?.height))
                                }
                                else {
                                    missionNameButtonFrame = CGRect(x: CGFloat(view.frame.size.width), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(containerView?.frame?.size?.height))
                                }
                                parentMissionListVC2 = STParentMissionsListViewController(nibName: "STParentMissionsListViewController", bundle: Bundle.main, missionListType: missionTypeString, andMissionListArray: responseDict?)
                                var rect: CGRect? = parentMissionListVC2?.view?.frame
                                rect?.size?.width = containerView?.frame?.size?.width
                                rect?.size?.height = containerView?.frame?.size?.height
                                parentMissionListVC2?.view?.frame = missionNameButtonFrame
                                scrollViewMissions.addSubview(parentMissionListVC2?.view, withAnimation: true)
                                parentMissionListVC2?.missionListTableView?.reloadData()
                                parentMissionListVC2?.delegate = self
                            }
                            else {
                                if IS_STANDARD_IPHONE_6_PLUS {
                                    missionNameButtonFrame = CGRect(x: CGFloat(2 * view.frame.size.width - 18), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(containerView?.frame?.size?.height))
                                }
                                else {
                                    missionNameButtonFrame = CGRect(x: CGFloat(2 * view.frame.size.width), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(containerView?.frame?.size?.height))
                                }
                                parentMissionListVC3 = STParentMissionsListViewController(nibName: "STParentMissionsListViewController", bundle: Bundle.main, missionListType: missionTypeString, andMissionListArray: responseDict?)
                                var rect: CGRect? = parentMissionListVC3?.view?.frame
                                rect?.size?.width = containerView?.frame?.size?.width
                                rect?.size?.height = containerView?.frame?.size?.height
                                parentMissionListVC3?.view?.frame = missionNameButtonFrame
                                scrollViewMissions.addSubview(parentMissionListVC3?.view, withAnimation: true)
                                parentMissionListVC3?.missionListTableView?.reloadData()
                                parentMissionListVC3?.delegate = self
                            }
                        }
                        else if STUserIdentity.sharedInstance().userIdentity() == CHILDUSER {
                            var missionNameButtonFrame: CGRect
                            if (missionTypeString == kMissionBarActiveMission) {
                                missionNameButtonFrame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(containerView?.frame?.size?.height))
                                childMissionListVC1 = STChildMissionListViewController(nibName: "STChildMissionListViewController", bundle: Bundle.main, missionListType: missionTypeString, andMissionListArray: responseDict?)
                                var rect: CGRect? = childMissionListVC1?.view?.frame
                                rect?.size?.width = containerView?.frame?.size?.width
                                rect?.size?.height = containerView?.frame?.size?.height
                                childMissionListVC1?.view?.frame = missionNameButtonFrame
                                scrollViewMissions.addSubview(childMissionListVC1?.view, withAnimation: true)
                                childMissionListVC1?.tableViewChildMissionList?.reloadData()
                                childMissionListVC1?.delegate = self
                            }
                            else if (missionTypeString == kMissionBarPendingMission) {
                                if IS_STANDARD_IPHONE_6_PLUS {
                                    missionNameButtonFrame = CGRect(x: CGFloat(view.frame.size.width - 10), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(containerView?.frame?.size?.height))
                                }
                                else {
                                    missionNameButtonFrame = CGRect(x: CGFloat(view.frame.size.width), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(containerView?.frame?.size?.height))
                                }
                                childMissionListVC2 = STChildMissionListViewController(nibName: "STChildMissionListViewController", bundle: Bundle.main, missionListType: missionTypeString, andMissionListArray: responseDict?)
                                var rect: CGRect? = childMissionListVC2?.view?.frame
                                rect?.size?.width = containerView?.frame?.size?.width
                                rect?.size?.height = containerView?.frame?.size?.height
                                childMissionListVC2?.view?.frame = missionNameButtonFrame
                                scrollViewMissions.addSubview(childMissionListVC2?.view, withAnimation: true)
                                childMissionListVC2?.tableViewChildMissionList?.reloadData()
                                childMissionListVC2?.delegate = self
                            }
                            else {
                                if IS_STANDARD_IPHONE_6_PLUS {
                                    missionNameButtonFrame = CGRect(x: CGFloat(2 * view.frame.size.width - 18), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(containerView?.frame?.size?.height))
                                }
                                else {
                                    missionNameButtonFrame = CGRect(x: CGFloat(2 * view.frame.size.width), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(containerView?.frame?.size?.height))
                                }
                                childMissionListVC3 = STChildMissionListViewController(nibName: "STChildMissionListViewController", bundle: Bundle.main, missionListType: missionTypeString, andMissionListArray: responseDict?)
                                var rect: CGRect? = childMissionListVC3?.view?.frame
                                rect?.size?.width = containerView?.frame?.size?.width
                                rect?.size?.height = containerView?.frame?.size?.height
                                childMissionListVC3?.view?.frame = missionNameButtonFrame
                                scrollViewMissions.addSubview(childMissionListVC3?.view, withAnimation: true)
                                childMissionListVC3?.tableViewChildMissionList?.reloadData()
                                childMissionListVC3?.delegate = self
                            }
                        }
                    }
                    else {
                        if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
                            if (missionTypeString == kMissionBarActiveMission) {
                                labelNoMissionTitle.text = "No \(kMissionBarActiveMission)"
                                labelNoMission.text = "Active Missions are tasks or goals that your child has accepted.\n\nClick the + sign above to create a new mission.\n\nSwipe right to view Pending and Completed missions."
                            }
                            else if (missionTypeString == kMissionBarPendingMission) {
                                labelNoMissionTitle.text = "No \(kMissionBarPendingMission)"
                                labelNoMission.text = "Pending Missions are tasks or goals that are waiting to be accepted by your child.\n\nSwipe right to view Completed missions, left to view Active Missions."
                            }
                            else if (missionTypeString == kMissionBarCompletedMission) {
                                labelNoMissionTitle.text = "No \(kMissionBarCompletedMission)"
                                labelNoMission.text = "Completed Missions are tasks that your child has completed.\n\nSwipe left to view Active and Pending missions."
                            }
                        }
                        else if STUserIdentity.sharedInstance().userIdentity() == CHILDUSER {
                            if (missionTypeString == kMissionBarActiveMission) {
                                labelNoMissionTitle.text = "No \(kMissionBarActiveMission)"
                                labelNoMission.text = "Active Missions are tasks or goals that you’ve accepted.\n\nSwipe right to view Pending and Completed missions."
                            }
                            else if (missionTypeString == kMissionBarPendingMission) {
                                labelNoMissionTitle.text = "No \(kMissionBarPendingMission)"
                                labelNoMission.text = "Pending Missions are tasks or goals that are waiting for you to accept!\n\nSwipe right to view Completed missions, left to view Active Missions."
                            }
                            else if (missionTypeString == kMissionBarCompletedMission) {
                                labelNoMissionTitle.text = "No \(kMissionBarCompletedMission)"
                                labelNoMission.text = "Completed Missions are tasks that you’ve completed completed.\n\nSwipe left to view Active and Pending missions."
                            }
                        }

                        labelNoMission.sizeToFit()
                        imgViewNoMission.isHidden = false
                        labelNoMission.isHidden = false
                        labelNoMissionTitle.isHidden = false
                    }
                }
                else if (conn.userInfo?["params"]["action"] == kAPIActionParentCompleteMission) || (conn.userInfo?["params"]["action"] == kAPIActionChildAcceptMission) || (conn.userInfo?["params"]["action"] == kAPIActionChildCompleteMission) {
                    if responseDict?["success"] {
                        UIAlertView.show(withTitle: "", message: responseDict?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                            if !(conn.userInfo?["params"]["action"] == kAPIActionChildAcceptMission) {
                                self.addMissionsListView(withMissionType: nil)
                            }
                        })
                    }
                    else if responseDict?["error"] {
                        UIAlertView.show(withTitle: "", message: responseDict?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        })
                    }
                }
                else if (conn.userInfo?["params"]["action"] == kAPIActionRemindMission) {
                    if responseDict?["success"] {
                        UIAlertView.show(withTitle: "", message: responseDict?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        })
                    }
                    else if responseDict?["error"] {
                        UIAlertView.show(withTitle: "", message: responseDict?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        })
                    }
                }
                else if (conn.userInfo?["params"]["action"] == kAPIActionDeleteMission) {
                    if responseDict?["success"] {
                        UIAlertView.show(withTitle: "", message: responseDict?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                            self.scrollViewMissions.delegate?.scrollViewDidEndDecelerating(self.scrollViewMissions)
                        })
                    }
                    else if responseDict?["error"] {
                        UIAlertView.show(withTitle: "", message: responseDict?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        })
                    }
                }
            }
        }
    }

    func boabHttpReqFailedWithError(_ error: Error?) {
        if error != nil {

        }
    }
}