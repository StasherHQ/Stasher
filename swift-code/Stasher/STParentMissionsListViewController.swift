//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STParentMissionsListViewController.swift
//  Stasher
//
//  Created by bhushan on 25/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol ParentMissionListDelegate: NSObjectProtocol {
    func parentCellEditMissionButtonPressed(withMissionDict dict: [AnyHashable: Any])

    func parentCellCompleteMissionButtonPressed(withMissionDict dict: [AnyHashable: Any])

    func parentCellRemindMissionButtonPressed(withMissionDict dict: [AnyHashable: Any])

    func parentMissionListCellDidSelect(withDict dict: [AnyHashable: Any])
}
class STParentMissionsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ParentMissionCustomTableCellDelegate {

    weak var delegate: ParentMissionListDelegate?
    @IBOutlet var missionListTableView: UITableView!
    var missionsListType: String = ""
    var arrayMissionList = [Any]()

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, missionListType missionsListKind: String, andMissionListArray array: [Any]) {
        super.init(nibName: "STParentMissionsListViewController", bundle: Bundle.main)
        
        missionsListType = missionsListKind
        if arrayMissionList.isEmpty {
            arrayMissionList = [Any](arrayLiteral: array)
        }
    
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        missionListTableView.contentInset = UIEdgeInsetsMake(10.0, 0, 0, 0)
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
                    static NSString *parentCompletedMissionCustomTableViewCellIdentifier = @"STParentCompletedMissionCustomTableViewCell";
                    
                    STParentCompletedMissionCustomTableViewCell *missionCompleteCell = [tableView dequeueReusableCellWithIdentifier:parentCompletedMissionCustomTableViewCellIdentifier];
                    
                    if (missionCompleteCell == nil) {
                        missionCompleteCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([STParentCompletedMissionCustomTableViewCell class]) owner:self options:0] objectAtIndex:0];
                    }
                    if ([self.arrayMissionList count] > indexPath.row) {
                        if ([self.arrayMissionList objectAtIndex:indexPath.row]) {
                            missionCompleteCell.labelMissionTitle.text = [[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:@"title"];
                            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *theDate = [dateFormat dateFromString:[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:@"totaltime"]];
                            NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                            [dateFormat2 setDateFormat:@"MMMM d, YYYY"];
                            NSString *dateStr = [dateFormat2 stringFromDate:theDate];
                            
                            missionCompleteCell.labelMissionInfo.text = [NSString stringWithFormat:@"Mission %d for %@ - %@",[[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:@"missionId"] intValue], [[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kParamKeyChild] objectForKey:kParamKeyFirstname],dateStr];
                            
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
                }
                */
        var simpleTableIdentifier: String = "STParentMissionCustomTableViewCell"
        var cell: STParentMissionCustomTableViewCell? = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if cell == nil {
            cell = (Bundle.main.loadNibNamed(NSStringFromClass(STParentMissionCustomTableViewCell.self), owner: self, options: [])[0] as? STParentMissionCustomTableViewCell)
        }
        if arrayMissionList.count > indexPath.row {
            if arrayMissionList[indexPath.row] {
                cell?.labelMissionCount?.text = "Mission \(Int(indexPath.row + 1)):"
                cell?.labelMissionTitle?.text = arrayMissionList[indexPath.row]["title"]
                var totalMissionHrs: Int
                var leftMissionHrs: Int
                var dateFormat = DateFormatter()
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
                    cell?.buttonEdit?.isHidden = true
                    cell?.imgViewDivider?.isHidden = true
                }
                else {
                    cell?.imgViewDividerForCompletedMission?.isHidden = true
                    cell?.buttonComplete?.isHidden = false
                    cell?.buttonEdit?.isHidden = false
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

                if arrayMissionList[indexPath.row][kParamKeyChild] {
                    cell?.imgViewChallenger?.setImageWith(URL(string: arrayMissionList[indexPath.row][kParamKeyChild][kParamKeyAvatar]))
                }
                if (missionsListType == kMissionBarPendingMission) {
                    cell?.buttonComplete?.setTitle("Remind", for: .normal)
                }
                else if (missionsListType == kMissionBarActiveMission) {
                    cell?.buttonComplete?.setTitle("Complete", for: .normal)
                }

                if !(arrayMissionList[indexPath.row][kParamKeyChild][kParamKeyAvatar] is NSNull) {
                    cell?.imgViewChallenger?.setImageWith(URL(string: arrayMissionList[indexPath.row][kParamKeyChild][kParamKeyAvatar]))
                }
            }
        }
        cell?.selectionStyle = []
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if delegate?.responds(to: #selector(self.parentMissionListCellDidSelectWithDict)) {
            delegate?.parentMissionListCellDidSelect(withDict: arrayMissionList[indexPath.row])
        }
    }

    func completeMissionButtonPressed(withMissionDictionary dict: [AnyHashable: Any]) {
        if delegate?.responds(to: #selector(self.parentCellCompleteMissionButtonPressedWithMissionDict)) {
            delegate?.parentCellCompleteMissionButtonPressed(withMissionDict: dict)
        }
    }

    func remindButtonPressed(withMissionDictionary dict: [AnyHashable: Any]) {
        if delegate?.responds(to: #selector(self.parentCellRemindMissionButtonPressedWithMissionDict)) {
            delegate?.parentCellRemindMissionButtonPressed(withMissionDict: dict)
        }
    }

    func editMissionButtonPressed(withMissionDictionary dict: [AnyHashable: Any]) {
        if delegate?.responds(to: #selector(self.parentCellEditMissionButtonPressedWithMissionDict)) {
            delegate?.parentCellEditMissionButtonPressed(withMissionDict: dict)
        }
    }
}