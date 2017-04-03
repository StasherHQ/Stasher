//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STChildDashboardViewController.swift
//  Stasher
//
//  Created by bhushan on 21/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STChildDashboardViewController: UIViewController, BOABHttpReqDelegate {

    @IBOutlet weak var workaholicConstraint: NSLayoutConstraint!
    @IBOutlet weak var hardLabourConstraint: NSLayoutConstraint!
    @IBOutlet weak var speedWorkerConstraint: NSLayoutConstraint!
    var httpReq: BOABHttpReq?
    var pointNow = CGPoint.zero
    var actualMyBadgesHeaderViewCenter = CGPoint.zero

    var parentsArray = [Any]()
    var myActivityArray = [Any]()
    @IBOutlet var graphContainerView: UIView!
    @IBOutlet var childNameLabel: UILabel!
    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet var myBadgesButton: UIButton!
    @IBOutlet var scrollChildContainerView: UIView!
    @IBOutlet var profilePicButton: UIButton!
    @IBOutlet var profilePicImgView: UIImageView!
    @IBOutlet var lblFirstName: UILabel!
    @IBOutlet var lblLastName: UILabel!
    @IBOutlet var lblActiveMissionsCount: UILabel!
    @IBOutlet var lblPendingMissionsCount: UILabel!
    @IBOutlet var lblCompletedMissionsCount: UILabel!
    @IBOutlet var lblActiveMissionsHeading: UILabel!
    @IBOutlet var lblPendingMissionsHeading: UILabel!
    @IBOutlet var lblCompletedMissionsHeading: UILabel!
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet var lblSaved: UILabel!
    @IBOutlet var lblInAWeek: UILabel!
    @IBOutlet var lblDollar: UILabel!
    @IBOutlet var lblSavingsAmount: UILabel!
    @IBOutlet var activityButton: UIButton!
    @IBOutlet var badgesContainerView: UIView!
    @IBOutlet var activityContainerView: UIView!
    @IBOutlet var badge1ImgView: UIImageView!
    @IBOutlet var badge2ImgView: UIImageView!
    @IBOutlet var badge3ImgView: UIImageView!
    @IBOutlet var badge4ImgView: UIImageView!
    @IBOutlet var badge5ImgView: UIImageView!
    @IBOutlet var myActivityTableView: UITableView!
    @IBOutlet var labelNoGraphData: UILabel!
    @IBOutlet var imgViewStickDivider: UIImageView!
    @IBOutlet weak var constraintHeightMyActivityTableViewContainerView: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightmyActivityTableView: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightControlsContView: NSLayoutConstraint!
    @IBOutlet var labelBadge1: UILabel!
    @IBOutlet var labelBadge2: UILabel!
    @IBOutlet var labelBadge3: UILabel!
    @IBOutlet var labelBadge4: UILabel!
    @IBOutlet var labelBadge5: UILabel!
    @IBOutlet var myBadgesHeaderView: UIView!

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, withDashboardParentArray thisParentArray: [Any]) {
        super.init(nibName: "STChildDashboardViewController", bundle: Bundle.main)
        
        parentsArray = [Any](arrayLiteral: thisParentArray)
    
    }

    func requestChildGraphDetails() {
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: false)
        if httpReq?.reachable {
            var paramDict = [AnyHashable: Any]()
            if STUserIdentity.sharedInstance().userId() != nil {
                paramDict[kParamKeyAction] = kAPIActionChildGraph
                paramDict[kParamKeyChildID] = STUserIdentity.sharedInstance().userId()
                httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
                paramDict = nil
            }
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        actualMyBadgesHeaderViewCenter = myBadgesHeaderView.center
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profilePicImgView.clipsToBounds = true
        profilePicImgView.layer.cornerRadius = profilePicButton.frame.size.width / 2.0
        profilePicImgView.layer.borderColor = UIColor.clear.cgColor
        profilePicImgView.layer.borderWidth = 0.5
        profilePicImgView.contentMode = .scaleAspectFill
        if !(STUserIdentity.sharedInstance().avatarUrlString() is NSNull) && !(STUserIdentity.sharedInstance().avatarUrlString() == "") {
            profilePicImgView.setImageWith(URL(string: STUserIdentity.sharedInstance().avatarUrlString()), placeholderImage: UIImage(named: "account_face_placeholder"))
        }
        else {
            profilePicImgView.image = UIImage(named: "account_face_placeholder")
        }
        //[self.graphContainerView addSubview:[self getGraphViewForChildren] withAnimation:YES];
        lblFirstName.textColor = UIColor.stasherText()
        lblLastName.textColor = UIColor.stasherText()
        var font1 = UIFont.fontGothamRoundedMedium(withSize: 14.0)
        var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
        var aAttrString1 = NSMutableAttributedString(string: "\(STUserIdentity.sharedInstance().firstName) ", attributes: arialDict)
        var font2 = UIFont.fontGothamRoundedBook(withSize: 14.0)
        var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
        var aAttrString2 = NSMutableAttributedString(string: "\(STUserIdentity.sharedInstance().lastName)", attributes: arialDict2)
        aAttrString1.append(aAttrString2)
        lblFirstName.attributedText = aAttrString1
        lblActiveMissionsHeading.font = UIFont.fontGothamRoundedMedium(withSize: 5.0)
        lblActiveMissionsHeading.textColor = UIColor(red: CGFloat(140.0 / 255), green: CGFloat(140.0 / 255), blue: CGFloat(140.0 / 255), alpha: CGFloat(1.0))
        lblPendingMissionsHeading.font = UIFont.fontGothamRoundedMedium(withSize: 5.0)
        lblPendingMissionsHeading.textColor = UIColor(red: CGFloat(140.0 / 255), green: CGFloat(140.0 / 255), blue: CGFloat(140.0 / 255), alpha: CGFloat(1.0))
        lblCompletedMissionsHeading.font = UIFont.fontGothamRoundedMedium(withSize: 5.0)
        lblCompletedMissionsHeading.textColor = UIColor(red: CGFloat(140.0 / 255), green: CGFloat(140.0 / 255), blue: CGFloat(140.0 / 255), alpha: CGFloat(1.0))
        lblTotal.font = UIFont.fontGothamRoundedBook(withSize: 12.0)
        lblSaved.font = UIFont.fontGothamRoundedMedium(withSize: 12.0)
        lblInAWeek.font = UIFont.fontGothamRoundedBook(withSize: 12.0)
        lblTotal.textColor = UIColor.stasherText()
        lblSaved.textColor = UIColor.stasherText()
        lblInAWeek.textColor = UIColor.stasherText()
        lblDollar.font = UIFont.fontGothamRoundedMedium(withSize: 13.5)
        lblSavingsAmount.font = UIFont.fontGothamRoundedBold(withSize: 21.21)
        myBadgesButton.titleLabel?.font = UIFont.fontGothamRoundedBold(withSize: 8.0)
        activityButton.titleLabel?.font = UIFont.fontGothamRoundedMedium(withSize: 8.0)
        activityButton.titleLabel?.textColor = UIColor(red: CGFloat(194.0 / 255), green: CGFloat(194.0 / 255), blue: CGFloat(194.0 / 255), alpha: CGFloat(1.0))
        lblActiveMissionsCount.font = UIFont.fontGothamRoundedBold(withSize: 17.21)
        lblPendingMissionsCount.font = UIFont.fontGothamRoundedBold(withSize: 17.21)
        lblCompletedMissionsCount.font = UIFont.fontGothamRoundedBold(withSize: 17.21)
        lblActiveMissionsCount.text = "\(STUserIdentity.sharedInstance().activeMissionsCount())"
        lblPendingMissionsCount.text = "\(STUserIdentity.sharedInstance().pendingMissionsCount())"
        lblCompletedMissionsCount.text = "\(STUserIdentity.sharedInstance().completedMissionsCount())"
        var font4 = UIFont.fontGothamRoundedMedium(withSize: 11.5)
        var arialDict4: [AnyHashable: Any] = [ NSFontAttributeName : font4 ]
        var aAttrString4 = NSMutableAttributedString(string: "\("$")", attributes: arialDict4)
        var font5 = UIFont.fontGothamRoundedBold(withSize: 21.21)
        var arialDict5: [AnyHashable: Any] = [ NSFontAttributeName : font5 ]
        var aAttrString5 = NSMutableAttributedString(string: "\(STUserIdentity.sharedInstance().savingsAmount())", attributes: arialDict5)
        aAttrString4.append(aAttrString5)
        lblSavingsAmount.attributedText = aAttrString4
        lblSavingsAmount.sizeToFit()
        lblFirstName.sizeToFit()
        lblLastName.sizeToFit()
        if IS_STANDARD_IPHONE_6 {
            workaholicConstraint.constant = 48.0
            hardLabourConstraint.constant = 48.0
            speedWorkerConstraint.constant = 48.0
        }
        else if IS_STANDARD_IPHONE_6_PLUS {
            workaholicConstraint.constant = 58.0
            hardLabourConstraint.constant = 58.0
            speedWorkerConstraint.constant = 58.0
        }
        else {
            workaholicConstraint.constant = 28.0
            hardLabourConstraint.constant = 28.0
            speedWorkerConstraint.constant = 28.0
        }

        labelBadge1.textColor = UIColor.stasherText()
        labelBadge2.textColor = UIColor.stasherText()
        labelBadge3.textColor = UIColor.stasherText()
        labelBadge4.textColor = UIColor.stasherText()
        labelBadge5.textColor = UIColor.stasherText()
        labelBadge1.font = UIFont.fontGothamRoundedBook(withSize: 9.0)
        labelBadge2.font = UIFont.fontGothamRoundedBook(withSize: 9.0)
        labelBadge3.font = UIFont.fontGothamRoundedBook(withSize: 9.0)
        labelBadge4.font = UIFont.fontGothamRoundedBook(withSize: 9.0)
        labelBadge5.font = UIFont.fontGothamRoundedBook(withSize: 9.0)
        if STUserIdentity.sharedInstance().childBadgeDetailsArray() != nil {
            for dict: [AnyHashable: Any] in STUserIdentity.sharedInstance().childBadgeDetailsArray() {
                if dict["title"] {
                    if (dict["title"] == kBadgeJuniorAgent) {
                        badge1ImgView.setHidden(animated: false)
                        badge1ImgView.alpha = 1.0
                    }
                    else {
                        badge1ImgView.alpha = 1.0
                    }
                    if (dict["title"] == kBadgeTrainingDay) {
                        badge2ImgView.setHidden(animated: false)
                        badge2ImgView.alpha = 1.0
                    }
                    else {
                        badge2ImgView.alpha = 0.3
                    }
                    if (dict["title"] == kBadgeFirstMission) {
                        badge3ImgView.setHidden(animated: false)
                        badge3ImgView.alpha = 1.0
                    }
                    else {
                        badge3ImgView.alpha = 0.3
                    }
                    if (dict["title"] == kBadgeBusyBee) {
                        badge4ImgView.setHidden(animated: false)
                        badge4ImgView.alpha = 1.0
                    }
                    else {
                        badge4ImgView.alpha = 0.3
                    }
                    if (dict["title"] == kBadgeMasterStasher) {
                        badge5ImgView.setHidden(animated: false)
                        badge5ImgView.alpha = 1.0
                    }
                    else {
                        badge5ImgView.alpha = 0.3
                    }
                }
            }
        }
        labelNoGraphData.sizeToFit()
        labelNoGraphData.font = UIFont.fontGothamRoundedMedium(withSize: 11.0)
        labelNoGraphData.textColor = UIColor.stasherText()
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
// MARK: - Create the graph

    func getGraphViewForChildren() -> UIView? {
            // Generating some dummy data
        var chartData = [Any]() /* capacity: 7 */
        for i in 1..<8 {
            //[chartData addObject:[NSNumber numberWithInt:arc4random()%30]];
            chartData.append(Int(0))
        }
            // Creating the line chart
        var graphView = STGraphView(frame: CGRect(x: CGFloat(18), y: CGFloat(16), width: CGFloat(UIScreen.main.bounds.size.width - 54), height: CGFloat(124)))
        var contView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(graphView.frame.size.width + 30), height: CGFloat(graphView.frame.size.height + 40)))
        contView.addSubview(graphView)
        contView.layer.cornerRadius = 15
        graphView.gridStep = 3
        graphView.labelForIndex = {(_ item: Int) -> Void in
            return "\(UInt(item))"
        }
        graphView.labelForValue = {(_ value: CGFloat) -> Void in
            return String(format: "%.f", value)
        }
        graphView.chartData = chartData
        contView.backgroundColor = UIColor(red: CGFloat(230.0 / 255), green: CGFloat(230.0 / 255), blue: CGFloat(230.0 / 255), alpha: CGFloat(1.0))
        return contView
    }

    func requestMyActivities() {
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
            kParamKeyUserID : Int(CInt(STUserIdentity.sharedInstance().userId())),
            kParamKeyAction : kParamKeyMyActivities
        ]
