//
//  STEditProfileViewController.m
//  Stasher
//
//  Created by bhushan on 19/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STEditProfileViewController.h"

@interface STEditProfileViewController ()

@end

@implementation STEditProfileViewController
@synthesize delegate;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.txtFieldUsername.text = [[STUserIdentity sharedInstance] username];
    self.txtFieldFirstName.text = [[STUserIdentity sharedInstance] firstName];
    self.txtFieldLastName.text = [[STUserIdentity sharedInstance] lastName];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *theDate = [dateFormat dateFromString:[[STUserIdentity sharedInstance] dateOfBirth]];
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"MMMM d, YYYY"];
    NSString *dateStr = [dateFormat2 stringFromDate:theDate];
    
    self.txtFieldBob.text = dateStr;
    
    if (self.editProfileParamDictionary) {
        self.editProfileParamDictionary = nil;
    }
    self.editProfileParamDictionary = [[NSMutableDictionary alloc] init];
    
    if (![[[STUserIdentity sharedInstance] avatarUrlString] isKindOfClass:[NSNull class]]&&![[[STUserIdentity sharedInstance] avatarUrlString] isEqualToString:@""]) {
        [self.profilePicImageView setImageWithURL:[NSURL URLWithString:[[STUserIdentity sharedInstance] avatarUrlString]] placeholderImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }else{
        [self.profilePicImageView setImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.headerlabel setFont:[UIFont FontForHeader]];
    for (id txtFields in [self.containerScrollView subviews]){
        if ([txtFields isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*) txtFields;
            [textField setFont:[UIFont FontForTextFields]];
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder
                                                                              attributes:@{
                                                                                           NSForegroundColorAttributeName:[UIColor colorWithRed:125.0f/255 green:125.0f/255 blue:125.0f/255 alpha:1.0f],
                                                                                           NSFontAttributeName : [UIFont FontForTextFields]
                                                                                           }
                                               ];
            textField.textColor = [UIColor stasherTextColor];
        }
    }
   
    self.txtFieldFirstName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.txtFieldLastName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    //Clip/Clear the other pieces whichever outside the rounded corner
    self.profilePicButton.clipsToBounds = YES;
    self.profilePicButton.layer.cornerRadius = 80/2.0f;
    self.profilePicButton.layer.borderColor=[UIColor clearColor].CGColor;
    self.profilePicButton.layer.borderWidth=0.5f;
    
    self.profilePicImageView.clipsToBounds = YES;
    self.profilePicImageView.layer.cornerRadius = 80/2.0f;
    self.profilePicImageView.layer.borderColor=[UIColor clearColor].CGColor;
    self.profilePicImageView.layer.borderWidth=2.0f;
    self.profilePicImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.changePasswordButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.saveProfileButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    
    self.dobPickerContainerView.clipsToBounds = YES;
    self.dobPickerContainerView.layer.cornerRadius = 10.0f;
    self.dobPickerContainerView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.dobPickerContainerView.layer.borderWidth=2.0f;
    [self.dobPickerContainerView setBackgroundColor:[UIColor stasherPopUpBGColor]];
    
    [self.okButton.titleLabel setFont:[UIFont FontGothamRoundedMediumWithSize:13.0f]];
    [self.cancelButton.titleLabel setFont:[UIFont FontGothamRoundedMediumWithSize:13.0f]];
    [self.selectDOBPopUpLabel setFont:[UIFont FontGothamRoundedMediumWithSize:13.0f]];
    [self.selectDOBPopUpLabel setTextColor:[UIColor stasherTextColor]];
    
    [self.labelHeadingFirstName setTextColor:[UIColor stasherTextColor]];
    [self.labelHeadingLastName setTextColor:[UIColor stasherTextColor]];
    [self.labelHeadingUsername setTextColor:[UIColor stasherTextColor]];
    [self.labelHeadingDOB setTextColor:[UIColor stasherTextColor]];
    
    [self.labelHeadingFirstName setFont:[UIFont FontForTextFields]];
    [self.labelHeadingLastName setFont:[UIFont FontForTextFields]];
    [self.labelHeadingUsername setFont:[UIFont FontForTextFields]];
    [self.labelHeadingDOB setFont:[UIFont FontForTextFields]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[STSharedCustoms sharedAddGestureInstanceWithDelegate:self] addRightSwipeGestureRecognizerToMe];
    
    if ([self.editProfileParamDictionary objectForKey:kParamKeyAvatar] != nil) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:[self.editProfileParamDictionary objectForKey:kParamKeyAvatar] options:0];
        [self.profilePicImageView setImage:[UIImage imageWithData:data]];
    }
    [self.containerScrollView setFrame:CGRectMake(self.containerScrollView.frame.origin.x, self.containerScrollView.frame.origin.y, self.view.frame.size.width, self.containerScrollView.frame.size.height)];
    [self.containerScrollView setContentSize:CGSizeMake(self.containerScrollView.frame.size.width, self.changePasswordButton.frame.origin.y + self.changePasswordButton.frame.size.height+12.0f)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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


#pragma mark ----- Actions
- (IBAction)profilePictureButtonPressed:(id)sender
{
    /*
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerController animated:YES completion:nil];
     */
    if (profilePhotoActionSheet) {
        profilePhotoActionSheet = nil;
    }
    profilePhotoActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image from..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Image Gallery", nil];
    profilePhotoActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    profilePhotoActionSheet.alpha=0.90;
    profilePhotoActionSheet.tag = 1;
    [profilePhotoActionSheet showInView:self.view];
}
- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightGestureHandle
{
    [self.navigationController popViewControllerAnimated:YES];
    [STSharedCustoms sharedAddGestureInstanceWithDelegate:nil];
}

- (IBAction)dateOfBirthButtonPressed:(id)sender
{
    if (currentTextField) {
        [currentTextField resignFirstResponder];
    }
    self.dobPickerContainerView.clipsToBounds = YES;
    self.dobPickerContainerView.layer.cornerRadius = 10.0f;
    self.dobPickerContainerView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.dobPickerContainerView.layer.borderWidth=1.0f;
    [self.dobPickerContainerView setHidden:NO];
    [self.transparentImageView setHiddenAnimated:NO];
    [self.buttonClosePopUp setHidden:NO];
    //[self.dobDatePicker setMaximumDate:[NSDate date]];
}

- (IBAction)dobPickerDoneButtonPressed:(id)sender
{
    [self.dobPickerContainerView setHidden:YES];
    [self.transparentImageView setHiddenAnimated:YES];
    [self.buttonClosePopUp setHidden:YES];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *theDate = [dateFormat stringFromDate:self.dobDatePicker.date];//send this to server
    selectedDOBDateStr = theDate;
    
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"MMMM d, YYYY"];
    NSString *dateStr = [dateFormat2 stringFromDate:[dateFormat dateFromString:theDate]];
    [self.txtFieldBob setText:dateStr];
}

