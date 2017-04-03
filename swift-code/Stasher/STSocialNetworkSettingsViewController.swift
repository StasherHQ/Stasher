//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STSocialNetworkSettingsViewController.swift
//  Stasher
//
//  Created by Bhushan on 30/04/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
class STSocialNetworkSettingsViewController: UIViewController {

    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var removeFbButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        headerLabel.font = UIFont()
        removeFbButton.titleLabel?.font = UIFont(size: 11.0)
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

    @IBAction func removeFacebookButtonPressed(_ sender: Any) {
        STLogInManager.sharedInstance().logOut()
    }
}