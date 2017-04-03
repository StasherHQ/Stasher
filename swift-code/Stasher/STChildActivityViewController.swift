//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STChildActivityViewController.swift
//  Stasher
//
//  Created by bhushan on 03/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
protocol ChildActivityDelegate: NSObjectProtocol {
    func childActivityCellDidSelect(withDict dict: [AnyHashable: Any])
}
class STChildActivityViewController: UIViewController {
    var httpReq: BOABHttpReq?

    weak var delegate: ChildActivityDelegate?
    @IBOutlet var activityHeaderScrollview: UIScrollView!
    @IBOutlet var activityPageControl: UIPageControl!
    @IBOutlet var myActivityView: UIView!
    @IBOutlet var globalActivityView: UIView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var myActivityTableView: UITableView!
    @IBOutlet var globalActivityTableView: UITableView!
    var myActivityArray = [Any]()
    var globalActivityArray = [Any]()
    @IBOutlet var imgViewNoActivity: UIImageView!
    @IBOutlet var labelNoActivityTitle: UILabel!
    @IBOutlet var labelNoRecentActivity: UILabel!

    func requestActivity() {
        activityPageControl.numberOfPages = 2
        var activityButtonFrame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(UIScreen.main.bounds.size.width), height: CGFloat(activityHeaderScrollview.frame.size.height))
        for c in 0..<2 {
            if c == 0 {
                activityHeaderScrollview.addSubview(myActivityView)
                myActivityView.frame = activityButtonFrame
            }
            if c == 1 {
                activityHeaderScrollview.addSubview(globalActivityView)
                globalActivityView.frame = activityButtonFrame
            }
            activityButtonFrame.origin.x += activityButtonFrame.size.width
        }
        var contentSize: CGSize = activityHeaderScrollview.frame.size
        contentSize.width = activityButtonFrame.origin.x
        contentSize.height = 0
        activityHeaderScrollview.contentSize = contentSize
        headerLabel.font = UIFont()
        if activityPageControl.currentPage == 0 {
            var font1 = UIFont()
            var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
            var aAttrString1 = NSMutableAttributedString(string: "My ", attributes: arialDict)
            var font2 = UIFont()
            var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
            var aAttrString2 = NSMutableAttributedString(string: "Activity", attributes: arialDict2)
            aAttrString1.append(aAttrString2)
            headerLabel.attributedText = aAttrString1
        }
        else {
            var font1 = UIFont()
            var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
            var aAttrString1 = NSMutableAttributedString(string: "Global ", attributes: arialDict)
            var font2 = UIFont()
            var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
            var aAttrString2 = NSMutableAttributedString(string: "Activity", attributes: arialDict2)
            aAttrString1.append(aAttrString2)
            headerLabel.attributedText = aAttrString1
        }
        myActivityTableView.contentInset = UIEdgeInsetsMake(10.0, 0, 0, 0)
        globalActivityTableView.contentInset = UIEdgeInsetsMake(20.0, 0, 0, 0)
        myActivityTableView.tag = 1000
        globalActivityTableView.tag = 1000
        requestActivity(withActivityType: kParamKeyMyActivities)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        labelNoActivityTitle.font = UIFont.fontGothamRoundedBook(withSize: 19.88)
        labelNoRecentActivity.font = UIFont.fontGothamRoundedBook(withSize: 8.83)
        labelNoActivityTitle.sizeToFit()
        labelNoRecentActivity.sizeToFit()
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

    func requestActivity(withActivityType activityType: String) {
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: [
            kParamKeyAction : activityType,
            kParamKeyUserID : STUserIdentity.sharedInstance().userId()
        ]
, json: true)
    }
// MARK: ----- BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseArray: [Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if (responseArray? is [Any]) {
                if responseArray != nil {
                    globalActivityTableView.isHidden = false
                    myActivityTableView.isHidden = false
                    if (conn.userInfo?["params"][kParamKeyAction] == kParamKeyMyActivities) {
                        if !myActivityArray.isEmpty {
                            myActivityArray = nil
                        }
                        myActivityArray = responseArray?
                        myActivityTableView.reloadData()
                    }
                    else {
                        if !globalActivityArray.isEmpty {
                            globalActivityArray = nil
                        }
                        globalActivityArray = responseArray?
                        globalActivityTableView.reloadData()
                    }
                }
                else {
                    globalActivityTableView.isHidden = true
                    myActivityTableView.isHidden = true
                }
            }
            else if (responseArray? is [AnyHashable: Any]) {
                if (responseArray as? [AnyHashable: Any])?["error"] {

                }
                myActivityTableView.reloadData()
                globalActivityTableView.reloadData()
                globalActivityTableView.isHidden = true
                myActivityTableView.isHidden = true
            }
            else {
                globalActivityTableView.isHidden = true
                myActivityTableView.isHidden = true
            }
        }
        else {
            globalActivityTableView.isHidden = true
            myActivityTableView.isHidden = true
        }
    }

    func boabHttpReqFailedWithError(_ error: Error?) {
        if error != nil {

        }
    }
