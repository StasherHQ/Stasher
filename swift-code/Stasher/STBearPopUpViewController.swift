//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STBearPopUpViewController.swift
//  Stasher
//
//  Created by Bhushan on 25/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//
import UIKit
protocol BearPopUpDelegate: NSObjectProtocol {
    func bearPopUpButtonPressed(withPopUpKind bearPopUpKind: BearPopUpType)

    func bearPopUpLaterButtonPressed()

    func bearPopUpSetUpButtonPressed()
}
class STBearPopUpViewController: UIViewController {

    weak var delegate: BearPopUpDelegate?
    @IBOutlet var imgViewTransparentBG: UIImageView!
    @IBOutlet var imgViewBear: UIImageView!
    @IBOutlet var rectangularView: UIView!
    @IBOutlet var labelPopUpText: UILabel!
    @IBOutlet var buttonPopUp: UIButton!
    @IBOutlet var buttonLater: UIButton!
    @IBOutlet var buttonSetUp: UIButton!
    var bearPopUpKind = BearPopUpType()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        rectangularView.clipsToBounds = true
        rectangularView.layer.cornerRadius = 10.0
        rectangularView.layer.borderColor = UIColor.clear.cgColor
        rectangularView.layer.borderWidth = 2.0
        buttonPopUp.titleLabel?.font = UIFont(size: 11.0)
        buttonLater.titleLabel?.font = UIFont(size: 11.0)
        buttonSetUp.titleLabel?.font = UIFont(size: 11.0)
        labelPopUpText.font = UIFont.fontGothamRoundedBook(withSize: 11.0)
        labelPopUpText.textColor = UIColor.stasherText()
        var imageNames: [Any] = ["Bear1.png", "Bear2.png", "Bear3.png", "Bear4.png", "Bear5.png", "Bear6.png", "Bear7.png", "Bear8.png", "Bear9.png", "Bear10.png"]
        var images = [Any]()
        for i in 0..<imageNames.count {
            images.append(UIImage(named: imageNames[i]))
        }
        imgViewBear.animationImages = images
        imgViewBear.animationDuration = kBearAnimationDuration
        imgViewBear.startAnimating()
        rectangularView.backgroundColor = UIColor.stasherPopUpBG()
        buttonPopUp.isHidden = false
        buttonLater.isHidden = true
        buttonSetUp.isHidden = true
        if bearPopUpKind == ADDPARENTBEARPOPUP {
            buttonPopUp.setTitle("ADD PARENT", for: .normal)
            labelPopUpText.text = "To use Stasher, You need to add a parent."
        }
        else if bearPopUpKind == THANKSFORADDINGPARENTBEARPOPUP {
            buttonPopUp.setTitle("Done, Let’s go", for: .normal)
            labelPopUpText.text = "Thanks for adding a parent!"
        }
        else if bearPopUpKind == ADDCHILDBEARPOPUP {
            buttonPopUp.setTitle("ADD CHILD", for: .normal)
            labelPopUpText.text = "Let's start by addding a child."
        }
        else if bearPopUpKind == THANKSFORADDINGACHILDBEARPOPUP {
            buttonPopUp.isHidden = true
            buttonLater.isHidden = false
            buttonSetUp.isHidden = false
            labelPopUpText.text = "Thanks for adding a child, to use Stasher you have to set up your Bank Details."
        }
        else if bearPopUpKind == BANKACCOUNTLATERBEARPOPUP {
            buttonPopUp.setTitle("OK", for: .normal)
            labelPopUpText.text = "No that's OK, we can do it later."
        }
        else if bearPopUpKind == BANKACCOUNTDONEBEARPOPUP {
            buttonPopUp.setTitle("OK", for: .normal)
            labelPopUpText.text = "Cool, we never share this information to anyone."
        }
        else if bearPopUpKind == THANKSFORADDINGACHILDNOBANKBEARPOPUP {
            buttonPopUp.setTitle("OK", for: .normal)
            labelPopUpText.text = "Thanks for adding a child."
        }

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

    @IBAction func popUpGreenButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.bearPopUpButtonPressedWithPopUpKind)) {
            delegate?.bearPopUpButtonPressed(withPopUpKind: bearPopUpKind)
        }
    }

    @IBAction func laterButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.bearPopUpLaterButtonPressed)) {
            delegate?.bearPopUpLaterButtonPressed()
        }
    }

    @IBAction func setUpButtonPressed(_ sender: Any) {
        if delegate?.responds(to: #selector(self.bearPopUpSetUpButtonPressed)) {
            delegate?.bearPopUpSetUpButtonPressed()
        }
    }
}