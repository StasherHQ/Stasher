//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STLogInManager.swift
//  Stasher
//
//  Created by bhushan on 14/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import Foundation
protocol LogInManagerDelegate: NSObjectProtocol {
    func facebookLogInSuccessful(withUserDictionary userInfoDict: [AnyHashable: Any])

    func userLoggedOutSuccessfully()
}
class STLogInManager: NSObject {

    weak var delegate: LogInManagerDelegate? {
        get {
            // TODO: add getter implementation
        }
        set(delegate) {
            self.delegate = delegate
        }
    }

    class func sharedInstance() -> STLogInManager {
        let lockQueue = DispatchQueue(label: "self")
        lockQueue.sync {
            if __instance == nil {
                __instance = STLogInManager()
            }
            return __instance
        }
    }

    func openSession(withAllowLoginUI viewController: UIViewController) -> Bool {
        var login = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["email", "user_birthday", "user_location"], from: viewController, handler: {(_ result: FBSDKLoginManagerLoginResult, _ error: Error?) -> Void in
            if error != nil {
                UIAlertView.show(withTitle: "", message: "Facebook login failed", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                    if buttonIndex == alertView.cancelButtonIndex {

                    }
                })
            }
            else if result.isCancelled() {
                UIAlertView.show(withTitle: "", message: "Facebook login cancelled", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                    if buttonIndex == alertView.cancelButtonIndex {

                    }
                })
            }
            else {
                print("Logged in")
                self.loginSuccessWithFacebook()
            }

        })
        return true
    }

    func updateUserDefaultsInLogInManager(withDictionary logInCredentialsDict: [AnyHashable: Any]) {
        if logInCredentialsDict[kUserDefaultsIsUserLoggedIn] != nil {
            UserDefaults.standard.set(logInCredentialsDict[kUserDefaultsIsUserLoggedIn], forKey: kUserDefaultsIsUserLoggedIn)
        }
        if logInCredentialsDict[kParamKeyEmail] != nil {
            UserDefaults.standard.set(logInCredentialsDict[kParamKeyEmail], forKey: kUserDefaultsLoggedInEmailId)
        }
        if logInCredentialsDict[kParamKeyUsername] != nil {
            UserDefaults.standard.set(logInCredentialsDict[kParamKeyUsername], forKey: kUserDefaultsLoggedInusername)
        }
        if logInCredentialsDict[kParamKeyUserType] != nil {
            if CInt(logInCredentialsDict[kParamKeyUserType]) == 3 {
                UserDefaults.standard.set("3", forKey: kUserDefaultsUserType)
            }
            if CInt(logInCredentialsDict[kParamKeyUserType]) == 4 {
                UserDefaults.standard.set("4", forKey: kUserDefaultsUserType)
            }
        }
        if logInCredentialsDict[kParamKeyFirstname] != nil {
            UserDefaults.standard.set(logInCredentialsDict[kParamKeyFirstname], forKey: kUserDefaultsUserFirstName)
        }
        if logInCredentialsDict[kParamKeyLastname] != nil {
            UserDefaults.standard.set(logInCredentialsDict[kParamKeyLastname], forKey: kUserDefaultsUserLastName)
        }
        if logInCredentialsDict[kParamKeyUserID] != nil {
            UserDefaults.standard.set(logInCredentialsDict[kParamKeyUserID], forKey: kUserDefaultsUserId)
        }
        UserDefaults.standard.synchronize()
    }

    func isUserLoggedIn() -> Bool {
        if UserDefaults.standard.object(forKey: kUserDefaultsIsUserLoggedIn) != nil {
            if UserDefaults.standard.object(forKey: kUserDefaultsIsUserLoggedIn)? == true {
                return true
            }
        }
        return false
    }

    func logOut() {
        UserDefaults.standard.removeObject(forKey: kUserDefaultsIsUserLoggedIn)
        UserDefaults.standard.removeObject(forKey: kUserDefaultsLoggedInEmailId)
        UserDefaults.standard.removeObject(forKey: kUserDefaultsLoggedInusername)
        UserDefaults.standard.removeObject(forKey: kUserDefaultsUserType)
        UserDefaults.standard.removeObject(forKey: kUserDefaultsUserFirstName)
        UserDefaults.standard.removeObject(forKey: kUserDefaultsUserLastName)
        UserDefaults.standard.removeObject(forKey: kUserDefaultsUserId)
        STUserIdentity.sharedInstance().flushUserInfoIdentity()
        var logMeOut = FBSDKLoginManager()
        logMeOut.logOut()
        if delegate?.responds(to: #selector(self.userLoggedOutSuccessfully)) {
            delegate?.userLoggedOutSuccessfully()
        }
    }

