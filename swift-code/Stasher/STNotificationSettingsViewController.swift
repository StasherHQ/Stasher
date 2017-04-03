//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STNotificationSettingsViewController.swift
//  Stasher
//
//  Created by Bhushan on 30/04/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
class STNotificationSettingsViewController: UIViewController {

    @IBOutlet var notificationSwitch: UISwitch!
    @IBOutlet var labelSettingHeading: UILabel!
    @IBOutlet var headerLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        headerLabel.font = UIFont()
        labelSettingHeading.font = UIFont(size: 11.0)
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

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func switchValuChanged(_ sender: Any) {
        var notificationSwitch: UISwitch? = (sender as? UISwitch)
        if notificationSwitch?.isOn() {
            UIApplication.shared.registerForRemoteNotifications()
            UserDefaults.standard.set("YES", forKey: "NotificationSettingEnabled")
        }
        else {
            UIApplication.shared.unregisterForRemoteNotifications()
            UserDefaults.standard.set("NO", forKey: "NotificationSettingEnabled")
        }
        UserDefaults.standard.synchronize()
    }
}