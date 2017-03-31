//
//  STEntryViewController.h
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "STRegisterStepOneViewController.h"


@interface STEntryViewController : UIViewController <LogInManagerDelegate>
{
    BOABHttpReq *httpReq;
}
@property (nonatomic, strong) IBOutlet UIView *userTypeContainerView;
@property (nonatomic, strong) IBOutlet UISwitch *userTypeSwitch;
@property (nonatomic, strong) IBOutlet UIScrollView *tutorialsScrollview;
@property (nonatomic, strong) IBOutlet UIScrollView *testScrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) IBOutlet UIButton *registerButton;
@property (nonatomic, strong) IBOutlet UIButton *registerWithFacebookButton;
@property (nonatomic, strong) IBOutlet UIButton *logInButton;
@property (nonatomic, strong) IBOutlet UILabel *orLabel;
@property (nonatomic, strong) IBOutlet UIView *overlayView;
@property (nonatomic, strong) IBOutlet UILabel *labelFBAreYouParent;
@property (nonatomic, strong) IBOutlet UIButton *buttonFBPopUpOk;
@property (nonatomic, strong) IBOutlet UIButton *buttonFBPopUpCancel;

@property (nonatomic, strong) IBOutlet UIView *parentCustomSwitchView;
@property (nonatomic, strong) IBOutlet UIButton *buttonSwitchYes;
@property (nonatomic, strong) IBOutlet UIButton *buttonSwitchNo;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewGreenCustomSwitch;

@property (nonatomic, strong) IBOutlet UIView *customSwitchFBParent;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewFBParentSwitchBG;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewYesCircle;
@property (nonatomic, strong) IBOutlet UIButton *customSwitchYesButton;
@property (nonatomic, strong) IBOutlet UIButton *customSwitchNoButton;

@end
