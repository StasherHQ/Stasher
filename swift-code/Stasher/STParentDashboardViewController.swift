//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STParentDashboardViewController.swift
//  Stasher
//
//  Created by bhushan on 24/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol ParentDashboardDelegate: NSObjectProtocol {
    func parentDashboardChildDetailsSelected(withDictionary dict: [AnyHashable: Any])
}
class STParentDashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BOABHttpReqDelegate {
    var pointNow = CGPoint.zero
    var httpReq: BOABHttpReq?

    weak var delegate: ParentDashboardDelegate?
    var childrenArray = [Any]()
    @IBOutlet var childNamesListTableView: UITableView!
    @IBOutlet var graphContainerView: UIView!
    @IBOutlet var labelDeposites: UILabel!
    @IBOutlet var labelPendingMissions: UILabel!
    @IBOutlet var labelActiveMissions: UILabel!
    @IBOutlet var labelDepositesInAWeek: UILabel!
    @IBOutlet var labelHeadingPendingMission: UILabel!
    @IBOutlet var labelHeadingActiveMission: UILabel!
    @IBOutlet var labelMyChildren: UILabel!
    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet var labelNoGraphData: UILabel!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet var controlsContainerView: UIView!
    @IBOutlet weak var constraintHeightControlContainerView: NSLayoutConstraint!
    @IBOutlet var imgViewStickDivider: UIImageView!

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, withDashboardChildArray thisChildArray: [Any]) {
        super.init(nibName: "STParentDashboardViewController", bundle: Bundle.main)
        
        childrenArray = [Any](arrayLiteral: thisChildArray)
    
    }

    func requestParentGraphData() {
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: false)
        if httpReq?.reachable {
            var paramDict = [AnyHashable: Any]()
            if STUserIdentity.sharedInstance().userId() != nil {
                paramDict[kParamKeyAction] = kAPIActionParentGraph
                paramDict[kParamKeyParentID] = STUserIdentity.sharedInstance().userId()
                httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
                paramDict = nil
            }
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        childNamesListTableView.delegate = self
        childNamesListTableView.dataSource = self
            //[self.graphContainerView addSubview:[self getGraphViewForParent] withAnimation:YES];
        var font1 = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
        var aAttrString1 = NSMutableAttributedString(string: "\("Total") ", attributes: arialDict)
        var font2 = UIFont.fontGothamRoundedBold(withSize: 10.0)
        var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
        var aAttrString2 = NSMutableAttributedString(string: "\("Deposits") ", attributes: arialDict2)
        aAttrString1.append(aAttrString2)
        var font3 = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        var arialDict3: [AnyHashable: Any] = [ NSFontAttributeName : font3 ]
        var aAttrString3 = NSMutableAttributedString(string: "\("in a Week")", attributes: arialDict3)
        aAttrString1.append(aAttrString3)
        labelDepositesInAWeek.attributedText = aAttrString1
        var font4 = UIFont.fontGothamRoundedMedium(withSize: 11.5)
        var arialDict4: [AnyHashable: Any] = [ NSFontAttributeName : font4 ]
        var aAttrString4 = NSMutableAttributedString(string: "\("$")", attributes: arialDict4)
        var font5 = UIFont.fontGothamRoundedBold(withSize: 21.21)
        var arialDict5: [AnyHashable: Any] = [ NSFontAttributeName : font5 ]
        var aAttrString5 = NSMutableAttributedString(string: "\("\(STUserIdentity.sharedInstance().depositsAmount())")", attributes: arialDict5)
        aAttrString4.append(aAttrString5)
        labelDeposites.attributedText = aAttrString4
        labelDepositesInAWeek.attributedText = aAttrString1
        labelPendingMissions.text = "\(STUserIdentity.sharedInstance().pendingMissionsCount())"
        labelActiveMissions.text = "\(STUserIdentity.sharedInstance().activeMissionsCount())"
        labelActiveMissions.font = UIFont.fontGothamRoundedMedium(withSize: 12.0)
        labelPendingMissions.font = UIFont.fontGothamRoundedMedium(withSize: 12.0)
        labelMyChildren.font = UIFont.fontGothamRoundedMedium(withSize: 11.0)
        labelMyChildren.textColor = UIColor.stasherText()
        labelActiveMissions.textColor = UIColor.white
        labelPendingMissions.textColor = UIColor.white
        labelDepositesInAWeek.textColor = UIColor.stasherText()
        labelDeposites.textColor = UIColor.white
        labelHeadingActiveMission.font = UIFont.fontGothamRoundedMedium(withSize: 5.0)
        labelHeadingActiveMission.textColor = UIColor(red: CGFloat(140.0 / 255), green: CGFloat(140.0 / 255), blue: CGFloat(140.0 / 255), alpha: CGFloat(1.0))
        labelHeadingPendingMission.font = UIFont.fontGothamRoundedMedium(withSize: 5.0)
        labelHeadingPendingMission.textColor = UIColor(red: CGFloat(140.0 / 255), green: CGFloat(140.0 / 255), blue: CGFloat(140.0 / 255), alpha: CGFloat(1.0))
        labelHeadingPendingMission.sizeToFit()
        labelHeadingActiveMission.sizeToFit()
        labelActiveMissions.sizeToFit()
        labelPendingMissions.sizeToFit()
        labelDepositesInAWeek.sizeToFit()
        labelDeposites.sizeToFit()
        labelNoGraphData.sizeToFit()
        labelNoGraphData.font = UIFont.fontGothamRoundedMedium(withSize: 11.0)
        labelNoGraphData.textColor = UIColor.stasherText()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        adjustHeightOfTableview()
        if childrenArray.count == 0 {
            labelMyChildren.isHidden = true
        }
        else {
            labelMyChildren.isHidden = false
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
// MARK: - Custom

    func getGraphViewForParent() -> UIView? {
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
        constraintHeightControlContainerView.constant = childNamesListTableView.frame.origin.y + childNamesListTableView.contentSize.height + 8.0
    }
// MARK: ----- Table Child Names

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        if delegate?.responds(to: #selector(self.parentDashboardChildDetailsSelectedWithDictionary)) {
            delegate?.parentDashboardChildDetailsSelected(withDictionary: childrenArray[indexPath.row])
        }
    }
// MARK: ----- BOABHttpReq Delegate

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDict: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDict != nil {
                print("parent graph response \(responseDict)")
            }
        }
    }

    func boabHttpReqFailedWithError(_ error: Error?) {
        if error != nil {

        }
    }
}