// MARK: ----- Scrollview Delegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var currentIndex = Int(activityHeaderScrollview.contentOffset.x / activityHeaderScrollview.frame.size.width)
        activityPageControl.currentPage = currentIndex
        if activityPageControl.currentPage == 0 {
            var font1 = UIFont()
            var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
            var aAttrString1 = NSMutableAttributedString(string: "My ", attributes: arialDict)
            var font2 = UIFont()
            var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
            var aAttrString2 = NSMutableAttributedString(string: "Activity", attributes: arialDict2)
            aAttrString1.append(aAttrString2)
            headerLabel.attributedText = aAttrString1
        }
        else {
            var font1 = UIFont()
            var arialDict: [AnyHashable: Any] = [ NSFontAttributeName : font1 ]
            var aAttrString1 = NSMutableAttributedString(string: "Global ", attributes: arialDict)
            var font2 = UIFont()
            var arialDict2: [AnyHashable: Any] = [ NSFontAttributeName : font2 ]
            var aAttrString2 = NSMutableAttributedString(string: "Activity", attributes: arialDict2)
            aAttrString1.append(aAttrString2)
            headerLabel.attributedText = aAttrString1
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.tag == 1000 {
            return
        }
        if activityPageControl.currentPage == 0 {
            requestActivity(withActivityType: kParamKeyMyActivities)
        }
        else {
            requestActivity(withActivityType: kParamKeyGlobalActivities)
        }
    }
