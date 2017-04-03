//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STEntryViewController.swift
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
import FBSDKCoreKit
class STEntryViewController: UIViewController, LogInManagerDelegate {
    var httpReq: BOABHttpReq?

    @IBOutlet var userTypeContainerView: UIView!
    @IBOutlet var userTypeSwitch: UISwitch!
    @IBOutlet var tutorialsScrollview: UIScrollView!
    @IBOutlet var testScrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var registerWithFacebookButton: UIButton!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var orLabel: UILabel!
    @IBOutlet var overlayView: UIView!
    @IBOutlet var labelFBAreYouParent: UILabel!
    @IBOutlet var buttonFBPopUpOk: UIButton!
    @IBOutlet var buttonFBPopUpCancel: UIButton!
    @IBOutlet var parentCustomSwitchView: UIView!
    @IBOutlet var buttonSwitchYes: UIButton!
    @IBOutlet var buttonSwitchNo: UIButton!
    @IBOutlet var imgViewGreenCustomSwitch: UIImageView!
    @IBOutlet var customSwitchFBParent: UIView!
    @IBOutlet var imgViewFBParentSwitchBG: UIImageView!
    @IBOutlet var imgViewYesCircle: UIImageView!
    @IBOutlet var customSwitchYesButton: UIButton!
    @IBOutlet var customSwitchNoButton: UIButton!


    convenience override init() {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self = storyboard.instantiateViewController(withIdentifier: "STEntryViewController")
        
        //Do initializations here...
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar?.isHidden = true
        userTypeContainerView.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.fromHexString("#3ab1f6")
        if IS_STANDARD_IPHONE_6 {
            registerButton.titleLabel?.font = UIFont(size: 8.0)
        }
        else {
            registerButton.titleLabel?.font = UIFont(size: 10.0)
        }
        if IS_STANDARD_IPHONE_6 {
            registerWithFacebookButton.titleLabel?.font = UIFont(size: 8.0)
        }
        else {
            registerWithFacebookButton.titleLabel?.font = UIFont(size: 10.0)
        }
        if IS_STANDARD_IPHONE_6 {
            logInButton.titleLabel?.font = UIFont(size: 9.0)
        }
        else {
            logInButton.titleLabel?.font = UIFont(size: 11.0)
        }
        orLabel.textColor = UIColor(red: CGFloat(248.0 / 255), green: CGFloat(204.0 / 255), blue: CGFloat(51.0 / 255), alpha: CGFloat(1.0))
        orLabel.font = UIFont.fontGothamRoundedBold(withSize: 9.0)
        automaticallyAdjustsScrollViewInsets = false
        navigationController?.navigationBar?.isHidden = true
        userTypeContainerView.clipsToBounds = true
        userTypeContainerView.layer.cornerRadius = 10.0
        userTypeContainerView.layer.borderColor = UIColor.lightGray.cgColor
        userTypeContainerView.layer.borderWidth = 1.0
        userTypeContainerView.setHidden(animated: true)
        overlayView.setHidden(animated: true)
        labelFBAreYouParent.font = UIFont.fontGothamRoundedMedium(withSize: 9.5)
        buttonFBPopUpOk.titleLabel?.font = UIFont(size: 11.0)
        buttonFBPopUpCancel.titleLabel?.font = UIFont(size: 11.0)
        customSwitchYesButton.titleLabel?.font = UIFont(size: 6.5)
        customSwitchNoButton.titleLabel?.font = UIFont(size: 6.5)
        performSelector(#selector(self.setUpTutorialsScrollView), withObject: nil, afterDelay: 0.1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        var userTypeSwitchFrame: CGRect = userTypeSwitch.frame
        userTypeSwitchFrame.origin.x = view.frame.size.width - parentCustomSwitchView.frame.size.width - 8.0
        userTypeSwitchFrame.size.width = parentCustomSwitchView.frame.size.width
        userTypeSwitchFrame.size.height = parentCustomSwitchView.frame.size.height
        parentCustomSwitchView.frame = userTypeSwitchFrame
        userTypeContainerView.addSubview(parentCustomSwitchView)
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

    @IBAction func custoSwitchFBOverlayButtonPressed(_ sender: Any) {
        if userTypeSwitch.isOn() {
            UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
                self.imgViewYesCircle.center = CGPoint(x: CGFloat(13), y: CGFloat(imgViewYesCircle.center.y))
                self.userTypeSwitch.on = false
                self.userTypeSwitchValueChanged(self.userTypeSwitch)
                self.customSwitchYesButton.setHidden(animated: true)
                self.customSwitchNoButton.setHidden(animated: false)
                self.imgViewYesCircle.image = UIImage(named: "toggle_graycircle")
                self.imgViewFBParentSwitchBG.image = UIImage(named: "toggle_graybg")
            })
        }
        else {
            UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
                self.imgViewYesCircle.center = CGPoint(x: CGFloat(customSwitchFBParent.frame.size.width - 13), y: CGFloat(imgViewYesCircle.center.y))
                self.userTypeSwitch.on = true
                self.userTypeSwitchValueChanged(self.userTypeSwitch)
                self.customSwitchYesButton.setHidden(animated: false)
                self.customSwitchNoButton.setHidden(animated: true)
                self.imgViewYesCircle.image = UIImage(named: "toggle_yellowcircle")
                self.imgViewFBParentSwitchBG.image = UIImage(named: "toggle_greenBG")
            })
        }
    }

    @IBAction func registerButtonPressed(_ sender: Any) {
        var testVC = STRegisterStepOneViewController(nibName: "STRegisterStepOneViewController", bundle: Bundle.main)
        navigationController?.pushViewController(testVC, animated: true)
    }

    @IBAction func log(inButtonPressed sender: Any) {
    }

    @IBAction func logIn(withFacebookButtonPressed sender: Any) {
        userTypeContainerView.setHidden(animated: false)
        overlayView.setHidden(animated: false)
        STUserIdentity.sharedInstance().userIdentity = PARENTUSER
    }

    @IBAction func userTypeSwitchValueChanged(_ sender: Any) {
        var thisSwitch: UISwitch? = (sender as? UISwitch)
        if thisSwitch != nil {
            if thisSwitch?.isOn() {
                STUserIdentity.sharedInstance().userIdentity = PARENTUSER
            }
            else {
                STUserIdentity.sharedInstance().userIdentity = CHILDUSER
            }
        }
    }

    @IBAction func userTypeContainerDoneButtonPressed(_ sender: Any) {
        userTypeContainerView.setHidden(animated: true)
        overlayView.setHidden(animated: true)
        STLogInManager.sharedInstance().delegate = self
        STLogInManager.sharedInstance().openSession(withAllowLoginUI: self)
    }

    @IBAction func userTypeContainerCancelButtonPressed(_ sender: Any) {
        userTypeContainerView.isHidden = true
        overlayView.setHidden(animated: true)
    }

    @IBAction func customSwitchYesButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
            self.imgViewGreenCustomSwitch.center = buttonSwitchYes.center
            self.userTypeSwitch.on = true
            self.userTypeSwitchValueChanged(self.userTypeSwitch)
        })
    }

    @IBAction func customSwitchNoButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: kAddSubviewAnimationDuration, animations: {() -> Void in
            self.imgViewGreenCustomSwitch.center = buttonSwitchNo.center
            self.userTypeSwitch.on = false
            self.userTypeSwitchValueChanged(self.userTypeSwitch)
        })
    }
