//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  AppDelegate.swift
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var returnDict = [AnyHashable: Any]()

    var returnDict = [AnyHashable: Any]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            // register for notification..
        var applicatio = UIApplication.shared
        if UserDefaults.standard.object(forKey: "NotificationSettingEnabled") {
            if (UserDefaults.standard.object(forKey: "NotificationSettingEnabled") == "YES") {
                if applicatio.responds(to: #selector(self.registerUserNotificationSettings)) {
                    var settings = UIUserNotificationSettings(types: ([.badge, .sound, .alert]), categories: nil)
                    application.registerUserNotificationSettings(settings)
                    //[[UIApplication sharedApplication] registerForRemoteNotifications];
                }
            }
        }
        else {
            if applicatio.responds(to: #selector(self.registerUserNotificationSettings)) {
                var settings = UIUserNotificationSettings(types: ([.badge, .sound, .alert]), categories: nil)
                application.registerUserNotificationSettings(settings)
                //[[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        deviceTokenStr = "\(deviceToken)".trimmingCharacters(in: CharacterSet(charactersInString: "<>")).replacingOccurrences(of: " ", with: "")
        print("device token \(deviceTokenStr)")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error?) {
        print("Failed to get token, error: \(error)")
    }

    func application(_ application: UIApplication, openURL url: URL, sourceApplication: String, annotation: Any) -> Bool {
        if STLogInManager.sharedInstance().isUserLoggedIn() {
            //need to get the response from the payment when it is done and log it.
            print("\(url.absoluteString)")
            //parse the return URL to isolate pay_id and complete status
            returnDict = parseUrlString(url.absoluteString)
            //send notification to resign webview
            NotificationCenter.default.postNotification(Notification(name: kNotificationIdentifier_BankTransactionFinished, object: nil, userInfo: returnDict))
            /*
                    //get pay_id and completed status from dictionary
                    NSString *payID = [returnDict valueForKey:@"pay_id"];
                    NSString *completed = [returnDict valueForKey:@"completed"];
                    
                    //log pay_id and status
                    //NSLog(@"pay id or transaction_id= %@", payID );
                    //NSLog(@"status = %@",completed);
                    
                    [UIAlertView showWithTitle:@""
                                       message:completed
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          if (buttonIndex == [alertView cancelButtonIndex]) {
                                              
                                          }
                                      }];
                    [UIAlertView showWithTitle:@"Important Development Alert"
                                       message:[NSString stringWithFormat:@"Note this %@ transaction_id for development",payID]
                             cancelButtonTitle:@"Note then Close!"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          if (buttonIndex == [alertView cancelButtonIndex]) {
                                              NSLog(@"pay_id %@",payID);
                                          }
                                      }];
                     */
        }
        else {
            var handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
            // Add any custom logic here.
            return handled
        }
        return true
    }

    func parseUrlString(_ urlString: String) -> [AnyHashable: Any] {
            //get last path and log (return URL)
        var lastPath = urlString.lastPathComponent
        print("last path = \(lastPath)")
        //remove question mark from path
        lastPath = (lastPath as NSString).replacingCharacters(in: NSRange(location: 0, length: 0), with: "")
            //create new dictionary to store parsed peices of
        var newDict = [AnyHashable: Any]()
            //create array by separating path components
        var pathComponents: [Any] = lastPath.components(separatedBy: "&")
        //separeate key and value pars by parsing at = sign
        for keyValuePair: String in pathComponents {
            var pairComponents: [Any] = keyValuePair.components(separatedBy: "=")
            var key: String? = (pairComponents[0] as? String)
            var value: String? = (pairComponents[1] as? String)
            //add to dictionary *newDict
            newDict[key] = value
        }
        //return dictionary with pay_id and status
        return newDict
    }
}
import FBSDKCoreKit