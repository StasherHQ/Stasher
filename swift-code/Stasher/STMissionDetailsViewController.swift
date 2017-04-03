//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STMissionDetailsViewController.swift
//  Stasher
//
//  Created by Bhushan on 24/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
class STMissionDetailsViewController: UIViewController {

    var missionDetailsDict = [AnyHashable: Any]()
    @IBOutlet var labelChallengerNameTitle: UILabel!
    @IBOutlet var labelChallengerName: UILabel!
    @IBOutlet var labelMissionDescriptionTitle: UILabel!
    @IBOutlet var txtViewMissionDescription: UITextView!
    @IBOutlet var labelMissionNameTitle: UILabel!
    @IBOutlet var labelMissionName: UILabel!
    @IBOutlet var imgViewTxtBG: UIImageView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var imgViewProfilePic: UIImageView!

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, detailsDict dict: [AnyHashable: Any]) {
        super.init(nibName: "STMissionDetailsViewController", bundle: Bundle.main)
        
        missionDetailsDict = dict
    
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
            labelChallengerNameTitle.text = "Child Name"
            labelChallengerName.text = "\(missionDetailsDict[kParamKeyChild][kParamKeyFirstname]) \(missionDetailsDict[kParamKeyChild][kParamKeyLastname])"
            if !(missionDetailsDict[kParamKeyChild][kParamKeyAvatar] is NSNull) {
                imgViewProfilePic.setImageWith(URL(string: missionDetailsDict[kParamKeyChild][kParamKeyAvatar]))
            }
        }
        else {
            labelChallengerNameTitle.text = "Parent Name"
            labelChallengerName.text = "\(missionDetailsDict[kParamKeyParent][kParamKeyFirstname]) \(missionDetailsDict[kParamKeyParent][kParamKeyLastname])"
            if !(missionDetailsDict[kParamKeyParent][kParamKeyAvatar] is NSNull) {
                imgViewProfilePic.setImageWith(URL(string: missionDetailsDict[kParamKeyParent][kParamKeyAvatar]))
            }
        }
        labelMissionName.text = missionDetailsDict["title"]
        if missionDetailsDict["description"].validateNotEmpty() {
            txtViewMissionDescription.text = missionDetailsDict["description"]
            txtViewMissionDescription.isHidden = false
            labelMissionDescriptionTitle.isHidden = false
            imgViewTxtBG.isHidden = false
        }
        else {
            txtViewMissionDescription.isHidden = true
            labelMissionDescriptionTitle.isHidden = true
            imgViewTxtBG.isHidden = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        headerLabel.font = UIFont()
        labelChallengerNameTitle.font = UIFont.fontGothamRoundedBook(withSize: 8.0)
        labelMissionNameTitle.font = UIFont.fontGothamRoundedBook(withSize: 8.0)
        labelMissionDescriptionTitle.font = UIFont.fontGothamRoundedBook(withSize: 8.0)
        labelMissionNameTitle.sizeToFit()
        labelChallengerName.font = UIFont.fontGothamRoundedBold(withSize: 11.0)
        labelMissionName.font = UIFont.fontGothamRoundedBold(withSize: 11.0)
        txtViewMissionDescription.font = UIFont.fontGothamRoundedBold(withSize: 11.0)
        labelChallengerNameTitle.textColor = UIColor.stasherText()
        labelMissionNameTitle.textColor = UIColor.stasherText()
        labelMissionDescriptionTitle.textColor = UIColor.stasherText()
        labelChallengerName.textColor = UIColor.stasherText()
        labelMissionName.textColor = UIColor.stasherText()
        txtViewMissionDescription.textColor = UIColor.stasherText()
        labelMissionName.sizeToFit()
        imgViewProfilePic.clipsToBounds = true
        imgViewProfilePic.layer.cornerRadius = imgViewProfilePic.frame.size.width / 2.0
        imgViewProfilePic.layer.borderColor = UIColor.clear.cgColor
        imgViewProfilePic.layer.borderWidth = 0.5
        imgViewProfilePic.contentMode = .scaleAspectFill
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
}