//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STActivityDetailsViewController.swift
//  Stasher
//
//  Created by Bhushan on 24/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
class STActivityDetailsViewController: UIViewController {
    var httpReq: BOABHttpReq?

    var activityType: ActivityType?
    @IBOutlet var detailsDict: [AnyHashable: Any]!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var labelActivityDescription: UILabel!
    @IBOutlet var atContainerView: UIView!
    @IBOutlet var atView11: UIView!
    @IBOutlet var labelActivityTitleView11: UILabel!
    @IBOutlet var buttonCancelATView11: UIButton!
    @IBOutlet var buttonAcceptATView11: UIButton!
    @IBOutlet var imgViewProfilePicView11: UIImageView!

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, detailsDict dict: [AnyHashable: Any]) {
        super.init(nibName: "STActivityDetailsViewController", bundle: Bundle.main)
        
        detailsDict = dict
        print("activity details dict \(detailsDict)")
    
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        switch CInt(detailsDict["activity_type"]) {
            case 1:
                break
            case 2:
                break
            case 3:
                break
            case 4:
                break
            case 5:
                break
            case 6:
                break
            case 7:
                break
            case 8:
                break
            case 9:
                break
            case 10:
                atView11.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(atView11.frame.size.height))
                atContainerView.addSubview(atView11, withAnimation: true)
                labelActivityTitleView11.text = detailsDict["description"]
                imgViewProfilePicView11.setImageWith(URL(string: detailsDict[kParamKeyAvatar]))
            case 11:
                atView11.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(atView11.frame.size.height))
                atContainerView.addSubview(atView11, withAnimation: true)
                labelActivityTitleView11.text = detailsDict["description"]
                imgViewProfilePicView11.setImageWith(URL(string: detailsDict[kParamKeyAvatar]))
            default:
                break
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        headerLabel.font = UIFont()
        labelActivityDescription.sizeToFit()
        labelActivityDescription.font = UIFont.fontGothamRoundedBold(withSize: 11.0)
        labelActivityDescription.textColor = UIColor.stasherText()
        labelActivityTitleView11.sizeToFit()
        labelActivityTitleView11.font = UIFont.fontGothamRoundedBold(withSize: 11.0)
        labelActivityTitleView11.textColor = UIColor.stasherText()
        buttonAcceptATView11.titleLabel?.font = UIFont(size: 11.0)
        buttonCancelATView11.titleLabel?.font = UIFont(size: 11.0)
        imgViewProfilePicView11.clipsToBounds = true
        imgViewProfilePicView11.layer.cornerRadius = 49.0 / 2.0
        imgViewProfilePicView11.layer.borderColor = UIColor.clear.cgColor
        imgViewProfilePicView11.layer.borderWidth = 2.0
        imgViewProfilePicView11.contentMode = .scaleAspectFill
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

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
// MARK: ----- ATView11

    @IBAction func cancel(atView11ButtonPressed sender: Any) {
        requestRelation(withStatus: 0)
    }

    @IBAction func accept(atView11ButtonPressed sender: Any) {
        requestRelation(withStatus: 2)
    }

    func requestRelation(withStatus status: Int) {
        if httpReq != nil {
            httpReq?.delegate = nil
            httpReq = nil
        }
        httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
        if httpReq?.reachable {
            var paramDict = [AnyHashable: Any]()
            paramDict[kParamKeyAction] = kAPIActionAddRelation
            paramDict[kParamKeyChildID] = STUserIdentity.sharedInstance().userId()
            paramDict[kParamKeyParentID] = detailsDict["requestfrom"]
            paramDict["status"] = "\(status)"
            if detailsDict["activityId"] {
                paramDict["activityId"] = detailsDict["activityId"]
            }
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramDict, json: true)
            paramDict = nil
        }
    }
// MARK: - BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            if (conn.userInfo?["params"]["action"] == kAPIActionAddRelation) {
                var responseDict: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
                if responseDict?["success"]["message"] {
                    UIAlertView.show(withTitle: "", message: responseDict?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        if buttonIndex == alertView.cancelButtonIndex {
                            navigationController?.popViewController(animated: true)
                        }
                    })
                }
            }
        }
    }

    func boabHttpReqFailedWithError(_ error: Error?) {
        if error != nil {

        }
    }
}