- (IBAction)dobPickerCancelButtonPressed:(id)sender
{
    [self.dobPickerContainerView setHidden:YES];
    [self.transparentImageView setHiddenAnimated:YES];
    [self.buttonClosePopUp setHidden:YES];
}

- (IBAction)saveEditedProfileButtonPressed:(id)sender
{
    [self.editProfileParamDictionary setObject:self.txtFieldFirstName.text forKey:kParamKeyFirstname];
    if ([self.txtFieldLastName.text validateNotEmpty]) {
        [self.editProfileParamDictionary setObject:self.txtFieldLastName.text forKey:kParamKeyLastname];
    }
    if (selectedDOBDateStr == nil || [selectedDOBDateStr isEqualToString:@""]) {
       [self.editProfileParamDictionary setObject:[[STUserIdentity sharedInstance] dateOfBirth] forKey:kParamKeyDateOfBirth];
    }else{
        [self.editProfileParamDictionary setObject:selectedDOBDateStr forKey:kParamKeyDateOfBirth];
    }
    [self.editProfileParamDictionary setObject:self.txtFieldUsername.text forKey:kParamKeyUsername];
    if([[STUserIdentity sharedInstance] country])
        [self.editProfileParamDictionary setObject:[[STUserIdentity sharedInstance] country] forKey:kParamKeyCountry];
    if([[STUserIdentity sharedInstance] emailAddress])
        [self.editProfileParamDictionary setObject:[[STUserIdentity sharedInstance] emailAddress] forKey:kParamKeyEmail];
    
    if([[STUserIdentity sharedInstance] userId])
        [self.editProfileParamDictionary setObject:[[STUserIdentity sharedInstance] userId] forKey:kParamKeyUserID];
    
    [self.editProfileParamDictionary setObject:kAPIActionEditProfile forKey:kParamKeyAction];
    
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:self.editProfileParamDictionary json:YES];
    
}