, json: true)
    }

    func adjustHeightOfTableview() {
        var height: CGFloat = myActivityTableView.contentSize.height
        constraintHeightmyActivityTableView.constant = myActivityTableView.contentSize.height
        var maxHeight: CGFloat? = myActivityTableView.superview?.frame?.size?.height - myActivityTableView.frame.origin.y
        // if the height of the content is greater than the maxHeight of
        // total space on the screen, limit the height to the size of the
        // superview.
        if height > maxHeight {
            height = maxHeight
        }
            // now set the frame accordingly
        var frame: CGRect = myActivityTableView.frame
        frame.size.height = height
        myActivityTableView.frame = frame
        // if you have other controls that should be resized/moved to accommodate
        // the resized tableview, do that here, too
        constraintHeightMyActivityTableViewContainerView.constant = myActivityTableView.contentSize.height
        constraintHeightControlsContView.constant = activityContainerView.frame.origin.y + myActivityTableView.contentSize.height
    }
// MARK: ----- Actions

    @IBAction func badgesButtonPressed(_ sender: Any) {
        myBadgesButton.setTitleColor(UIColor.white, for: .normal)
        activityButton.setTitleColor(UIColor(red: CGFloat(194.0 / 255), green: CGFloat(194.0 / 255), blue: CGFloat(194.0 / 255), alpha: CGFloat(1.0)), for: .normal)
        myBadgesButton.setBackgroundImage(UIImage(named: "stasher_mybadgesButton"), for: .normal)
        activityButton.setBackgroundImage(UIImage(named: "stasher_activityButton"), for: .normal)
        badgesContainerView.setHidden(animated: false)
        activityContainerView.setHidden(animated: true)
        myBadgesButton.titleLabel?.font = UIFont.fontGothamRoundedBold(withSize: 8.0)
        activityButton.titleLabel?.font = UIFont.fontGothamRoundedBook(withSize: 8.0)
        constraintHeightControlsContView.constant = badgesContainerView.frame.origin.y + badgesContainerView.frame.size.height
    }

    @IBAction func activityButtonPressed(_ sender: Any) {
        activityButton.setTitleColor(UIColor.white, for: .normal)
        myBadgesButton.setTitleColor(UIColor(red: CGFloat(194.0 / 255), green: CGFloat(194.0 / 255), blue: CGFloat(194.0 / 255), alpha: CGFloat(1.0)), for: .normal)
        activityButton.setBackgroundImage(UIImage(named: "stasher_mybadgesButton"), for: .normal)
        myBadgesButton.setBackgroundImage(UIImage(named: "stasher_activityButton"), for: .normal)
        badgesContainerView.setHidden(animated: true)
        myBadgesButton.titleLabel?.font = UIFont.fontGothamRoundedBook(withSize: 8.0)
        activityButton.titleLabel?.font = UIFont.fontGothamRoundedBold(withSize: 8.0)
        requestMyActivities()
    }
