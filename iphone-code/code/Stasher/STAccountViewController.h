//
//  STAccountViewController.h
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STAddChildViewController.h"
#import "STParentAccountViewController.h"
#import "STChildAccountViewController.h"
#import "STEditProfileViewController.h"
#import "STAddParentViewController.h"
#import "STParentAccountChildDetailsViewController.h"
#import "STChildAccountParentDetailsViewController.h"
#import "STSettingsViewController.h"
#import "STCreateChildViewController.h"

@interface STAccountViewController : UIViewController <ParentAccountDeleegate, ChildAccountDelegate,AddChildDelegate, AddParentDelegate, EditProfileDelegate, LogInManagerDelegate>
{
    BOABHttpReq *httpReq;
    STParentAccountViewController *parentAccountVC;
    STChildAccountViewController *childAccountVC;
}

@property (nonatomic, strong) IBOutlet UIView *accountContainerView;
@property (nonatomic, strong) IBOutlet UILabel *headerlabel;
@property (nonatomic, strong) IBOutlet UIButton *settingsButton;
- (void) requestUserDetails;
@end