- (IBAction)changePasswordButtonPressed:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STChangePasswordViewController *changePasswordVC = [storyboard instantiateViewControllerWithIdentifier:@"STChangePasswordViewController"];
    changePasswordVC.delegate = self;
    [self.navigationController pushViewController:changePasswordVC animated:YES];
}

# pragma mark ----- ImagePicker Delegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self.profilePicImageView setImage:image];
        self.profilePickerImageData = [NSData dataWithData:UIImageJPEGRepresentation(image,1.0f)];
        [self performSelector:@selector(addProfileImageDataToRequestDict) withObject:nil afterDelay:0.1];
    }else{
        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self.profilePicImageView setImage:image];
        self.profilePickerImageData = [NSData dataWithData:UIImageJPEGRepresentation(image,1.0f)];
        [self performSelector:@selector(addProfileImageDataToRequestDict) withObject:nil afterDelay:0.1];
    }
}

- (void)addProfileImageDataToRequestDict
{
    [self.editProfileParamDictionary setObject:[self.profilePickerImageData base64EncodedStringWithOptions:0]  forKey:kParamKeyAvatar];
}
#pragma mark ----- Textfield Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
     if (!IS_STANDARD_IPHONE_6 && !IS_STANDARD_IPHONE_6_PLUS) {
         CGRect viewFrame = self.view.frame;
         viewFrame.origin.y = -80.0f;
         [self.view setFrame:viewFrame];
     }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (!IS_STANDARD_IPHONE_6 && !IS_STANDARD_IPHONE_6_PLUS) {
        [textField resignFirstResponder];
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y = 0.0f;
        [self.view setFrame:viewFrame];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    currentTextField = textField;
    BOOL shouldChange = TRUE;
    if (textField == self.txtFieldUsername) {
        if ([string validateAlphanumeric]) {
            shouldChange = TRUE;
        }
        else{
            shouldChange = FALSE;
        }
    }
    else if (textField == self.txtFieldFirstName || textField == self.txtFieldLastName) {
        if ([string validateAlpha]) {
            shouldChange = TRUE;
        }
        else{
            shouldChange = FALSE;
        }
    }
    return shouldChange;
}

#pragma mark ----- Password Changed

- (void)passwordHasBeenChanged
{
    if ([self.delegate respondsToSelector:@selector(passwordChangedLogInAgain)]) {
        [self.delegate passwordChangedLogInAgain];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

# pragma mark ----- Actionsheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == profilePhotoActionSheet){
        switch (actionSheet.tag)
        {
            case 1:
                switch (buttonIndex)
            {
                case 0:
                {
#if TARGET_IPHONE_SIMULATOR
                    
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Camera not available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    
#elif TARGET_OS_IPHONE
                    
                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    picker.delegate = self;
                    //picker.allowsEditing = YES;
                    [self presentViewController:picker animated:YES completion:nil];
                    
#endif
                }
                    break;
                case 1:
                {
                    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
                    pickerController.delegate = self;
                    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    [self presentViewController:pickerController animated:YES completion:nil];
                }
                    break;
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark ----- BOABHttpReqDelegates
- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if ([responseDict objectForKey:@"success"]) {
            if ([self.delegate respondsToSelector:@selector(profileSuccessfullyEdited)]) {
                [self.delegate profileSuccessfullyEdited];
            }
            [UIAlertView showWithTitle:@""
                               message:[[responseDict objectForKey:@"success"] objectForKey:@"message"]
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  if (buttonIndex == [alertView cancelButtonIndex]) {
                                      [self.navigationController popViewControllerAnimated:YES];
                                  }
                              }];
        }
        else if ([responseDict objectForKey:@"error"]){
            [UIAlertView showWithTitle:@""
                               message:[[responseDict objectForKey:@"error"] objectForKey:@"message"]
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  if (buttonIndex == [alertView cancelButtonIndex]) {
                                  }
                              }];
        }
    }
}

- (void)BOABHttpReqFailedWithError:(NSError*)error
{
    if (error) {
        
    }
}



@end
