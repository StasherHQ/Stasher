//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STBaseTabBarController.swift
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STBaseTabBarController: UITabBarController, UITabBarControllerDelegate, UITabBarDelegate, LogInManagerDelegate {



    convenience override init() {
        var storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self = storyboard.instantiateViewController(withIdentifier: "STBaseTabBarController")
        
        //Do initializations here...
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if UIApplication.shared.applicationIconBadgeNumber > 0 {
            viewControllers[0].tabBarItem.badgeValue = "\(Int(UIApplication.shared.applicationIconBadgeNumber))"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.fontGothamRoundedBold(withSize: 7.0)], for: .normal)
        UITabBar.appearance().tintColor = UIColor.white
        selectedIndex = 2
        delegate = self
        STLogInManager.sharedInstance().delegate = self
        // set the bar background color
        UITabBar.appearance().backgroundImage = image(fromColor: UIColor(red: CGFloat(140.0 / 255.0), green: CGFloat(140.0 / 255.0), blue: CGFloat(140.0 / 255.0), alpha: CGFloat(1)), forSize: CGSize(width: CGFloat(view.frame.size.width), height: CGFloat(49)), withCornerRadius: 0)
        // set the selected icon color
        UITabBar.appearance().tintColor = UIColor.white
        // remove the shadow
        UITabBar.appearance().shadowImage = nil
        // Set the dark color to selected tab (the dimmed background)
        if IS_STANDARD_IPHONE_6 {
            UITabBar.appearance().selectionIndicatorImage = image(fromColor: UIColor(red: CGFloat(255.0 / 255.0), green: CGFloat(54.0 / 255.0), blue: CGFloat(34.0 / 255.0), alpha: CGFloat(1)), forSize: CGSize(width: CGFloat(76), height: CGFloat(49)), withCornerRadius: 0)
        }
        else if IS_STANDARD_IPHONE_6_PLUS {
            UITabBar.appearance().selectionIndicatorImage = image(fromColor: UIColor(red: CGFloat(255.0 / 255.0), green: CGFloat(54.0 / 255.0), blue: CGFloat(34.0 / 255.0), alpha: CGFloat(1)), forSize: CGSize(width: CGFloat(78), height: CGFloat(49)), withCornerRadius: 0)
        }
        else {
            UITabBar.appearance().selectionIndicatorImage = image(fromColor: UIColor(red: CGFloat(255.0 / 255.0), green: CGFloat(54.0 / 255.0), blue: CGFloat(34.0 / 255.0), alpha: CGFloat(1)), forSize: CGSize(width: CGFloat(64), height: CGFloat(49)), withCornerRadius: 0)
        }

        for tbi: UITabBarItem in tabBar.items() {
            tbi.image = tbi.image.withRenderingMode(.alwaysOriginal)
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

    func image(from color: UIColor, for size: CGSize, withCornerRadius radius: CGFloat) -> UIImage {
        var rect = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height))
        UIGraphicsBeginImageContext(rect.size)
        var context: CGContext? = UIGraphicsGetCurrentContext()
        context.setFillColor(color.cgColor)
        context.fill(rect)
        var image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
            // Begin a new image that will be the new image with the rounded corners
            // (here with the size of an UIImageView)
        UIGraphicsBeginImageContext(size)
        // Add a clip before drawing anything, in the shape of an rounded rect
        UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
        // Draw your image
        image?.draw(in: rect)
        // Get the image, here setting the UIImageView image
        image = UIGraphicsGetImageFromCurrentImageContext()
        // Lets forget about that we were drawing
        UIGraphicsEndImageContext()
        return image!
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if STLogInManager.sharedInstance().isUserLoggedIn() {
            return true
        }
        return false
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("selected tab index \(UInt(tabBarController.selectedIndex))")
        if tabBarController.selectedIndex == 0 {
            viewControllers[0].tabBarItem.badgeValue = nil
        }
    }
// MARK: ----- LogInManager Delegate

    func userLoggedOutSuccessfully() {
        presentStasherEntry()
        /*
            [UIAlertView showWithTitle:@""
                               message:@"You are logged out of Stasher!"
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  if (buttonIndex == [alertView cancelButtonIndex]) {
                                  }
                              }];
             */
    }

    func presentStasherEntry() {
        var stEntryVC = STEntryViewController()
        navigationController?.pushViewController(stEntryVC, animated: true)
    }
}