//
//  STCreateChildViewController.h
//  Stasher
//
//  Created by bhushan on 20/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STAddChildViewController.h"
#import "STCountryNamesViewController.h"
#import "STAvatarsViewController.h"
@interface STCreateChildViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, STSharedCustomsDelegate,CountryNamesViewDelegate,AvatarVCDelegate>
{
    UITextField *currentTextfield;
    UIActionSheet* countryNamesActionSheet;
    int countryID;
    UIActionSheet* genderActionSheet;
    STCountryNamesViewController *countryNamesVC;
    STAvatarsViewController *avatarSelectVC;
    UIActionSheet *profilePhotoActionSheet;
    
    NSString *selectedDOBStr;

}
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) NSMutableArray *countryNamesDictsArray;
@property (nonatomic, strong) NSMutableDictionary *registrationInfoDictionary;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollViewTextFields;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldEmailAddress;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldusername;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldFirstname;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldLastname;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldPassword;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldGender;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldCountry;
@property (nonatomic, strong) IBOutlet UITextField *txtfieldDob;
@property (nonatomic, strong) IBOutlet UIButton *profilePicButton;
@property (nonatomic, strong) IBOutlet UIImageView *profilePicImageView;
@property (nonatomic, strong) IBOutlet UIDatePicker *dobDatePicker;
@property (nonatomic, strong) IBOutlet UIView *dobPickerContainerView;
@property (nonatomic, strong) IBOutlet UIButton *dobPickerDoneButton;
@property (nonatomic, strong) IBOutlet UIButton *createChildButton;
@property (nonatomic, strong) IBOutlet UIButton *createChildPopUpButton;
@property (nonatomic, strong) IBOutlet UIView *relationOptionView;
@property (nonatomic, strong) IBOutlet UIButton *parentRelationButton;
@property (nonatomic, strong) IBOutlet UIButton *familyRelationButton;
@property (nonatomic, strong) IBOutlet UIButton *friendRelationButton;
@property (nonatomic, strong) IBOutlet UIView *txtfieldContainerView;
@property (nonatomic, assign) RelationShipToChild relationshipEnum;
@property (nonatomic, strong) NSData *profilePickerImageData;
@property (nonatomic, strong) IBOutlet UIImageView *popUpBGImageView;
@property (nonatomic, strong) IBOutlet UIButton *popUpBGCloseButton;
@property (nonatomic, strong) IBOutlet UILabel *selectDOBlabel;
@property (nonatomic, strong) IBOutlet UIButton *dobPopUpOkButton;
@property (nonatomic, strong) IBOutlet UIButton *dobPopUpCancelButton;

@property (nonatomic, strong) IBOutlet UIImageView *imgViewparentBullet;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewFamilyBullet;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewFriendBullet;
@property (nonatomic, strong) IBOutlet UILabel *labelHeadingChooseRelation;

@end