// MARK: ----- Scrollview Delegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var currentIndex = Int(tutorialsScrollview.contentOffset.x / tutorialsScrollview.frame.size.width)
        pageControl.currentPage = currentIndex
    }
// MARK: ----- custom methods

    func launchUserBaseTabsScreen() {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var baseTabBarController: STBaseTabBarController? = storyboard.instantiateViewController(withIdentifier: "STBaseTabBarController")
        navigationController?.pushViewController(baseTabBarController, animated: true)
    }

    func setUpTutorialsScrollView() {
            //[self.pageControl setHidden:YES];
        var tutViewFrame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(tutorialsScrollview.frame.size.height))
        for c in 1..<5 {
            var tutView = UIView(frame: tutViewFrame)
            tutView.backgroundColor = UIColor.clear
            var label = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(180.0), height: CGFloat(40.0)))
            label.textColor = UIColor.white
            label.font = UIFont.fontGothamRoundedBold(withSize: 12.0)
            label.backgroundColor = UIColor.clear
            label.numberOfLines = 0
            label.textAlignment = .center
            var tutImageView: UIImageView?
            if isiPhone4s {
                tutImageView = UIImageView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(175), height: CGFloat(245)))
                tutImageView?.frame = CGRect(x: CGFloat(tutViewFrame.size.width / 2 - tutImageView?.frame?.size?.width / 2), y: CGFloat(20.0), width: CGFloat(tutImageView?.frame?.size?.width), height: CGFloat(tutImageView?.frame?.size?.height))
                label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(200), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
            }
            else {
                tutImageView = UIImageView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(151), height: CGFloat(196)))
                if IS_STANDARD_IPHONE_6 {
                    tutImageView?.frame = CGRect(x: CGFloat(tutViewFrame.size.width / 2 - tutImageView?.frame?.size?.width / 2), y: CGFloat(62), width: CGFloat(tutImageView?.frame?.size?.width), height: CGFloat(tutImageView?.frame?.size?.height))
                }
                else if IS_STANDARD_IPHONE_6_PLUS {
                    tutImageView?.frame = CGRect(x: CGFloat(tutViewFrame.size.width / 2 - tutImageView?.frame?.size?.width / 2), y: CGFloat(86), width: CGFloat(tutImageView?.frame?.size?.width), height: CGFloat(tutImageView?.frame?.size?.height))
                }
                else {
                    tutImageView?.frame = CGRect(x: CGFloat(tutViewFrame.size.width / 2 - tutImageView?.frame?.size?.width / 2), y: CGFloat(40), width: CGFloat(tutImageView?.frame?.size?.width), height: CGFloat(tutImageView?.frame?.size?.height))
                }
            }
            switch c {
                case 1:
                    label.text = "\("Ditch The Piggy Bank. Upgrade to Stasher.")"
                    if IS_STANDARD_IPHONE_6 {
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(tutView.frame.size.height - 2.5 * label.frame.size.height), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }
                    else if IS_STANDARD_IPHONE_6_PLUS {
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(tutView.frame.size.height - 3 * label.frame.size.height), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }
                    else {
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(tutView.frame.size.height - 1.5 * label.frame.size.height), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }

                case 2:
                    label.text = "\("Secret Agents complete missions to earn real cash from their commanders!")"
                    if IS_STANDARD_IPHONE_6 {
                        label.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(300.0), height: CGFloat(80.0))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(tutView.frame.size.height - 1.5 * label.frame.size.height), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }
                    else if IS_STANDARD_IPHONE_6_PLUS {
                        label.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(250.0), height: CGFloat(100.0))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(tutView.frame.size.height - 1.5 * label.frame.size.height), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }
                    else {
                        label.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(250.0), height: CGFloat(80.0))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(tutView.frame.size.height - 1.05 * label.frame.size.height), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }

                case 3:
                    label.text = "\("Parents transfer money securely to kids saving account using Knox Payments 128-bit encryption technology")"
                    if IS_STANDARD_IPHONE_6 {
                        label.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(330.0), height: CGFloat(80.0))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(tutView.frame.size.height - 1.5 * label.frame.size.height), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }
                    else if IS_STANDARD_IPHONE_6_PLUS {
                        label.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(280.0), height: CGFloat(100.0))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(tutView.frame.size.height - 1.5 * label.frame.size.height), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }
                    else {
                        label.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(250.0), height: CGFloat(80.0))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(tutView.frame.size.height - 1.05 * label.frame.size.height), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }

                case 4:
                    label.text = "\("Track savings from your mobile device on-the-go")"
                    if IS_STANDARD_IPHONE_6 {
                        label.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(300.0), height: CGFloat(80.0))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(tutView.frame.size.height - 1.5 * label.frame.size.height), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }
                    else if IS_STANDARD_IPHONE_6_PLUS {
                        label.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(250.0), height: CGFloat(100.0))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(tutView.frame.size.height - 1.5 * label.frame.size.height), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }
                    else {
                        label.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(250.0), height: CGFloat(80.0))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(tutView.frame.size.height - 1.05 * label.frame.size.height), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }

                default:
                    break
            }

                /*
                        //[tutImageView setImage:[UIImage imageNamed:@"Bear1"]];
                        NSArray *imageNames = @[@"Bear1.png", @"Bear2.png", @"Bear3.png", @"Bear4.png",
                                                @"Bear5.png", @"Bear6.png", @"Bear7.png", @"Bear8.png",
                                                @"Bear9.png", @"Bear10.png"];
                        
                        NSMutableArray *images = [[NSMutableArray alloc] init];
                        for (int i = 0; i < imageNames.count; i++) {
                            [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
                        }
                        tutImageView.animationImages = images;
                        tutImageView.animationDuration = kBearAnimationDuration;
                         */
            var tutImgRect: CGRect? = tutImageView?.frame
            switch c {
                case 1:
                    tutImgRect = CGRect(x: CGFloat(tutImageView?.frame?.origin?.x), y: CGFloat(tutImageView?.frame?.origin?.y), width: CGFloat(158), height: CGFloat(225))
                    if isiPhone4s {

                    }
                    else {
                        if IS_STANDARD_IPHONE_6 {

                        }
                        else if IS_STANDARD_IPHONE_6_PLUS {

                        }
                        else {
                            tutImgRect = CGRect(x: CGFloat(tutImageView?.frame?.origin?.x), y: CGFloat(tutImageView?.frame?.origin?.y), width: CGFloat(130), height: CGFloat(200))
                        }
                    }
                    tutImageView?.image = UIImage(named: "tut_page01")
                case 2:
                    tutImgRect = CGRect(x: CGFloat(tutImageView?.frame?.origin?.x), y: CGFloat(tutImageView?.frame?.origin?.y), width: CGFloat(121), height: CGFloat(230))
                    tutImageView?.image = UIImage(named: "tut_page02")
                    if isiPhone4s {

                    }
                    else {
                        if IS_STANDARD_IPHONE_6 {

                        }
                        else if IS_STANDARD_IPHONE_6_PLUS {

                        }
                        else {
                            tutImgRect = CGRect(x: CGFloat(tutImageView?.frame?.origin?.x), y: CGFloat(tutImageView?.frame?.origin?.y), width: CGFloat(100), height: CGFloat(200))
                        }
                    }
                case 3:
                    tutImgRect = CGRect(x: CGFloat(tutImageView?.frame?.origin?.x), y: CGFloat(tutImageView?.frame?.origin?.y), width: CGFloat(256), height: CGFloat(214))
                    tutImageView?.image = UIImage(named: "tut_page03")
                    if isiPhone4s {

                    }
                    else {
                        if IS_STANDARD_IPHONE_6 {

                        }
                        else if IS_STANDARD_IPHONE_6_PLUS {

                        }
                        else {
                            tutImgRect = CGRect(x: CGFloat(tutImageView?.frame?.origin?.x), y: CGFloat(tutImageView?.frame?.origin?.y), width: CGFloat(230), height: CGFloat(190))
                        }
                    }
                case 4:
                    tutImgRect = CGRect(x: CGFloat(tutImageView?.frame?.origin?.x), y: CGFloat(tutImageView?.frame?.origin?.y), width: CGFloat(247), height: CGFloat(207))
                    tutImageView?.image = UIImage(named: "tut_page04")
                    if isiPhone4s {

                    }
                    else {
                        if IS_STANDARD_IPHONE_6 {

                        }
                        else if IS_STANDARD_IPHONE_6_PLUS {

                        }
                        else {
                            tutImgRect = CGRect(x: CGFloat(tutImageView?.frame?.origin?.x), y: CGFloat(tutImageView?.frame?.origin?.y), width: CGFloat(220), height: CGFloat(180))
                        }
                    }
                default:
                    break
            }

            tutImageView?.frame = tutImgRect
            tutView.addSubview(tutImageView!)
                //[tutImageView startAnimating];
            var stasherLogotextImgViewFrame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(175), height: CGFloat(30))
            var stasherLogoImgView = UIImageView(frame: stasherLogotextImgViewFrame)
            stasherLogoImgView.image = UIImage(named: "stasher_logo_text")
            stasherLogoImgView.center = CGPoint(x: CGFloat(view.center.x), y: CGFloat(tutImageView?.frame?.origin?.y - 20))
            tutView.addSubview(stasherLogoImgView)
            tutView.addSubview(label)
            tutorialsScrollview.addSubview(tutView)
            tutViewFrame.origin.x += tutView.frame.size.width
            label.center = CGPoint(x: CGFloat(tutorialsScrollview.center.x), y: CGFloat(label.center.y))
            tutImageView?.center = CGPoint(x: CGFloat(tutorialsScrollview.center.x), y: CGFloat(tutImageView?.center?.y))
        }
        var contentSize: CGSize = tutorialsScrollview.frame.size
        contentSize.width = tutViewFrame.origin.x
        contentSize.height = tutorialsScrollview.frame.size.height
        tutorialsScrollview.contentSize = contentSize
        pageControl.numberOfPages = 4
    }

    func launchStepThreeRegistration() {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var registerStepthreeVC: STRegisterStepThreeViewController? = storyboard.instantiateViewController(withIdentifier: "RegisterStepThreeViewController")
        navigationController?.pushViewController(registerStepthreeVC, animated: true)
    }
