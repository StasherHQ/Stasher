//
//  STCreateChildViewController.m
//  Stasher
//
//  Created by bhushan on 20/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STCreateChildViewController.h"

@interface STCreateChildViewController ()

@end

@implementation STCreateChildViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (self.countryNamesDictsArray == nil) {
        BOABHttpReq *httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:NO];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:kAPIActionAllCountries,kParamKeyAction, nil] json:YES];
    }
    if (self.registrationInfoDictionary) {
        self.registrationInfoDictionary = nil;
    }
    self.registrationInfoDictionary = [[NSMutableDictionary alloc] init];
    [self.relationOptionView setHidden:YES];
    
    self.relationshipEnum = PARENT ;
    [self.parentRelationButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.familyRelationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.friendRelationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.headerLabel setFont:[UIFont FontForHeader]];
    for (id txtFields in [self.txtfieldContainerView subviews]){
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
    
    self.txtfieldFirstname.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.txtfieldLastname.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    self.profilePicButton.clipsToBounds = YES;
    self.profilePicButton.layer.cornerRadius = self.profilePicButton.frame.size.width/2.0f;
    self.profilePicButton.layer.borderColor=[UIColor clearColor].CGColor;
    self.profilePicButton.layer.borderWidth=2.0f;
    
    self.profilePicImageView.clipsToBounds = YES;
    self.profilePicImageView.layer.cornerRadius = self.profilePicButton.frame.size.width/2.0f;
    self.profilePicImageView.layer.borderColor=[UIColor clearColor].CGColor;
    self.profilePicImageView.layer.borderWidth=2.0f;
    self.profilePicImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.createChildButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    
    self.dobPickerContainerView.clipsToBounds = YES;
    self.dobPickerContainerView.layer.cornerRadius = 10.0f;
    self.dobPickerContainerView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.dobPickerContainerView.layer.borderWidth=1.0f;
    [self.dobPickerContainerView setBackgroundColor:[UIColor stasherPopUpBGColor]];
    [self.dobPopUpOkButton.titleLabel setFont:[UIFont FontForButtonsWithSize:13.0f]];
    [self.dobPopUpCancelButton.titleLabel setFont:[UIFont FontForButtonsWithSize:13.0f]];
    [self.selectDOBlabel setFont:[UIFont FontGothamRoundedMediumWithSize:13.0f]];
    
    self.relationOptionView.clipsToBounds = YES;
    self.relationOptionView.layer.cornerRadius = 10.0f;
    self.relationOptionView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.relationOptionView.layer.borderWidth=2.0f;
    [self.relationOptionView setBackgroundColor:[UIColor stasherPopUpBGColor]];
    [self.labelHeadingChooseRelation setFont:[UIFont FontGothamRoundedMediumWithSize:13.0f]];
    [self.labelHeadingChooseRelation setTextColor:[UIColor stasherTextColor]];
    [self.createChildButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.parentRelationButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.familyRelationButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.friendRelationButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[STSharedCustoms sharedAddGestureInstanceWithDelegate:self] addRightSwipeGestureRecognizerToMe];
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

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightGestureHandle
{
    [self.navigationController popViewControllerAnimated:YES];
    [STSharedCustoms sharedAddGestureInstanceWithDelegate:nil];
}

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
    profilePhotoActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image from..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Image Gallery", @"Stasher Avatars",nil];
    profilePhotoActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    profilePhotoActionSheet.alpha=0.90;
    profilePhotoActionSheet.tag = 1;
    [profilePhotoActionSheet showInView:self.view];
}

- (IBAction)createChildButtonPressed:(id)sender
{
    [self.parentRelationButton setTitleColor:[UIColor stasherTextColor] forState:UIControlStateNormal];
    [self.friendRelationButton setTitleColor:[UIColor stasherTextColor] forState:UIControlStateNormal];
    [self.familyRelationButton setTitleColor:[UIColor stasherTextColor] forState:UIControlStateNormal];
    [self.createChildPopUpButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.popUpBGCloseButton setHiddenAnimated:NO];
    [self.popUpBGImageView setHiddenAnimated:NO];
    [self.relationOptionView setHiddenAnimated:NO];
}

