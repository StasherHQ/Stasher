//
//  STRegisterStepOneViewController.h
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRegisterStepTwoViewController.h"

@interface STRegisterStepOneViewController : UIViewController <STSharedCustomsDelegate>
{
    BOABHttpReq *httpReq;
    NSMutableDictionary *stepOneParamDict;
}

@property (nonatomic, strong) IBOutlet UILabel *headerLabelRegistration;
@property (nonatomic, strong) IBOutlet UILabel *headerLabelSteps;

@property (nonatomic, strong) NSMutableDictionary *launchInfoDictionary;
@property (nonatomic, strong) IBOutlet UILabel *stepsTitleLabel;
@property (nonatomic, strong) IBOutlet UIView *aboveAgeRegistrationFieldView;
@property (nonatomic, strong) IBOutlet UIView *belowAgeRegistrationFieldView;
@property (nonatomic, strong) IBOutlet UILabel *underAgeLabel;
@property (nonatomic, strong) IBOutlet UILabel *areYouParentLabel;


@property (nonatomic, strong) IBOutlet UISwitch *ageSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *parentSwitch;

@property (nonatomic, strong) IBOutlet UITextField *txtFieldEmailAddress;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldUsername;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldPassword;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldParentsEmailAddress;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldUnderAgeUsername;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldUnderAgePassword;
@property (nonatomic, strong) IBOutlet UIButton *aboveAgeNextButton;
@property (nonatomic, strong) IBOutlet UIButton *belowAgeNextButton;

@property (nonatomic, strong) IBOutlet UIView *parentCustomSwitchView;
@property (nonatomic, strong) IBOutlet UIButton *buttonParentSwitchYes;
@property (nonatomic, strong) IBOutlet UIButton *buttonParentSwitchNo;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewGreenParentCustomSwitch;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewBGParentCustomSwitch;

@property (nonatomic, strong) IBOutlet UIView *ageCustomSwitchView;
@property (nonatomic, strong) IBOutlet UIButton *buttonAgeSwitchYes;
@property (nonatomic, strong) IBOutlet UIButton *buttonAgeSwitchNo;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewGreenAgeCustomSwitch;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewBGAgeCustomSwitch;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDictionary:(NSMutableDictionary*)dictionary;
- (IBAction)parentSwitchValueChanged:(id)sender;
@end
