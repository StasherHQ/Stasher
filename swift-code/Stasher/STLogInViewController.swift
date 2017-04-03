//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STLogInViewController.swift
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STLogInViewController: UIViewController, ForgotPasswordDelegate, STSharedCustomsDelegate, LogInManagerDelegate {
    var httpReq: BOABHttpReq?
    var forgotPasswordVC: STForgotPasswordViewController?

    @IBOutlet var logInButton: UIButton!
    @IBOutlet var forgotPasswordButton: UIButton!
    @IBOutlet var txtFieldUsernameId: UITextField!
    @IBOutlet var txtFieldPassword: UITextField!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var logInViaFacebooButtonk: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        headerLabel.font = UIFont.fontGothamRoundedMedium(withSize: 16.0)
        txtFieldPassword.font = UIFont()
        txtFieldPassword.textColor = UIColor.stasherText()
        txtFieldUsernameId.font = UIFont()
        txtFieldUsernameId.textColor = UIColor.stasherText()
        txtFieldPassword.autocorrectionType = .no
        txtFieldUsernameId.autocorrectionType = .no
        txtFieldPassword.attributedPlaceholder = NSAttributedString(string: txtFieldPassword.placeholder, attributes: [NSForegroundColorAttributeName: UIColor.stasherTextFieldPlaceHolder(), NSFontAttributeName: UIFont()])
        txtFieldUsernameId.attributedPlaceholder = NSAttributedString(string: txtFieldUsernameId.placeholder, attributes: [NSForegroundColorAttributeName: UIColor.stasherTextFieldPlaceHolder(), NSFontAttributeName: UIFont()])
        logInButton.titleLabel?.font = UIFont(size: 11.0)
        forgotPasswordButton.titleLabel?.font = UIFont(size: 11.0)
        forgotPasswordButton.titleLabel?.textColor = UIColor.stasherText()
        if IS_STANDARD_IPHONE_6 {
            logInViaFacebooButtonk.titleLabel?.font = UIFont(size: 8.0)
        }
        else {
            logInViaFacebooButtonk.titleLabel?.font = UIFont(size: 10.0)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: self).addRightSwipeGestureRecognizerToMe()
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

    @IBAction func log(inButtonPressed sender: Any) {
        view.userInteractionEnabled = false
        txtFieldPassword.resignFirstResponder()
        performSelector(#selector(self.logIn), withObject: self, afterDelay: 0.05)
    }

    func logIn() {
        if txtFieldPassword.text.validateNotEmpty() && txtFieldUsernameId.text.validateNotEmpty() {
            if txtFieldUsernameId.text.validateEmail() || txtFieldUsernameId.text.validateNotEmpty() {
                httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
                var paramsDict = [AnyHashable: Any]()
                paramsDict[kParamKeyUsername] = txtFieldUsernameId.text
                paramsDict[kParamKeyPassword] = txtFieldPassword.text
                paramsDict[kParamKeyAction] = kAPIActionLogin
                httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: paramsDict, json: true)
            }
            else {
                UIAlertView.show(withTitle: "", message: "Enter a valid E-mail address.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                    if buttonIndex == alertView.cancelButtonIndex {

                    }
                })
            }
        }
        else {
            UIAlertView.show(withTitle: "", message: "All fields are mandatory.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                if buttonIndex == alertView.cancelButtonIndex {

                }
            })
        }
    }

    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        forgotPasswordVC = STForgotPasswordViewController(nibName: "STForgotPasswordViewController", bundle: Bundle.main)
        forgotPasswordVC?.delegate = self
        forgotPasswordVC?.view?.frame = view.frame
        view.addSubview(forgotPasswordVC?.view, withAnimation: true)
    }

    @IBAction func logIn(viaFacebookButtonPressed sender: Any) {
        STLogInManager.sharedInstance().delegate = self
        STLogInManager.sharedInstance().openSession(withAllowLoginUI: self)
    }

    func sendPaswordToEmailButtonPressed() {
        if forgotPasswordVC != nil {
            forgotPasswordVC?.view?.remove(fromSuperviewwithAnimation: true)
        }
    }

    func forgetpasswordCanceled() {
        if forgotPasswordVC != nil {
            forgotPasswordVC?.view?.remove(fromSuperviewwithAnimation: true)
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func rightGestureHandle() {
        navigationController?.popViewController(animated: true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: nil)
    }
// MARK: ----- Custom Methods

    func launchUserBaseTabsScreen() {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var baseTabBarController: STBaseTabBarController? = storyboard.instantiateViewController(withIdentifier: "STBaseTabBarController")
        navigationController?.pushViewController(baseTabBarController, animated: true)
    }
// MARK: ----- Textfield Methods

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFieldUsernameId {
            txtFieldPassword.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var shouldChange: Bool = true
        if textField == txtFieldPassword {
            if string.validateAlphanumeric() {
                shouldChange = true
            }
            else {
                shouldChange = false
            }
        }
        return shouldChange
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
            if httpReq != nil {
                httpReq?.delegate = nil
                httpReq = nil
            }
            httpReq = BOABHttpReq.initBoabReq(withDelegate: self, shouldShowActivityIndicatorView: true)
            localUserInfoDict[kParamKeyAction] = kAPIActionFacebookLogIn
            httpReq?.sendAsyncPostRequest(STASHER_BASE_URL, params: localUserInfoDict, json: true)
        }
    }
// MARK: - BOABHttpReqDelegates

    func boabHttpReqFinished(withResponse resonseData: Data, andConnection conn: BOABURLConnection) {
        view.userInteractionEnabled = true
        var actionName: String? = ((conn.userInfo?[KParamsKey] as? String)?[kParamKeyAction] as? String)
        if (actionName == kAPIActionFacebookLogIn) {
            UserDefaults.standard.set("YES", forKey: "IsFaceBookLogIn")
        }
        else {
            UserDefaults.standard.set("NO", forKey: "IsFaceBookLogIn")
        }
        UserDefaults.standard.synchronize()
        if resonseData {
            var responseDictionary: [AnyHashable: Any]? = try? JSONSerialization.jsonObject(withData: resonseData, options: kNilOptions)
            if responseDictionary != nil {
                if responseDictionary?["usedetails"] && (responseDictionary?["usedetails"] is [AnyHashable: Any]) {
                    STUserIdentity.sharedInstance().userInformationDictionary = responseDictionary?["usedetails"]
                    var logInInfoDictionary: [AnyHashable: Any]? = (responseDictionary?["usedetails"] as? [AnyHashable: Any])?
                    logInInfoDictionary?[kUserDefaultsIsUserLoggedIn] = Int(1)
                    STLogInManager.sharedInstance().updateUserDefaultsInLogInManager(withDictionary: logInInfoDictionary)
                    launchUserBaseTabsScreen()
                }
                else if responseDictionary?["error"] {
                    UIAlertView.show(withTitle: "", message: responseDictionary?["error"]["message"], cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        if buttonIndex == alertView.cancelButtonIndex {

                        }
                    })
                }
            }
        }
    }

    func boabHttpReqFailedWithError(_ error: Error?) {
        view.userInteractionEnabled = true
        if error != nil {

        }
    }
}