- (IBAction)dateOfBirthButtonPressed:(id)sender
{
    if (currentTextfield) {
        [currentTextfield resignFirstResponder];
    }
    [self.dobPickerContainerView setHidden:NO];
    [self.popUpBGCloseButton setHidden:NO];
    [self.popUpBGImageView setHiddenAnimated:NO];
    //[self.dobDatePicker setMaximumDate:[NSDate date]];
}

- (IBAction)dobPickerDoneButtonPressed:(id)sender
{
    [self.dobPickerContainerView setHidden:YES];
    [self.popUpBGCloseButton setHidden:YES];
    [self.popUpBGImageView setHiddenAnimated:YES];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *theDate = [dateFormat stringFromDate:self.dobDatePicker.date];
    selectedDOBStr = theDate;
    
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"MMMM d, YYYY"];
    NSString *dateStr = [dateFormat2 stringFromDate:[dateFormat dateFromString:theDate]];
    [self.txtfieldDob setText:dateStr];
}

- (IBAction)dobPopUpCloseButtonPressed:(id)sender
{
    [self.dobPickerContainerView setHidden:YES];
    [self.popUpBGCloseButton setHidden:YES];
    [self.popUpBGImageView setHiddenAnimated:YES];
    [self.relationOptionView setHiddenAnimated:YES];
}


- (IBAction)genderButtonPressed:(id)sender
{
    if (currentTextfield) {
        [currentTextfield resignFirstResponder];
    }
    if (genderActionSheet) {
        genderActionSheet = nil;
    }
    genderActionSheet =[[UIActionSheet alloc] initWithTitle:@"Select Your Gender"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                     destructiveButtonTitle:nil
                                          otherButtonTitles: nil];
    [genderActionSheet addButtonWithTitle:[NSString stringWithFormat:@"%@",@"Male"]];
    [genderActionSheet addButtonWithTitle:[NSString stringWithFormat:@"%@",@"Female"]];
    [genderActionSheet addButtonWithTitle:@"Cancel"];
    genderActionSheet.cancelButtonIndex = 2;
    
    if (genderActionSheet) {
        [genderActionSheet showInView:self.view];
    }
}

- (IBAction)countryButtonPressed:(id)sender
{
    if (currentTextfield) {
        [currentTextfield resignFirstResponder];
    }
    if (countryNamesVC) {
        [countryNamesVC.view removeFromSuperview];
        countryNamesVC = nil;
    }
    countryNamesVC = [[STCountryNamesViewController alloc] initWithNibName:@"STCountryNamesViewController" bundle:[NSBundle mainBundle] andCountryArray:self.countryNamesDictsArray];
    countryNamesVC.view.frame = self.view.frame;
    countryNamesVC.delegate = self;
    [self.view addSubview:countryNamesVC.view withAnimation:YES];
}