// MARK: ----- MyActivity TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount: Int = 0
        rowCount = Int(myActivityArray.count)
        return rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var simpleTableIdentifier: String = "STParentMyActivityCustomCell"
        var myActivityCell: STParentMyActivityCustomCell? = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if myActivityCell == nil {
            myActivityCell = (Bundle.main.loadNibNamed(NSStringFromClass(STParentMyActivityCustomCell.self), owner: self, options: [])[0] as? STParentMyActivityCustomCell)
        }
        if myActivityArray.count > indexPath.row {
            if myActivityArray[indexPath.row] {
                /*
                            [myActivityCell.labelDescription setAttributedText:[[NSAttributedString alloc] initWithString:[[self.myActivityArray objectAtIndex:indexPath.row] objectForKey:@"description"]
                                                                                                               attributes:@{
                                                                                                                            NSForegroundColorAttributeName:[UIColor stasherTextColor],
                                                                                                                            NSFontAttributeName : [UIFont FontGothamRoundedMediumWithSize:12.0f]
                                                                                                                            }
                                                                                ]];
                            CGRect paragraphRect = [myActivityCell.labelDescription.attributedText boundingRectWithSize:CGSizeMake(200.f, CGFLOAT_MAX)
                                                                                                                options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                                                                                context:nil];
                             
                            myActivityCell.constraintLabelDescriptionHeight.constant = paragraphRect.size.height;
                             */
                myActivityCell?.labelDescription?.textColor = UIColor.stasherText()
                myActivityCell?.labelDescription?.font = UIFont.fontGothamRoundedBold(withSize: 11.0)
                myActivityCell?.labelDescription?.text = myActivityArray[indexPath.row]["description"]
                myActivityCell?.labelDescription?.sizeToFit()
                myActivityCell?.labelActivityTitle?.font = UIFont.fontGothamRoundedMedium(withSize: 12.0)
                myActivityCell?.labelActivityTitle?.textColor = UIColor.stasherTextFieldPlaceHolder()
                switch CInt(myActivityArray[indexPath.row]["activity_type"]) {
                    case 1:
                        myActivityCell?.activityTypeImgView?.image = UIImage(named: "fund_request")
                        myActivityCell?.labelActivityTitle?.text = "Fund Request"
                    case 2:
                        myActivityCell?.activityTypeImgView?.image = UIImage(named: "mission_Accepted")
                        myActivityCell?.labelActivityTitle?.text = "Mission accepted"
                    case 3:
                        myActivityCell?.activityTypeImgView?.image = UIImage(named: "mission_completed")
                        myActivityCell?.labelActivityTitle?.text = "User Request"
                    default:
                        break
                }

                myActivityCell?.labelActivityTime?.textColor = UIColor.stasherTextFieldPlaceHolder()
                myActivityCell?.labelActivityTime?.font = UIFont.fontGothamRoundedMedium(withSize: 9.5)
                var dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var theDate: Date? = dateFormat.date(fromString: ((myActivityArray[indexPath.row] as? Date)?["inserted_date"] as? Date))
                var dateFormat2 = DateFormatter()
                dateFormat2.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var theDate2: String = dateFormat2.string(from: Date())
                var dt: Date? = dateFormat.date(fromString: theDate2)
                var minutes: Int? = dt?.timeIntervalSince(theDate) / 60
                if minutes < 1 {
                    myActivityCell?.labelActivityTime?.text = "Just now"
                }
                else if minutes > 1 && minutes < 60 {
                    myActivityCell?.labelActivityTime?.text = "\(minutes) Minutes Ago"
                }
                else if minutes > 59 && minutes < 1440 {
                    myActivityCell?.labelActivityTime?.text = "\(minutes / 60) Hours Ago"
                }
                else if minutes > 1439 {
                    myActivityCell?.labelActivityTime?.text = "\(minutes / 1440) Days Ago"
                }

                var timeLabelFrame: CGRect? = myActivityCell?.labelActivityTime?.frame
                timeLabelFrame?.origin?.y = myActivityCell?.constraintLabelDescriptionHeight?.constant + myActivityCell?.labelDescription?.frame?.origin?.y + 8.0
                myActivityCell?.labelActivityTime?.frame = timeLabelFrame
            }
        }
        myActivityCell?.selectionStyle = []
        return myActivityCell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            if (conn.userInfo?["params"][kParamKeyAction] == kParamKeyMyActivities) {
                var responseArray: [Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
                if (responseArray? is [Any]) {
                    if responseArray != nil {
                        if (conn.userInfo?["params"][kParamKeyAction] == kParamKeyMyActivities) {
                            if !myActivityArray.isEmpty {
                                myActivityArray = nil
                            }
                            activityContainerView.setHidden(animated: false)
                            myActivityArray = responseArray?
                            myActivityTableView.reloadData()
                            adjustHeightOfTableview()
                        }
                    }
                }
                else if (responseArray? is [AnyHashable: Any]) {
                    if (responseArray as? [AnyHashable: Any])?["error"] {
                        UIAlertView.show(withTitle: "", message: (responseArray as? [AnyHashable: Any])?["error"]?["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                            if buttonIndex == alertView.cancelButtonIndex {

                            }
                        })
                    }
                    myActivityTableView.reloadData()
                }
            }
            else if (conn.userInfo?["params"][kParamKeyAction] == kAPIActionChildGraph) {
                var responseDict: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
                if responseDict != nil {
                    print("child graph response \(responseDict)")
                }
            }
        }
    }
// MARK: ----- Scrollview Delegate

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        pointNow = scrollView.contentOffset
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == containerScrollView {
            if scrollView.contentOffset.y < pointNow.y {
                if scrollView.contentOffset.y <= 400 {
                    myBadgesHeaderView.center = actualMyBadgesHeaderViewCenter
                }
                else {
                    myBadgesHeaderView.center = CGPoint(x: CGFloat(myBadgesHeaderView.center.x), y: CGFloat(scrollView.contentOffset.y + 35))
                }
            }
            else if scrollView.contentOffset.y > pointNow.y {
                if scrollView.contentOffset.y > 400 {
                    //[scrollView setContentOffset:CGPointMake(0,self.imgViewStickDivider.frame.origin.y-1) animated:YES];
                    myBadgesHeaderView.center = CGPoint(x: CGFloat(myBadgesHeaderView.center.x), y: CGFloat(scrollView.contentOffset.y + 35))
                }
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
}