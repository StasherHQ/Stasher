//
//  STEditProfileViewController.h
//  Stasher
//
//  Created by bhushan on 19/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STChangePasswordViewController.h"
@protocol EditProfileDelegate <NSObject>

@optional

- (void)profileSuccessfullyEdited;
- (void)passwordChangedLogInAgain;

@end


@interface STEditProfileViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, ChangePasswordDelegate,STSharedCustomsDelegate,UIActionSheetDelegate>
{
    UITextField *currentTextField;
    BOABHttpReq *httpReq;
    UIActionSheet *profilePhotoActionSheet;
    NSString *selectedDOBDateStr;
}

@property (weak) id <EditProfileDelegate> delegate;
@property (nonatomic, strong) IBOutlet UILabel *headerlabel;
@property (nonatomic, strong) NSMutableDictionary *editProfileParamDictionary;
@property (nonatomic, strong) IBOutlet UIDatePicker *dobDatePicker;
@property (nonatomic, strong) IBOutlet UIView *dobPickerContainerView;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldUsername;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldFirstName;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldLastName;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldBob;
@property (nonatomic, strong) IBOutlet UIButton *profilePicButton;
@property (nonatomic, strong) IBOutlet UIImageView *profilePicImageView;
@property (nonatomic, strong) IBOutlet UIButton *backButton;
@property (nonatomic, strong) NSData *profilePickerImageData;
@property (nonatomic, strong) IBOutlet UIScrollView *containerScrollView;
@property (nonatomic, strong) IBOutlet UIButton *saveProfileButton;
@property (nonatomic, strong) IBOutlet UIButton *changePasswordButton;
@property (nonatomic, strong) IBOutlet UIImageView *transparentImageView;
@property (nonatomic, strong) IBOutlet UIButton *buttonClosePopUp;
@property (nonatomic, strong) IBOutlet UILabel *selectDOBPopUpLabel;
@property (nonatomic, strong) IBOutlet UIButton *okButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) IBOutlet UILabel *labelHeadingUsername;
@property (nonatomic, strong) IBOutlet UILabel *labelHeadingFirstName;
@property (nonatomic, strong) IBOutlet UILabel *labelHeadingLastName;
@property (nonatomic, strong) IBOutlet UILabel *labelHeadingDOB;
@end