// MARK: ----- ActivityTableView Delegtes

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight: CGFloat = 100
        if myActivityArray.count > 0 {
            rowHeight += getDynamicLabelSize(UIFont.fontGothamRoundedBold(withSize: 10.0), maxWidth: 247.0, maxHeight: CGFLOAT_MAX, myText: myActivityArray[indexPath.row]["description"]).height - 37
        }
        return rowHeight
    }

    func getDynamicLabelSize(_ font: UIFont, maxWidth: CGFloat, maxHeight: CGFloat, myText: String) -> CGSize {
        var expectedLabelSize: CGSize
        var stringAttributes: [AnyHashable: Any] = [ NSFontAttributeName : font ]
        expectedLabelSize = myText.boundingRect(with: CGSize(width: maxWidth, height: maxHeight), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin], attributes: stringAttributes, context: nil).size
        return expectedLabelSize
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount: Int = 0
        if activityPageControl.currentPage == 0 {
            rowCount = Int(myActivityArray.count)
        }
        else {
            rowCount = Int(globalActivityArray.count)
        }
        return rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == myActivityTableView {
            var simpleTableIdentifier: String = "STChildMyActivityCustomCell"
            var myActivityCell: STChildMyActivityCustomCell? = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
            if myActivityCell == nil {
                myActivityCell = (Bundle.main.loadNibNamed(NSStringFromClass(STChildMyActivityCustomCell.self), owner: self, options: [])[0] as? STChildMyActivityCustomCell)
            }
            if myActivityArray.count > indexPath.row {
                if myActivityArray[indexPath.row] {
                    myActivityCell?.labelDescription?.attributedText = NSAttributedString(string: myActivityArray[indexPath.row]["description"], attributes: [NSForegroundColorAttributeName: UIColor.stasherText(), NSFontAttributeName: UIFont.fontGothamRoundedBold(withSize: 10.0)])
                    var paragraphRect: CGRect? = myActivityCell?.labelDescription?.attributedText?.boundingRect(withSize: CGSize(width: CGFloat(myActivityCell?.labelDescription?.frame?.size?.width), height: CGFloat(CGFLOAT_MAX)), options: ([.usesLineFragmentOrigin, .usesFontLeading]), context: nil)
                    myActivityCell?.constraintLabelDescriptionHeight?.constant = paragraphRect?.size?.height
                    myActivityCell?.labelDescription?.textColor = UIColor.stasherText()
                    //[myActivityCell.labelDescription setFont:[UIFont FontGothamRoundedBoldWithSize:10.0f]];
                    //[myActivityCell.labelDescription setText:[[self.myActivityArray objectAtIndex:indexPath.row] objectForKey:@"description"]];
                    myActivityCell?.labelDescription?.sizeToFit()
                    myActivityCell?.labelActivityTitle?.font = UIFont.fontGothamRoundedMedium(withSize: 8.5)
                    myActivityCell?.labelActivityTitle?.textColor = UIColor.stasherTextFieldPlaceHolder()
                    myActivityCell?.labelActivityTitle?.text = myActivityArray[indexPath.row]["title"]
                    switch CInt(myActivityArray[indexPath.row]["activity_type"]) {
                        case 1:
                            myActivityCell?.activityTypeImgView?.image = UIImage(named: "fund_request")
                        case 2:
                            myActivityCell?.activityTypeImgView?.image = UIImage(named: "mission_Accepted")
                        case 3:
                            myActivityCell?.activityTypeImgView?.image = UIImage(named: "mission_completed")
                        default:
                            break
                    }

                    myActivityCell?.labelActivityTime?.textColor = UIColor.stasherTextFieldPlaceHolder()
                    myActivityCell?.labelActivityTime?.font = UIFont.fontGothamRoundedMedium(withSize: 6.5)
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

                    //CGRect timeLabelFrame = myActivityCell.labelActivityTime.frame;
                    //timeLabelFrame.origin.y = myActivityCell.constraintLabelDescriptionHeight.constant + myActivityCell.labelDescription.frame.origin.y + 8.0f;
                    //[myActivityCell.labelActivityTime setFrame:timeLabelFrame];
                }
            }
            myActivityCell?.selectionStyle = []
            return myActivityCell!
        }
        var simpleTableIdentifier: String = "STChildGlobalActivityCustomCell"
        var cell: STChildGlobalActivityCustomCell? = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if cell == nil {
            cell = (Bundle.main.loadNibNamed(NSStringFromClass(STChildGlobalActivityCustomCell.self), owner: self, options: [])[0] as? STChildGlobalActivityCustomCell)
        }
        if globalActivityArray.count > indexPath.row {
            if myActivityArray[indexPath.row] {
                cell?.labelDescription?.attributedText = NSAttributedString(string: globalActivityArray[indexPath.row]["description"], attributes: [NSForegroundColorAttributeName: UIColor.stasherText(), NSFontAttributeName: UIFont.fontGothamRoundedMedium(withSize: 12.0)])
                var paragraphRect: CGRect? = cell?.labelDescription?.attributedText?.boundingRect(withSize: CGSize(width: CGFloat(200.0), height: CGFloat(CGFLOAT_MAX)), options: ([.usesLineFragmentOrigin, .usesFontLeading]), context: nil)
                cell?.constraintLabelDescriptionHeight?.constant = paragraphRect?.size?.height
                cell?.labelActivityTitle?.textColor = UIColor.stasherText()
                cell?.labelActivityTitle?.font = UIFont.fontGothamRoundedBold(withSize: 13.0)
                cell?.labelActivityTitle?.text = "\(globalActivityArray[indexPath.row]["fname"]) \(globalActivityArray[indexPath.row]["lname"])"
                cell?.labelActivityTime?.textColor = UIColor.stasherTextFieldPlaceHolder()
                cell?.labelActivityTime?.font = UIFont.fontGothamRoundedMedium(withSize: 6.5)
                var dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var theDate: Date? = dateFormat.date(fromString: ((globalActivityArray[indexPath.row] as? Date)?["inserted_date"] as? Date))
                var dateFormat2 = DateFormatter()
                dateFormat2.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var theDate2: String = dateFormat2.string(from: Date())
                var dt: Date? = dateFormat.date(fromString: theDate2)
                var minutes: Int? = dt?.timeIntervalSince(theDate) / 60
                if minutes < 1 {
                    cell?.labelActivityTime?.text = "Just now"
                }
                else if minutes > 1 && minutes < 60 {
                    cell?.labelActivityTime?.text = "\(minutes) Minutes Ago"
                }
                else if minutes > 59 && minutes < 1440 {
                    cell?.labelActivityTime?.text = "\(minutes / 60) Hours Ago"
                }
                else if minutes > 1439 {
                    cell?.labelActivityTime?.text = "\(minutes / 1440) Days Ago"
                }

                cell?.activityTypeImgView?.setImageWith(URL(string: globalActivityArray[indexPath.row]["avatar"]), placeholderImage: UIImage(named: "Stasher_FacePlaceHolder"))
                var timeLabelFrame: CGRect? = cell?.labelActivityTime?.frame
                timeLabelFrame?.origin?.y = cell?.constraintLabelDescriptionHeight?.constant + cell?.labelDescription?.frame?.origin?.y + 8.0
                cell?.labelActivityTime?.frame = timeLabelFrame
            }
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if delegate?.responds(to: #selector(self.ChildActivityCellDidSelectWithDict)) {
            delegate?.childActivityCellDidSelect(withDict: myActivityArray[indexPath.row])
        }
    }
}