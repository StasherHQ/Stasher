//
//  STRegisterStepTwoViewController.h
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTermsAndConditionsViewController.h"
#import "STCountryNamesViewController.h"
#import "STAvatarsViewController.h"
@interface STRegisterStepTwoViewController : UIViewController <BOABHttpReqDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,STSharedCustomsDelegate,TermsAndConditionsDelegate,CountryNamesViewDelegate,AvatarVCDelegate>
{
    UITextField *currentTextField;
    UIActionSheet* countryNamesActionSheet;
    int countryID;
    UIActionSheet* genderActionSheet;
    UIActionSheet *profilePhotoActionSheet;
    STTermsAndConditionsViewController *tandcVC;
    STCountryNamesViewController *countryNamesVC;
    STAvatarsViewController *avatarSelectVC;
    
    NSString *selectedDOBStr;
}


@property (nonatomic, strong) NSMutableDictionary *registrationInfoDictionary;
@property (nonatomic, strong) NSMutableArray *countryNamesDictsArray;
@property (nonatomic, strong) IBOutlet UIButton *stepTitleBtn;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldFirstName;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldLastName;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldGender;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldAge;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldCountry;
@property (nonatomic, strong) IBOutlet UIDatePicker *dobDatePicker;
@property (nonatomic, strong) IBOutlet UIView *dobPickerContainerView;
@property (nonatomic, strong) IBOutlet UIButton *dobPickerDoneButton;
@property (nonatomic, strong) IBOutlet UIButton *profilePicButton;
@property (nonatomic, strong) NSData *profilePickerImageData;
@property (nonatomic, strong) IBOutlet UILabel *headerLabelRegistration;
@property (nonatomic, strong) IBOutlet UILabel *headerLabelStep;
@property (nonatomic, strong) IBOutlet UIScrollView *containerScrollView;
@property (nonatomic, strong) IBOutlet UIButton *registerButton;
@property (nonatomic, strong) IBOutlet UIImageView *transparentImageBG;
@property (nonatomic, strong) IBOutlet UIButton *buttonCloseBackGroundPopUp;
@end