- (IBAction)parentRelationButtonPressed:(id)sender
{
    self.relationshipEnum = PARENT;    
    [self.imgViewparentBullet setImage:[UIImage imageNamed:@"buletbutton_Active"]];
    [self.imgViewFamilyBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
    [self.imgViewFriendBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
}


- (IBAction)familyRelationButtonPressed:(id)sender
{
    self.relationshipEnum = FAMILY;
    [self.imgViewparentBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
    [self.imgViewFamilyBullet setImage:[UIImage imageNamed:@"buletbutton_Active"]];
    [self.imgViewFriendBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
}

- (IBAction)friendRelationButtonPressed:(id)sender
{
    self.relationshipEnum = FRIEND;
    [self.imgViewparentBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
    [self.imgViewFamilyBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
    [self.imgViewFriendBullet setImage:[UIImage imageNamed:@"buletbutton_Active"]];
}

- (IBAction)createChildOnRelationViewButtonPressed:(id)sender
{
    [self.popUpBGCloseButton setHidden:YES];
    [self.popUpBGImageView setHiddenAnimated:YES];
    [self.relationOptionView setHiddenAnimated:YES];
    if ([self.txtfieldusername.text validateNotEmpty] &&
        [self.txtfieldPassword.text validateNotEmpty] &&
        [self.txtfieldFirstname.text validateNotEmpty] &&
        [self.txtfieldEmailAddress.text validateNotEmpty] &&
        [self.txtfieldDob.text validateNotEmpty]) {
        if ([self.txtfieldEmailAddress.text validateEmail]) {
            if (self.registrationInfoDictionary) {
                [self.registrationInfoDictionary setObject:self.txtfieldusername.text forKey:kParamKeyUsername];
                [self.registrationInfoDictionary setObject:selectedDOBStr forKey:kParamKeyDateOfBirth];
                [self.registrationInfoDictionary setObject:self.txtfieldEmailAddress.text forKey:kParamKeyEmail];
                [self.registrationInfoDictionary setObject:self.txtfieldFirstname.text forKey:kParamKeyFirstname];
                if ([self.txtfieldLastname.text validateNotEmpty]) {
                     [self.registrationInfoDictionary setObject:self.txtfieldLastname.text forKey:kParamKeyLastname];
                }
                [self.registrationInfoDictionary setObject:self.txtfieldPassword.text forKey:kParamKeyPassword];
                [self.registrationInfoDictionary setObject:@"no" forKey:kParamKeyIsParent];
                [self.registrationInfoDictionary setObject:kAPIActionRegister forKey:kParamKeyAction];
                [self.registrationInfoDictionary setObject:[NSNumber numberWithInt:self.relationshipEnum] forKey:@"relation_type"];
                BOABHttpReq *httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:NO];
                [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:self.registrationInfoDictionary json:YES];
            }
        }
        else{
            [UIAlertView showWithTitle:@""
                               message:@"Enter a valid E-mail address."
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  if (buttonIndex == [alertView cancelButtonIndex]) {
                                      [self.txtfieldEmailAddress becomeFirstResponder];
                                  }
                              }];
        }
    }
    else{
        [UIAlertView showWithTitle:@""
                           message:@"All fields are mandatory."
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                              }
                          }];
    }
}

# pragma mark ----- Textfield Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTextfield = textField;
    if (!IS_STANDARD_IPHONE_6_PLUS) {
        if (textField == self.txtfieldDob || textField == self.txtfieldLastname || textField == self.txtfieldFirstname) {
            CGRect viewFrame = self.view.frame;
            viewFrame.origin.y = - 130.0f;
            //[self.view setFrame:viewFrame];
            [self.scrollViewTextFields setContentOffset:CGPointMake(0,130.0) animated:YES];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = 0.0f;
    //[self.view setFrame:viewFrame];
    [self.scrollViewTextFields setContentOffset:CGPointMake(0,0) animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtfieldEmailAddress) {
        [self.txtfieldusername becomeFirstResponder];
    }
    else if (textField == self.txtfieldusername){
        [self.txtfieldPassword becomeFirstResponder];
    }
    else if (textField == self.txtfieldPassword){
        [self.txtfieldFirstname becomeFirstResponder];
    }
    else if (textField == self.txtfieldFirstname){
        [self.txtfieldLastname becomeFirstResponder];
    }
    else
        [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = TRUE;
    if (textField == self.txtfieldFirstname || textField == self.txtfieldLastname) {
        if ([string validateAlpha]) {
            shouldChange = TRUE;
        }
        else{
            shouldChange = FALSE;
        }
    }
    else if (textField == self.txtfieldusername || textField == self.txtfieldPassword) {
        if ([string validateAlphanumeric]) {
            shouldChange = TRUE;
        }
        else{
            shouldChange = FALSE;
        }
    }
    else{
        shouldChange = TRUE;
    }
    return shouldChange;
}


# pragma mark ----- Custm Methods

- (void)countryNamesViewOkPressedWithCountryId:(int)selectedCountryIndex
{
    if ([self.countryNamesDictsArray count] > selectedCountryIndex) {
        [self.txtfieldCountry setText:[[self.countryNamesDictsArray objectAtIndex:selectedCountryIndex] objectForKey:@"country_name"]];
        countryID = [[[self.countryNamesDictsArray objectAtIndex:selectedCountryIndex] objectForKey:@"id"] intValue];
    }
    if (countryNamesVC) {
        [countryNamesVC.view removeFromSuperviewwithAnimation:YES];
        countryNamesVC = nil;
    }
}

- (void)countryNamesViewCancelPressed
{
    if (countryNamesVC) {
        [countryNamesVC.view removeFromSuperviewwithAnimation:YES];
        countryNamesVC = nil;
    }
}


- (void) prepareCountriesActionsheet
{
    
    if (countryNamesActionSheet) {
        countryNamesActionSheet = nil;
    }
    countryNamesActionSheet =[[UIActionSheet alloc] initWithTitle:@"Select Your Country"
                                                         delegate:self
                                                cancelButtonTitle:nil
                                           destructiveButtonTitle:nil
                                                otherButtonTitles: nil];
    
    for (NSDictionary* countryDict in self.countryNamesDictsArray) {
        [countryNamesActionSheet addButtonWithTitle:[NSString stringWithFormat:@"%@",[countryDict objectForKey:@"country_name"]]];
    }
    
    [countryNamesActionSheet addButtonWithTitle:@"Cancel"];
    countryNamesActionSheet.cancelButtonIndex = self.countryNamesDictsArray.count;
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
        [self.profilePicButton setBackgroundImage:image forState:UIControlStateNormal];
        self.profilePickerImageData = [NSData dataWithData:UIImageJPEGRepresentation(image,1.0f)];
        [self performSelector:@selector(addProfileImageDataToRequestDict) withObject:nil afterDelay:0.1];
    }else{
        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self.profilePicButton setBackgroundImage:image forState:UIControlStateNormal];
        self.profilePickerImageData = [NSData dataWithData:UIImageJPEGRepresentation(image,1.0f)];
        [self performSelector:@selector(addProfileImageDataToRequestDict) withObject:nil afterDelay:0.1];
    }
}

- (void)addProfileImageDataToRequestDict
{
    [self.registrationInfoDictionary setObject:[self.profilePickerImageData base64EncodedStringWithOptions:0] forKey:kParamKeyAvatar];
}

# pragma mark ----- AvatarVC Delegate

- (void)avatarSelectedWithImgName:(NSString *)imgNameStr
{
    [self.profilePicButton setBackgroundImage:[UIImage imageNamed:imgNameStr] forState:UIControlStateNormal];
    self.profilePickerImageData = UIImagePNGRepresentation([UIImage imageNamed:imgNameStr]);
}

# pragma mark ----- Actionsheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == countryNamesActionSheet) {
        if ([self.countryNamesDictsArray count] > buttonIndex) {
            [self.txtfieldCountry setText:[[self.countryNamesDictsArray objectAtIndex:buttonIndex] objectForKey:@"country_name"]];
            countryID = [[[self.countryNamesDictsArray objectAtIndex:buttonIndex] objectForKey:@"id"] intValue];
        }
    }
    else if (actionSheet == genderActionSheet){
        if (buttonIndex != [actionSheet cancelButtonIndex])
            [self.txtfieldGender setText:[actionSheet buttonTitleAtIndex:buttonIndex]];
    }else if (actionSheet == profilePhotoActionSheet){
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
                case 2:
                {
                    if (avatarSelectVC) {
                        avatarSelectVC.delegate = nil;
                        avatarSelectVC = nil;
                    }
                    avatarSelectVC = [[STAvatarsViewController alloc] initWithNibName:@"STAvatarsViewController" bundle:nil];
                    avatarSelectVC.delegate = self;
                    [self.navigationController pushViewController:avatarSelectVC animated:YES];
                }
                    break;
            }
                break;
                
            default:
                break;
        }
    }
}