// MARK: ----- The Facebook

    func loginSuccessWithFacebook() {
        if FBSDKAccessToken.current() {
            var parameters = [AnyHashable: Any]()
            parameters["fields"] = "id,first_name,last_name,email,gender"
            FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(withCompletionHandler: {(_ connection: FBSDKGraphRequestConnection, _ result: Any, _ error: Error?) -> Void in
                if error == nil {
                    print("fetched user:\(result)")
                    UserDefaults.standard.setValue(result["id"], forKey: "FBUserId")
                    UserDefaults.standard.setValue(result["first_name"], forKey: "FBUserName")
                    UserDefaults.standard.setValue(result["last_name"], forKey: "FBLastName")
                    UserDefaults.standard.setValue(result["email"], forKey: "FBUserEmail")
                    if __instance.self.delegate.responds(to: #selector(self.facebookLogInSuccessfulWithUserDictionary)) {
                        __instance.self.delegate.facebookLogInSuccessful(withUserDictionary: result)
                    }
                }
            })
        }
        else {
            var logMeOut = FBSDKLoginManager()
            logMeOut.logOut()
        }
        //    
        //    [[NSNotificationCenter defaultCenter] postNotificationName:SCSessionStateChangedNotification
        //                                                        object:session];
        //    
        //    if (error) {
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error: %@",
        //                                                                     [STLogInManager FBErrorCodeDescription:error.code]]
        //                                                            message:error.localizedDescription
        //                                                           delegate:nil
        //                                                  cancelButtonTitle:@"OK"
        //                                                  otherButtonTitles:nil];
        //        [alertView show];
        //        [self fbResync];
        //        
        //    }
    }

    func fbResync() {
        //    ACAccountStore *accountStore;
        //    ACAccountType *accountTypeFB;
        //    if ((accountStore = [[ACAccountStore alloc] init]) && (accountTypeFB = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook] ) ){
        //        
        //        NSArray *fbAccounts = [accountStore accountsWithAccountType:accountTypeFB];
        //        id account;
        //        if (fbAccounts && [fbAccounts count] > 0 && (account = [fbAccounts objectAtIndex:0])){
        //            
        //            [accountStore renewCredentialsForAccount:account completion:^(ACAccountCredentialRenewResult renewResult, NSError *error) {
        //                //we don't actually need to inspect renewResult or error.
        //                if (error){
        //                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error: %@",
        //                                                                                 [STLogInManager FBErrorCodeDescription:error.code]]
        //                                                                        message:error.localizedDescription
        //                                                                       delegate:nil
        //                                                              cancelButtonTitle:@"OK"
        //                                                              otherButtonTitles:nil];
        //                    [alertView show];
        //                }
        //            }];
        //        }
        //    }
    }

    func openSessionWithoutAllowLoginUI(_ viewController: UIViewController) -> Bool {
        var login = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["email", "user_birthday", "user_location"], from: viewController, handler: {(_ result: FBSDKLoginManagerLoginResult, _ error: Error?) -> Void in
            if error != nil {
                UIAlertView.show(withTitle: "", message: "Facebook login failed", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                    if buttonIndex == alertView.cancelButtonIndex {

                    }
                })
            }
            else if result.isCancelled() {
                UIAlertView.show(withTitle: "", message: "Facebook login cancelled", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                    if buttonIndex == alertView.cancelButtonIndex {

                    }
                })
            }
            else {
                print("Logged in")
                self.loginSuccessWithFacebook()
            }

        })
        return true
    }
}
import FBSDKCoreKit
import FBSDKLoginKit
let SCSessionStateChangedNotification: String = "com.oabtesting.FacebookLogin:SCSessionStateChangedNotification"
var __instance: STLogInManager? = nil