// MARK: ----- LogInManagerDelegate

    func facebookLogInSuccessful(withUserDictionary userInfoDict: [AnyHashable: Any]) {
        print("facebooklogIn Dict \(userInfoDict)")
        if userInfoDict != nil {
            var localUserInfoDict = [AnyHashable: Any]()
            localUserInfoDict[kParamKeyFirstname] = userInfoDict["first_name"]
            localUserInfoDict[kParamKeyLastname] = userInfoDict["last_name"]
            localUserInfoDict[kParamKeyGender] = userInfoDict["gender"]
            localUserInfoDict[kParamKeyEmail] = userInfoDict["email"]
                //[localUserInfoDict setObject:[[userInfoDict objectForKey:@"location"] objectForKey:@"name"] forKey:kParamKeyCountry];
            var dateFormat = DateFormatter()
            dateFormat.dateFormat = "MM/dd/yyyy"
            var theDate: Date? = dateFormat.date(fromString: (userInfoDict["birthday"] as? Date))
            var dateFormat2 = DateFormatter()
            dateFormat2.dateFormat = "yyyy-MM-dd"
            if dateFormat2.string(from: theDate) {
                localUserInfoDict[kParamKeyDateOfBirth] = dateFormat2.string(from: theDate)
            }
            if Data(contentsOf: URL(string: "http://graph.facebook.com/\(userInfoDict["id"])/picture")).base64EncodedString(withOptions: 0) != nil {
                localUserInfoDict[kParamKeyAvatar] = Data(contentsOf: URL(string: "http://graph.facebook.com/\(userInfoDict["id"])/picture")).base64EncodedString(withOptions: 0)
            }
            if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
                localUserInfoDict[kParamKeyIsParent] = "\("yes")"
            }
            if STUserIdentity.sharedInstance().userIdentity() == CHILDUSER {
                localUserInfoDict[kParamKeyIsParent] = "\("no")"
            }
            if httpReq != nil {
                httpReq?.delegate = nil
                httpReq = nil
            }
            httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
            localUserInfoDict[kParamKeyAction] = kAPIActionFaceBookRegister
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: localUserInfoDict, json: true)
        }
    }
