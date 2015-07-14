//
//  STSettingsViewController.h
//  Stasher
//
//  Created by Bhushan on 16/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STEditProfileViewController.h"
#import "STAccountViewController.h"
#import <MessageUI/MessageUI.h>
#import "STTermsAndConditionsViewController.h"
#import "STSocialNetworkSettingsViewController.h"
#import "STNotificationSettingsViewController.h"

@interface STSettingsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,EditProfileDelegate, MFMailComposeViewControllerDelegate>
{
    
    STTermsAndConditionsViewController *termsVC;
    STSocialNetworkSettingsViewController *socialSettingsVC;
    STNotificationSettingsViewController *notificationSettingsVC;
}

@property (nonatomic, strong) IBOutlet UILabel *headerlabel;
@property (nonatomic, strong) IBOutlet UITableView *settingsTableView;

@end
