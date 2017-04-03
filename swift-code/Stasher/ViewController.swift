//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  ViewController.swift
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class ViewController: UIViewController {

    @IBOutlet var tutorialsScrollview: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.fromHexString("#3ab1f6")
        performSelector(#selector(self.setUpTutorialsScrollView), withObject: nil, afterDelay: 0.1)
        pageControl.numberOfPages = 5
        nextButton.titleLabel?.font = UIFont(size: 11.0)
    }

    override func viewWillAppear(_ animated: Bool) {
        if STLogInManager.sharedInstance().isUserLoggedIn() {
            presentBaseTabScreen()
        }
        else {

        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
// MARK: ---------- Custom Methods

    func presentStasherEntry() {
        var stEntryVC = STEntryViewController()
        navigationController?.pushViewController(stEntryVC, animated: true)
    }

    func presentBaseTabScreen() {
        var baseTabVC = STBaseTabBarController()
        navigationController?.pushViewController(baseTabVC, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpTutorialsScrollView() {
        var tutViewFrame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(tutorialsScrollview.frame.size.height))
        for c in 1..<6 {
            var tutView = UIView(frame: tutViewFrame)
            tutView.backgroundColor = UIColor.clear
            var label = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(180.0), height: CGFloat(40.0)))
            label.textColor = UIColor.white
            label.font = UIFont.fontGothamRoundedBold(withSize: 12.0)
            label.backgroundColor = UIColor.clear
            label.numberOfLines = 0
            label.textAlignment = .center
            var tutImageView: UIImageView?
            var tutImgRect: CGRect
            switch c {
                case 1:
                    label.text = "\("Ditch The Piggy Bank. Upgrade to Stasher.")"
                    tutImgRect = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(158), height: CGFloat(225))
                    if isiPhone4s {
                        tutImageView = UIImageView(frame: tutImgRect)
                        tutImageView?.frame = CGRect(x: CGFloat(tutViewFrame.size.width / 2 - tutImageView?.frame?.size?.width / 2), y: CGFloat(20.0), width: CGFloat(tutImageView?.frame?.size?.width), height: CGFloat(tutImageView?.frame?.size?.height))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(200), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }
                    else {
                        tutImageView = UIImageView(frame: tutImgRect)
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
                    tutImageView?.image = UIImage(named: "tut_page01")
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
                    tutImgRect = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(141), height: CGFloat(230))
                    if isiPhone4s {
                        tutImageView = UIImageView(frame: tutImgRect)
                        tutImageView?.frame = CGRect(x: CGFloat(tutViewFrame.size.width / 2 - tutImageView?.frame?.size?.width / 2), y: CGFloat(20.0), width: CGFloat(tutImageView?.frame?.size?.width), height: CGFloat(tutImageView?.frame?.size?.height))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(200), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }
                    else {
                        tutImageView = UIImageView(frame: tutImgRect)
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
                    tutImageView?.image = UIImage(named: "tut_page02")
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
                    label.text = "\("Parents transfer money securely to kids’ savings accounts using 128-bit encryption technology")"
                    tutImgRect = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(256), height: CGFloat(214))
                    if isiPhone4s {
                        tutImageView = UIImageView(frame: tutImgRect)
                        tutImageView?.frame = CGRect(x: CGFloat(tutViewFrame.size.width / 2 - tutImageView?.frame?.size?.width / 2), y: CGFloat(20.0), width: CGFloat(tutImageView?.frame?.size?.width), height: CGFloat(tutImageView?.frame?.size?.height))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(200), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }
                    else {
                        tutImageView = UIImageView(frame: tutImgRect)
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
                    tutImageView?.image = UIImage(named: "tut_page03")
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
                    tutImgRect = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(247), height: CGFloat(207))
                    if isiPhone4s {
                        tutImageView = UIImageView(frame: tutImgRect)
                        tutImageView?.frame = CGRect(x: CGFloat(tutViewFrame.size.width / 2 - tutImageView?.frame?.size?.width / 2), y: CGFloat(20.0), width: CGFloat(tutImageView?.frame?.size?.width), height: CGFloat(tutImageView?.frame?.size?.height))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(200), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }
                    else {
                        tutImageView = UIImageView(frame: tutImgRect)
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
                    tutImageView?.image = UIImage(named: "tut_page04")
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

                case 5:
                    label.text = "\("Got it? Cool. Go ahead and register now.")"
                    tutImgRect = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(193), height: CGFloat(238))
                    if isiPhone4s {
                        tutImageView = UIImageView(frame: tutImgRect)
                        tutImageView?.frame = CGRect(x: CGFloat(tutViewFrame.size.width / 2 - tutImageView?.frame?.size?.width / 2), y: CGFloat(20.0), width: CGFloat(tutImageView?.frame?.size?.width), height: CGFloat(tutImageView?.frame?.size?.height))
                        label.frame = CGRect(x: CGFloat(tutImageView?.center?.x - label.frame.size.width / 2), y: CGFloat(200), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
                    }
                    else {
                        tutImageView = UIImageView(frame: tutImgRect)
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
                    tutImageView?.image = UIImage(named: "tut_page05")
                    if IS_STANDARD_IPHONE_6 {
                        label.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(200.0), height: CGFloat(80.0))
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

            tutView.addSubview(tutImageView!)
            var stasherLogotextImgViewFrame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(175), height: CGFloat(30))
            var stasherLogoImgView = UIImageView(frame: stasherLogotextImgViewFrame)
            stasherLogoImgView.image = UIImage(named: "stasher_logo_text")
            stasherLogoImgView.center = CGPoint(x: CGFloat(tutImageView?.center?.x), y: CGFloat(tutImageView?.frame?.origin?.y + tutImageView?.frame?.size?.height + 50))
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
        pageControl.numberOfPages = 5
    }
// MARK: ----- Scrollview Delegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var currentIndex = Int(tutorialsScrollview.contentOffset.x / tutorialsScrollview.frame.size.width)
        pageControl.currentPage = currentIndex
        if pageControl.currentPage < 4 {
            nextButton.setTitle("Next", for: .normal)
        }
        else {
            nextButton.setTitle("OK", for: .normal)
        }
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        performSelector(#selector(self.nextButtonMoveScroll), withObject: nil, afterDelay: 0.1)
    }

    func nextButtonMoveScroll() {
        if pageControl.currentPage == 3 {
            nextButton.setTitle("OK", for: .normal)
        }
        if pageControl.currentPage < 4 {
            tutorialsScrollview.setContentOffset(CGPoint(x: CGFloat(tutorialsScrollview.contentOffset.x + tutorialsScrollview.frame.size.width), y: CGFloat(0.0)), animated: true)
        }
        else {
            //[self.tutorialsScrollview setContentOffset:CGPointMake(0.0f, 0.0f) animated:NO];
            presentStasherEntry()
        }
    }
}