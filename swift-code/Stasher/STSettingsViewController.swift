//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STSettingsViewController.swift
//  Stasher
//
//  Created by Bhushan on 16/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
import MessageUI
class STSettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EditProfileDelegate, MFMailComposeViewControllerDelegate {
    var termsVC: STTermsAndConditionsViewController?
    var socialSettingsVC: STSocialNetworkSettingsViewController?
    var notificationSettingsVC: STNotificationSettingsViewController?

    @IBOutlet var headerlabel: UILabel!
    @IBOutlet var settingsTableView: UITableView!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        headerlabel.font = UIFont()
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

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
    }

    func build() -> String {
        return Bundle.main.object(forInfoDictionaryKey: (kCFBundleVersionKey as? String))!
    }

    func versionBuild() -> String {
        var version: String = appVersion()
        var build: String = self.build()
        var versionBuild: String = "Version \(version)"
        if !(version == build) {
            versionBuild = "\(versionBuild)(\(build))"
        }
        return versionBuild
    }
// MARK: ----- Table Settings List

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var myLabel = UILabel()
        myLabel.frame = CGRect(x: CGFloat(12), y: CGFloat(3), width: CGFloat(view.frame.size.width), height: CGFloat(35.0))
        myLabel.font = UIFont(size: 13.0)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        myLabel.textColor = UIColor.stasherText()
        var headerView = UIView()
        headerView.backgroundColor = UIColor.groupTableViewBackground()
        headerView.addSubview(myLabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        var sectionTitle: String = ""
        switch section {
            case 0:
                sectionTitle = "ACCOUNT & SECURITY"
            case 1:
                sectionTitle = "INFORMATION & SUPPORT"
            case 2:
                sectionTitle = ""
            case 3:
                sectionTitle = ""
            default:
                break
        }

        return sectionTitle
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        switch section {
            case 0:
                rows = 4
            case 1:
                rows = 5
            case 2:
                rows = 1
            case 3:
                rows = 0
            default:
                break
        }

        return rows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var simpleTableIdentifier: String = "SimpleTableCell"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: simpleTableIdentifier)
        }
        cell?.textLabel?.textColor = UIColor.stasherText()
        cell?.textLabel?.font = UIFont(size: 11.0)
        switch indexPath.section {
            case 0:
                switch indexPath.row {
                    case 0:
                        cell?.textLabel?.text = "Edit Profile"
                    case 1:
                        cell?.textLabel?.text = "Alerts & Notification"
                    case 2:
                        cell?.textLabel?.text = "Social Networks"
                    case 3:
                        cell?.textLabel?.text = "Payments"
                    default:
                        break
                }

            case 1:
                switch indexPath.row {
                    case 0:
                        cell?.textLabel?.text = "Help Center"
                    case 1:
                        cell?.textLabel?.text = "Send Feedback"
                    case 2:
                        cell?.textLabel?.text = "User Agreement"
                    case 3:
                        cell?.textLabel?.text = "Privacy Policy"
                    case 4:
                        cell?.textLabel?.text = "Rate Stasher"
                    default:
                        break
                }

            case 2:
                switch indexPath.row {
                    case 0:
                        cell?.textLabel?.text = "Sign Out"
                    default:
                        break
                }

            case 3:
                break
            default:
                break
        }

        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.section {
            case 0:
                switch indexPath.row {
                    case 0:
                        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        var editProfileVC: STEditProfileViewController? = storyboard.instantiateViewController(withIdentifier: "STEditProfileViewController")
                        editProfileVC?.delegate = self
                        navigationController?.pushViewController(editProfileVC, animated: true)
                    case 1:
                        if notificationSettingsVC != nil {
                            notificationSettingsVC = nil
                        }
                        notificationSettingsVC = STNotificationSettingsViewController(nibName: "STNotificationSettingsViewController", bundle: nil)
                        navigationController?.pushViewController(notificationSettingsVC, animated: true)
                    case 2:
                        if (UserDefaults.standard.object(forKey: "IsFaceBookLogIn") == "YES") {
                            if socialSettingsVC != nil {
                                socialSettingsVC = nil
                            }
                            socialSettingsVC = STSocialNetworkSettingsViewController(nibName: "STSocialNetworkSettingsViewController", bundle: nil)
                            navigationController?.pushViewController(socialSettingsVC, animated: true)
                        }
                        else {
                            UIAlertView.show(withTitle: "", message: "You are not using any Facebook Login.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                            })
                        }
                    case 3:
                        UIAlertView.show(withTitle: "", message: "Payments section will be added once Payment gateway is available.", cancelButtonTitle: "OK", otherButtonTitles: nil, tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                        })
                    case 4:
                        break
                    case 5:
                        break
                    case 6:
                        break
                    case 7:
                        break
                    default:
                        break
                }

            case 1:
                switch indexPath.row {
                    case 0:
                        if MFMailComposeViewController.canSendMail() {
                            var composeViewController = MFMailComposeViewController(nibName: nil, bundle: nil)
                            composeViewController.mailComposeDelegate = self
                            composeViewController.setToRecipients(["help@stasherapp.com"])
                            composeViewController.setSubject("Help")
                            present(composeViewController, animated: true, completion: { _ in })
                        }
                    case 1:
                        if MFMailComposeViewController.canSendMail() {
                            var composeViewController = MFMailComposeViewController(nibName: nil, bundle: nil)
                            composeViewController.mailComposeDelegate = self
                            composeViewController.setToRecipients(["bianca@stasherapp.com"])
                            composeViewController.setSubject("Feedback")
                            present(composeViewController, animated: true, completion: { _ in })
                        }
                    case 2:
                        if termsVC != nil {
                            termsVC = nil
                        }
                        termsVC = STTermsAndConditionsViewController(nibName: "STTermsAndConditionsViewController", bundle: nil, andIsThroughSettings: true, andIsPrivacyPolicy: false, orIsUserAgreement: true)
                        navigationController?.pushViewController(termsVC, animated: true)
                    case 3:
                        if termsVC != nil {
                            termsVC = nil
                        }
                        termsVC = STTermsAndConditionsViewController(nibName: "STTermsAndConditionsViewController", bundle: nil, andIsThroughSettings: true, andIsPrivacyPolicy: true, orIsUserAgreement: false)
                        navigationController?.pushViewController(termsVC, animated: true)
                    case 4:
                        var iTunesLink: String = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=972598883&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"
                        UIApplication.shared.openURL(URL(string: iTunesLink))
                    default:
                        break
                }

            case 2:
                switch indexPath.row {
                    case 0:
                        UIAlertView.show(withTitle: "", message: "Do you want to Log Out of Stasher?", cancelButtonTitle: "Cancel", otherButtonTitles: ["Log Out"], tapBlock: {(_ alertView: UIAlertView, _ buttonIndex: Int) -> Void in
                            if buttonIndex != alertView.cancelButtonIndex {
                                STLogInManager.sharedInstance().logOut()
                            }
                        })
                    default:
                        break
                }

            case 3:
                switch indexPath.row {
                    case 0:
                        break
                    default:
                        break
                }

            case 4:
                break
            default:
                break
        }

    }
// MARK: ----- EditProfile Delegate

    func profileSuccessfullyEdited() {
        if navigationController?.viewControllers?.count > 2 {
            if (navigationController?.viewControllers?[navigationController?.viewControllers?.count - 3]? is STAccountViewController) {
                var vc: STAccountViewController? = (navigationController?.viewControllers?[navigationController?.viewControllers?.count - 3] as? STAccountViewController)
                vc?.requestUserDetails()
            }
        }
    }

    func passwordChangedLogInAgain() {
    }
// MARK: ----- MailComposer Delegate

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        //Add an alert in case of failure
        controller.dismiss(animated: true, completion: { _ in })
    }
}