# pragma mark ----- BOABHttpReqDelegates

- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if (responseDictionary!=nil) {
            NSString *actionName = [[conn.userInfo objectForKey:KParamsKey] objectForKey:kParamKeyAction];
            if ([actionName isEqualToString:kAPIActionAllCountries]) {
                self.countryNamesDictsArray = [[responseDictionary objectForKey:@"countries"] mutableCopy];
                [self prepareCountriesActionsheet];
            }
            else if ([actionName isEqualToString:kAPIActionRegister])
            {
                if ([responseDictionary objectForKey:@"success"] != nil) {
                    if ([responseDictionary objectForKey:@"success"] ) {
                        [UIAlertView showWithTitle:@""
                                           message:[[responseDictionary objectForKey:@"success"] objectForKey:@"message"]
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil
                                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                                  [self.navigationController popViewControllerAnimated:YES];
                                              }
                                          }];
                    }
                }
                else if ([responseDictionary objectForKey:@"error"] != nil)
                {
                    if ([responseDictionary objectForKey:@"error"]) {
                        [UIAlertView showWithTitle:@""
                                           message:[[responseDictionary objectForKey:@"error"] objectForKey:@"message"]
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil
                                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                                  
                                              }
                                          }];
                    }
                }
            }
        }
    }
}


- (void)BOABHttpReqFailedWithError:(NSError*)error
{
    if (error) {
        
    }
}

@end
