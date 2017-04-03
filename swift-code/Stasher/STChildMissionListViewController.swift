//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STChildMissionListViewController.swift
//  Stasher
//
//  Created by bhushan on 27/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol ChildMissionListDelegate: NSObjectProtocol {
    func childCellCompleteMissionButtonPressed(withMissionDict dict: [AnyHashable: Any])

    func childCellAcceptMissionButtonPressed(withMissionDict dict: [AnyHashable: Any])

    func childCellCancelMissionButtonPressed(withMissionDict dict: [AnyHashable: Any])

    func childMissionListCellDidSelect(withDict dict: [AnyHashable: Any])
}
class STChildMissionListViewController: UIViewController, ChildMissionCustomTableCellDelegate, STChildMissionCompletedCellDelegate, BOABHttpReqDelegate {
    var httpReq: BOABHttpReq?

    weak var delegate: ChildMissionListDelegate?
    @IBOutlet var tableViewChildMissionList: UITableView!
    var missionsListType: String = ""
    var arrayMissionList = [Any]()

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, missionListType missionsListKind: String, andMissionListArray array: [Any]) {
        super.init(nibName: "STChildMissionListViewController", bundle: Bundle.main)
        
        missionsListType = missionsListKind
        if arrayMissionList.isEmpty {
            arrayMissionList = [Any](arrayLiteral: array)
        }
    
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        tableViewChildMissionList.contentInset = UIEdgeInsetsMake(10.0, 0, 0, 0)
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
// MARK: ----- Custom Methods
// MARK: ----- Table Mission List

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (missionsListType == kMissionBarCompletedMission) {
            return 170.0
        }
        return 200.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMissionList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            /*
                if ([self.missionsListType isEqualToString:kMissionBarCompletedMission])
                {
                    static NSString *parentCompletedMissionCustomTableViewCellIdentifier = @"STChildMissionCompleteCustomTableViewCell";
                    
                    STChildMissionCompleteCustomTableViewCell *missionCompleteCell = [tableView dequeueReusableCellWithIdentifier:parentCompletedMissionCustomTableViewCellIdentifier];
                    
                    if (missionCompleteCell == nil) {
                        missionCompleteCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([STChildMissionCompleteCustomTableViewCell class]) owner:self options:0] objectAtIndex:0];
                    }
                    if ([self.arrayMissionList count] > indexPath.row) {
                        if ([self.arrayMissionList objectAtIndex:indexPath.row]) {
                            missionCompleteCell.delegate=self;
                            missionCompleteCell.labelMissionTitle.text = [[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:@"title"];
                            
                            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *theDate = [dateFormat dateFromString:[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:@"totaltime"]];
                            
                            NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                            [dateFormat2 setDateFormat:@"MMMM d, YYYY"];
                            NSString *dateStr = [dateFormat2 stringFromDate:theDate];
                            
                            missionCompleteCell.labelMissionInfo.text = [NSString stringWithFormat:@"Mission %d from %@ - %@",[[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:@"missionId"] intValue], [[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kParamKeyParent] objectForKey:kParamKeyFirstname],dateStr];
                            missionCompleteCell.missionDict = [self.arrayMissionList objectAtIndex:indexPath.row];
                            if(![[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kAddMissionParamKeyRewardType] isEqualToString:@"gift"]){
                                [missionCompleteCell.labelRewardAmount setHidden:NO];
                                UIFont *font1 = [UIFont FontGothamRoundedBoldWithSize:9.6f];
                                NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
                                NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"$"] attributes: arialDict];
                                
                                UIFont *font2 = [UIFont FontGothamRoundedBoldWithSize:15.6f];
                                NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
                                NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kAddMissionParamKeyRewards] attributes: arialDict2];
                                [aAttrString1 appendAttributedString:aAttrString2];
                                [missionCompleteCell.labelRewardAmount setAttributedText:aAttrString1];
                                [missionCompleteCell.giftIconImgView setHidden:YES];
                            }
                            else{
                                [missionCompleteCell.labelRewardAmount setHidden:YES];
                                [missionCompleteCell.giftIconImgView setHidden:NO];
                            }
                        }
                        [missionCompleteCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        return missionCompleteCell;
                    }
                }*/
        var simpleTableIdentifier: String = "STChildMissionCustomTableViewCell"
        var cell: STChildMissionCustomTableViewCell? = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if cell == nil {
            cell = (Bundle.main.loadNibNamed(NSStringFromClass(STChildMissionCustomTableViewCell.self), owner: self, options: [])[0] as? STChildMissionCustomTableViewCell)
        }
        if arrayMissionList.count > indexPath.row {
            if arrayMissionList[indexPath.row] {
                cell?.labelMissionCount?.text = "Mission \(Int(indexPath.row + 1)):"
                cell?.labelMissionTitle?.text = arrayMissionList[indexPath.row]["title"]
                var totalMissionHrs: Int
                var leftMissionHrs: Int
                var dateFormat = DateFormatter()
                dateFormat.timeZone = NSTimeZone.local()
                dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var theDateOfInsertion: Date? = dateFormat.date(fromString: ((arrayMissionList[indexPath.row] as? Date)?["inserted_date"] as? Date))
                var theDate: Date? = dateFormat.date(fromString: ((arrayMissionList[indexPath.row] as? Date)?["totaltime"] as? Date))
                if theDateOfInsertion != nil && theDate != nil {
                    var c = Calendar.current
                    var components: DateComponents? = c.dateComponents(.hour, from: theDateOfInsertion, to: theDate, options: kNilOptions)
                    var diff: Int? = components?.hour
                    totalMissionHrs = diff
                }
                if theDate != nil {
                    var c = Calendar.current
                    var components: DateComponents? = c.dateComponents(.hour, from: Date(), to: theDate, options: kNilOptions)
                    var diff: Int? = components?.hour
                    leftMissionHrs = diff
                }
                var prog = CFloat(Int(leftMissionHrs)) / CFloat(Int(totalMissionHrs))
                print("prog \(prog) at ind \(Int(indexPath.row))")
                if totalMissionHrs < 8760 {
                    if prog == 1.0 {
                        cell?.imgViewMissionExpired?.isHidden = true
                        if leftMissionHrs <= 24 {
                            var font4 = UIFont.fontGothamRoundedMedium(withSize: 11.5)
                            var arialDict4: [AnyHashable: Any] = [ NSFontAttributeName : font4 ]
                            var aAttrString4 = NSMutableAttributedString(string: "\("\(UInt(leftMissionHrs))")  ", attributes: arialDict4)
                            var font5 = UIFont.fontGothamRoundedBold(withSize: 5.0)
                            var arialDict5: [AnyHashable: Any] = [ NSFontAttributeName : font5 ]
                            var aAttrString5 = NSMutableAttributedString(string: "\("HOURS")", attributes: arialDict5)
                            aAttrString4.append(aAttrString5)
                            cell?.labelDueHrs?.attributedText = aAttrString4
                        }
                        else {
                            var day: Int
                            var hr: Int
                            day = leftMissionHrs / 24
                            hr = leftMissionHrs % 24
                            var font4 = UIFont.fontGothamRoundedMedium(withSize: 11.5)
                            var arialDict4: [AnyHashable: Any] = [ NSFontAttributeName : font4 ]
                            var aAttrString4 = NSMutableAttributedString(string: "\("\(UInt(day))") \("\(UInt(hr))")", attributes: arialDict4)
                            cell?.labelDueHrs?.attributedText = aAttrString4
                        }
                        cell?.dueProgressView?.progress = 1.0 - prog
                    }
                    else if prog > 1.0 {
                        cell?.imgViewMissionExpired?.isHidden = false
                    }
                    else if prog >= 0.1 && prog < 1.0 {
                        cell?.imgViewMissionExpired?.isHidden = true
                        if leftMissionHrs <= 24 {
                            var font4 = UIFont.fontGothamRoundedMedium(withSize: 11.5)
                            var arialDict4: [AnyHashable: Any] = [ NSFontAttributeName : font4 ]
                            var aAttrString4 = NSMutableAttributedString(string: "\("\(UInt(leftMissionHrs))")  ", attributes: arialDict4)
                            var font5 = UIFont.fontGothamRoundedBold(withSize: 5.0)
                            var arialDict5: [AnyHashable: Any] = [ NSFontAttributeName : font5 ]
                            var aAttrString5 = NSMutableAttributedString(string: "\("HOURS")", attributes: arialDict5)
                            aAttrString4.append(aAttrString5)
                            cell?.labelDueHrs?.attributedText = aAttrString4
                        }
                        else {
                            var day: Int
                            var hr: Int
                            day = leftMissionHrs / 24
                            hr = leftMissionHrs % 24
                            var font4 = UIFont.fontGothamRoundedMedium(withSize: 11.5)
                            var arialDict4: [AnyHashable: Any] = [ NSFontAttributeName : font4 ]
                            var aAttrString4 = NSMutableAttributedString(string: "\("\(UInt(day))") \("\(UInt(hr))")", attributes: arialDict4)
                            cell?.labelDueHrs?.attributedText = aAttrString4
                        }
                        cell?.dueProgressView?.progress = 1.0 - prog
                    }
                    else {
                        cell?.imgViewMissionExpired?.isHidden = false
                    }
                }
                else {
                    cell?.imgViewMissionExpired?.isHidden = false
                }
                if !(arrayMissionList[indexPath.row][kAddMissionParamKeyRewardType] == "gift") {
                    cell?.labelRewardAmount?.isHidden = false
                    var font1 = UIFont.fontGothamRoundedBold(withSize: 9.6)
                    var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
                    var aAttrString1 = NSMutableAttributedString(string: "$", attributes: arialDict)
                    var font2 = UIFont.fontGothamRoundedBold(withSize: 9.6)
                    var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
                    var aAttrString2 = NSMutableAttributedString(string: ((arrayMissionList[indexPath.row] as? NSMutableAttributedString)?[kAddMissionParamKeyRewards] as? NSMutableAttributedString), attributes: arialDict2)
                    aAttrString1.append(aAttrString2)
                    cell?.labelRewardAmount?.attributedText = aAttrString1
                    cell?.labelRewardAmount?.sizeToFit()
                    cell?.giftIconImgView?.isHidden = true
                }
                else {
                    cell?.labelRewardAmount?.isHidden = true
                    cell?.giftIconImgView?.isHidden = false
                }
                cell?.missionDictionary = arrayMissionList[indexPath.row]
                cell?.delegate = self
                cell?.cellMissionTypeString = missionsListType
                if (cell?.cellMissionTypeString == kMissionBarCompletedMission) {
                    cell?.imgViewMissionExpired?.isHidden = true
                    cell?.dueProgressView?.progress = 1.0
                    //set full progress for completed mission
                }
                if (cell?.cellMissionTypeString == kMissionBarCompletedMission) {
                    cell?.imgViewDividerForCompletedMission?.isHidden = false
                    cell?.buttonComplete?.isHidden = true
                    cell?.buttonCancel?.isHidden = true
                    cell?.imgViewDivider?.isHidden = true
                }
                else {
                    cell?.imgViewDividerForCompletedMission?.isHidden = true
                    cell?.buttonComplete?.isHidden = false
                    cell?.buttonCancel?.isHidden = false
                    cell?.imgViewDivider?.isHidden = false
                }
                if (cell?.cellMissionTypeString == kMissionBarCompletedMission) {
                    cell?.imgViewMissionStatus?.image = UIImage(named: "Stasher_StatusCheckmark")
                }
                else if (cell?.cellMissionTypeString == kMissionBarPendingMission) {
                    cell?.imgViewMissionStatus?.image = UIImage(named: "Stasher_StatusCrossmark")
                }
                else if (cell?.cellMissionTypeString == kMissionBarActiveMission) {
                    cell?.imgViewMissionStatus?.image = UIImage(named: "Stasher_StatusCrossmark")
                }
                else {
                    if CInt(arrayMissionList[indexPath.row][kParamKeyMissionStatus]) == 3 {
                        cell?.imgViewMissionStatus?.image = UIImage(named: "Stasher_StatusCheckmark")
                    }
                    else {
                        cell?.imgViewMissionStatus?.image = nil
                    }
                }

                if arrayMissionList[indexPath.row][kParamKeyParent] {
                    if arrayMissionList[indexPath.row][kParamKeyParent][kParamKeyAvatar] {
                        if !(arrayMissionList[indexPath.row][kParamKeyParent][kParamKeyAvatar] is NSNull) {
                            cell?.imgViewChallenger?.setImageWith(URL(string: arrayMissionList[indexPath.row][kParamKeyParent][kParamKeyAvatar]))
                        }
                    }
                }
                if (missionsListType == kMissionBarPendingMission) {
                    cell?.buttonCancel?.setTitle("Accept", for: .normal)
                    cell?.buttonCancel?.setBackgroundImage(UIImage(named: "Stasher_completeBTN"), for: .normal)
                    cell?.buttonComplete?.setTitle("Cancel", for: .normal)
                    cell?.buttonComplete?.setBackgroundImage(UIImage(named: "Stasher_editBTN"), for: .normal)
                }
                else if (missionsListType == kMissionBarActiveMission) {
                    cell?.buttonComplete?.setTitle("Complete", for: .normal)
                    cell?.buttonCancel?.setTitle("Cancel", for: .normal)
                    cell?.buttonCancel?.setBackgroundImage(UIImage(named: "Stasher_editBTN"), for: .normal)
                    cell?.buttonComplete?.setBackgroundImage(UIImage(named: "Stasher_completeBTN"), for: .normal)
                }
            }
        }
        cell?.selectionStyle = []
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if delegate?.responds(to: #selector(self.childMissionListCellDidSelectWithDict)) {
            delegate?.childMissionListCellDidSelect(withDict: arrayMissionList[indexPath.row])
        }
    }

    func childCompleteMissionButtonPressed(withMissionDictionary dict: [AnyHashable: Any]) {
        if delegate?.responds(to: #selector(self.childCellCompleteMissionButtonPressedWithMissionDict)) {
            delegate?.childCellCompleteMissionButtonPressed(withMissionDict: dict)
        }
    }

    func childAcceptMissionButtonPressed(withMissionDictionary dict: [AnyHashable: Any]) {
        if delegate?.responds(to: #selector(self.childCellAcceptMissionButtonPressedWithMissionDict)) {
            delegate?.childCellAcceptMissionButtonPressed(withMissionDict: dict)
        }
    }

    func childCancelMissionButtonPressed(withMissionDictionary dict: [AnyHashable: Any]) {
        if delegate?.responds(to: #selector(self.childCellCancelMissionButtonPressedWithMissionDict)) {
            delegate?.childCellCancelMissionButtonPressed(withMissionDict: dict)
        }
    }

    func childMissionCompletedCellRequestRewardButtonPressed(withDict dict: [AnyHashable: Any]) {
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        var paramDict = [AnyHashable: Any]()
        if STUserIdentity.sharedInstance().userId() != nil {
            paramDict[kParamKeyParentID] = dict[kParamKeyParentID]
            paramDict[kParamKeyChildID] = STUserIdentity.sharedInstance().userId()
            paramDict[kParamKeyComment] = dict["description"]
            paramDict[kParamKeyPrice] = dict[kParamKeyRewardType]
            paramDict[kParamKeyAction] = kAPIActionChildRequestPayment
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
            paramDict = nil
        }
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDictionary != nil {
                do {
                    if responseDictionary?["success"] {
                        UIAlertView.show(withTitle: "", message: responseDictionary?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        })
                    }
                    else if responseDictionary?["error"] {
                        UIAlertView.show(withTitle: "", message: responseDictionary?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        })
                    }

                }
            }
        }
    }
}