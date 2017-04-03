//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  STActivityViewController.swift
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import UIKit
class STActivityViewController: UIViewController, ParentActivityDelegate, ChildActivityDelegate {
    var parentActivityVC: STParentActivityViewController?
    var childActivityVC: STChildActivityViewController?

    @IBOutlet var containerView: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        if STUserIdentity.sharedInstance().userIdentity() == PARENTUSER {
            if parentActivityVC != nil {
                parentActivityVC?.view?.removeFromSuperview()
                parentActivityVC = nil
            }
            parentActivityVC = STParentActivityViewController(nibName: "STParentActivityViewController", bundle: Bundle.main)
            parentActivityVC?.delegate = self
            parentActivityVC?.view?.frame = containerView?.frame
            containerView?.addSubview(parentActivityVC?.view, withAnimation: true)
            parentActivityVC?.performSelector(#selector(self.requestActivity), withObject: self, afterDelay: 0.01)
        }
        else if STUserIdentity.sharedInstance().userIdentity() == CHILDUSER {
            if childActivityVC != nil {
                childActivityVC?.view?.removeFromSuperview()
                childActivityVC = nil
            }
            childActivityVC = STChildActivityViewController(nibName: "STChildActivityViewController", bundle: Bundle.main)
            childActivityVC?.delegate = self
            childActivityVC?.view?.frame = containerView?.frame
            containerView?.addSubview(childActivityVC?.view, withAnimation: true)
            childActivityVC?.performSelector(#selector(self.requestActivity), withObject: self, afterDelay: 0.01)
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
// MARK: ------ Parent Methods

    func parentActivityCellDidSelect(withDict dict: [AnyHashable: Any]) {
        /*
            STActivityDetailsViewController *activityDetailVC = [[STActivityDetailsViewController alloc] initWithNibName:@"STActivityDetailsViewController" bundle:[NSBundle mainBundle] detailsDict:dict];
            [self.navigationController pushViewController:activityDetailVC animated:YES];
             */
        print("activity dict \(dict)")
        if dict["activity_type"] {
            switch CInt(dict["activity_type"]) {
                case 2:
                    tabBarController?.selectedIndex = 3
                case 3:
                    tabBarController?.selectedIndex = 3
                case 4:
                    tabBarController?.selectedIndex = 3
                case 5:
                    tabBarController?.selectedIndex = 3
                case 6:
                    tabBarController?.selectedIndex = 3
                case 7:
                    tabBarController?.selectedIndex = 3
                case 8:
                    tabBarController?.selectedIndex = 3
                case 9:
                    tabBarController?.selectedIndex = 3
                default:
                    break
            }
        }
    }
// MARK: ------ Child Methods

    func childActivityCellDidSelect(withDict dict: [AnyHashable: Any]) {
        print("activity dict \(dict)")
        /*
            STActivityDetailsViewController *activityDetailVC = [[STActivityDetailsViewController alloc] initWithNibName:@"STActivityDetailsViewController" bundle:[NSBundle mainBundle] detailsDict:dict];
            [self.navigationController pushViewController:activityDetailVC animated:YES];
            */
        if dict["activity_type"] {
            switch CInt(dict["activity_type"]) {
                case 2:
                    tabBarController?.selectedIndex = 3
                case 3:
                    tabBarController?.selectedIndex = 3
                case 4:
                    tabBarController?.selectedIndex = 3
                case 5:
                    tabBarController?.selectedIndex = 3
                case 6:
                    tabBarController?.selectedIndex = 3
                case 7:
                    tabBarController?.selectedIndex = 3
                case 8:
                    tabBarController?.selectedIndex = 3
                case 9:
                    tabBarController?.selectedIndex = 3
                case 10:
                    var activityDetailVC = STActivityDetailsViewController(nibName: "STActivityDetailsViewController", bundle: Bundle.main, detailsDict: dict)
                    navigationController?.pushViewController(activityDetailVC, animated: true)
                case 11:
                    var activityDetailVC = STActivityDetailsViewController(nibName: "STActivityDetailsViewController", bundle: Bundle.main, detailsDict: dict)
                    navigationController?.pushViewController(activityDetailVC, animated: true)
                default:
                    break
            }
        }
        //[self.tabBarController setSelectedIndex:3];
    }
}