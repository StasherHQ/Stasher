//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STChildAccountParentDetailsViewController.swift
//  Stasher
//
//  Created by bhushan on 03/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STChildAccountParentDetailsViewController: UIViewController, STSharedCustomsDelegate {

    var parentDetailsDictionary = [AnyHashable: Any]()
    @IBOutlet var labelUsername: UILabel!
    @IBOutlet var labelCompleteName: UILabel!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var parentProfilePictureImgView: UIImageView!

    init(nibName nibNameOrNil: String, bundle nibBundleOrNil: Bundle, andParentDetailsDictionary thisDetailsDict: [AnyHashable: Any]) {
        super.init(nibName: "STChildAccountParentDetailsViewController", bundle: Bundle.main)
        
        parentDetailsDictionary = thisDetailsDict
    
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        labelCompleteName.text = "\(parentDetailsDictionary[kParamKeyFirstname]) \(parentDetailsDictionary[kParamKeyLastname])"
        labelUsername.text = parentDetailsDictionary[kParamKeyUsername]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        headerLabel.font = UIFont()
        labelCompleteName.font = UIFont.fontGothamRoundedMedium(withSize: 10.0)
        labelCompleteName.textColor = UIColor.stasherTextFieldPlaceHolder()
        labelUsername.font = UIFont.fontGothamRoundedMedium(withSize: 18.0)
        labelUsername.textColor = UIColor.stasherText()
        parentProfilePictureImgView.clipsToBounds = true
        parentProfilePictureImgView.layer.cornerRadius = 80 / 2.0
        parentProfilePictureImgView.layer.borderColor = UIColor.clear.cgColor
        parentProfilePictureImgView.layer.borderWidth = 0.5
        parentProfilePictureImgView.contentMode = .scaleAspectFill
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: self).addRightSwipeGestureRecognizerToMe()
        if !(parentDetailsDictionary[kParamKeyAvatar] is NSNull) && !(parentDetailsDictionary[kParamKeyAvatar] == "") {
            parentProfilePictureImgView.setImageWith(URL(string: parentDetailsDictionary[kParamKeyAvatar]), placeholderImage: UIImage(named: "account_face_placeholder"))
        }
        else {
            parentProfilePictureImgView.image = UIImage(named: "account_face_placeholder")
        }
    }

    func rightGestureHandle() {
        navigationController?.popViewController(animated: true)
        STSharedCustoms.sharedAddGestureInstance(withDelegate: nil)
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

    @IBAction func backBUttonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}