// MARK: ----- BOABHttpReq Delegate

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        if resonseData {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDictionary != nil {
                if responseDictionary?["success"] != nil {
                    if responseDictionary?["success"] {
                        if responseDictionary?["usedetails"] && (responseDictionary?["usedetails"] is [AnyHashable: Any]) {
                            STUserIdentity.sharedInstance().userInformationDictionary = responseDictionary?["usedetails"]
                            var logInInfoDictionary: [AnyHashable: Any]? = (responseDictionary?["usedetails"] as? [AnyHashable: Any])?
                            logInInfoDictionary?[kUserDefaultsIsUserLoggedIn] = Int(1)
                            STLogInManager.sharedInstance().updateUserDefaultsInLogInManager(withDictionary: logInInfoDictionary)
                        }
                        UIAlertView.show(withTitle: "", message: responseDictionary?["success"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                            if buttonIndex == alertView.cancelButtonIndex {
                                if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
                                    self.launchStepThreeRegistration()
                                }
                                else {
                                    var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    var baseTabBarController: STBaseTabBarController? = storyboard.instantiateViewController(withIdentifier: "STBaseTabBarController")
                                    navigationController?.pushViewController(baseTabBarController, animated: true)
                                }
                            }
                        })
                    }
                }
                else if responseDictionary?["error"] != nil {
                    if responseDictionary?["error"] {
                        UIAlertView.show(withTitle: "", message: responseDictionary?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                            if buttonIndex == alertView.cancelButtonIndex {
                                navigationController?.popViewController(animated: true)
                            }
                        })
                    }
                }
                else if responseDictionary?["usedetails"] && (responseDictionary?["usedetails"] is [AnyHashable: Any]) {
                    STUserIdentity.sharedInstance().userInformationDictionary = responseDictionary?["usedetails"]
                    var logInInfoDictionary: [AnyHashable: Any]? = (responseDictionary?["usedetails"] as? [AnyHashable: Any])?
                    logInInfoDictionary?[kUserDefaultsIsUserLoggedIn] = Int(1)
                    STLogInManager.sharedInstance().updateUserDefaultsInLogInManager(withDictionary: logInInfoDictionary)
                    if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
                        launchStepThreeRegistration()
                    }
                    else {
                        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        var baseTabBarController: STBaseTabBarController? = storyboard.instantiateViewController(withIdentifier: "STBaseTabBarController")
                        navigationController?.pushViewController(baseTabBarController, animated: true)
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
import FBSDKCoreKit