//
//  STRegisterStepTwoViewController.m
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STRegisterStepTwoViewController.h"
#import "STRegisterStepThreeViewController.h"
#import "STBaseTabBarController.h"

@interface STRegisterStepTwoViewController ()

@end

@implementation STRegisterStepTwoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.tabBarController.tabBar setHidden:YES];
    
    if (self.registrationInfoDictionary) {
        if ([self.registrationInfoDictionary objectForKey:kParamKeyFirstname]) {
            [self.txtFieldFirstName setText:[self.registrationInfoDictionary objectForKey:kParamKeyFirstname]];
        }
        if ([self.registrationInfoDictionary objectForKey:kParamKeyLastname]) {
            [self.txtFieldLastName setText:[self.registrationInfoDictionary objectForKey:kParamKeyLastname]];
        }
        if ([self.registrationInfoDictionary objectForKey:kParamKeyGender]) {
            [self.txtFieldGender setText:[self.registrationInfoDictionary objectForKey:kParamKeyGender]];
        }
        if ([self.registrationInfoDictionary objectForKey:kParamKeyDateOfBirth]) {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
            [dateFormat2 setDateFormat:@"MMMM d, YYYY"];
            NSString *dateStr = [dateFormat2 stringFromDate:[dateFormat dateFromString:[self.registrationInfoDictionary objectForKey:kParamKeyDateOfBirth]]];
            [self.txtFieldAge setText:dateStr];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.transparentImageBG setFrame:self.view.frame];
    
    if ([[STUserIdentity sharedInstance] userIdentity] == CHILDUSER) {
        [self.headerLabelStep setText:NSLocalizedString( @"Step 2 of 2", nil)];
    }
    else{
        [self.headerLabelStep setText:NSLocalizedString( @"Step 2 of 3", nil)];
    }
    
    if (isiPhone4s) {
        [self.containerScrollView setContentSize:CGSizeMake(self.containerScrollView.frame.size.width, self.registerButton.frame.origin.y + self.registerButton.frame.size.height)];
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
    }
    
    //Clip/Clear the other pieces whichever outside the rounded corner
    self.profilePicButton.clipsToBounds = YES;
    self.profilePicButton.layer.cornerRadius = self.profilePicButton.frame.size.width/2.0f;
    self.profilePicButton.layer.borderColor=[UIColor clearColor].CGColor;
    self.profilePicButton.layer.borderWidth=2.0f;
    
    [self.headerLabelRegistration setText:@"Registration"];
    [self.headerLabelRegistration setFont:[UIFont FontGothamRoundedMediumWithSize:16.0f]];
    [self.headerLabelStep setFont:[UIFont FontGothamRoundedBookWithSize:16.0f]];
    [self.headerLabelStep sizeToFit];
    [self.headerLabelRegistration sizeToFit];
    for (id txtFields in [self.view subviews]){
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
    
    [self.registerButton.titleLabel setFont:[UIFont FontForButtonsWithSize:13.0f]];
    self.txtFieldFirstName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.txtFieldLastName.autocapitalizationType = UITextAutocapitalizationTypeWords;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if (self.countryNamesDictsArray == nil) {
        BOABHttpReq *httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:NO];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:kAPIActionAllCountries,kParamKeyAction, nil] json:YES];
    }
    
    [[STSharedCustoms sharedAddGestureInstanceWithDelegate:self] addRightSwipeGestureRecognizerToMe];
    if ([self.registrationInfoDictionary objectForKey:kParamKeyAvatar] != nil) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:[self.registrationInfoDictionary objectForKey:kParamKeyAvatar] options:0];
        [self.profilePicButton setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    }
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
    if (profilePhotoActionSheet) {
        profilePhotoActionSheet = nil;
    }
    
    if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
        profilePhotoActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image from..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Image Gallery",nil];
    }else{
        profilePhotoActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image from..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Image Gallery", @"Stasher Avatars",nil];
    }
    profilePhotoActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    profilePhotoActionSheet.alpha=0.90;
    profilePhotoActionSheet.tag = 1;
    [profilePhotoActionSheet showInView:self.view];
}

- (IBAction)registerButtonPressed:(id)sender
{
    if ([self.txtFieldFirstName.text validateNotEmpty] && [self.txtFieldAge.text validateNotEmpty]) {
        if (tandcVC == nil) {
            tandcVC = [[STTermsAndConditionsViewController alloc] initWithNibName:@"STTermsAndConditionsViewController" bundle:[NSBundle mainBundle]];
        }
        tandcVC.delegate = self;
        [tandcVC.view setFrame:self.view.frame];
        [self.view addSubview:tandcVC.view withAnimation:YES];
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

- (void)cancelButtonPressed
{
    if (tandcVC) {
        [tandcVC.view removeFromSuperviewwithAnimation:YES];
        tandcVC = nil;
    }
}

- (void)acceptButtonPressed
{
    if ([self.txtFieldFirstName.text validateNotEmpty] && [self.txtFieldAge.text validateNotEmpty]) {
        [self.registrationInfoDictionary setObject:self.txtFieldFirstName.text forKey:kParamKeyFirstname];
        if ([self.txtFieldLastName.text validateNotEmpty]) {
            [self.registrationInfoDictionary setObject:self.txtFieldLastName.text forKey:kParamKeyLastname];
        }
        //[self.registrationInfoDictionary setObject:self.txtFieldGender.text forKey:kParamKeyGender];
        [self.registrationInfoDictionary setObject:selectedDOBStr forKey:kParamKeyDateOfBirth];
        //[self.registrationInfoDictionary setObject:[NSNumber numberWithInt:countryID] forKey:kParamKeyCountry];
        if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
            [self.registrationInfoDictionary setObject:[NSString stringWithFormat:@"%@",@"yes"] forKey:kParamKeyIsParent];
        }
        if ([[STUserIdentity sharedInstance] userIdentity] == CHILDUSER) {
            [self.registrationInfoDictionary setObject:[NSString stringWithFormat:@"%@",@"no"] forKey:kParamKeyIsParent];
        }
        if (self.profilePickerImageData == nil) {
            if ([self.registrationInfoDictionary objectForKey:kParamKeyAvatar] != nil) {
                [self.registrationInfoDictionary setObject:[self.registrationInfoDictionary objectForKey:kParamKeyAvatar] forKey:kParamKeyAvatar];
            }
        }else{
            [self.registrationInfoDictionary setObject:[self.profilePickerImageData base64EncodedStringWithOptions:0] forKey:kParamKeyAvatar];
        }
        
        if (deviceTokenStr != nil) {
            [self.registrationInfoDictionary setObject:deviceTokenStr forKey:@"uid"];
        }
        
        [[STUserIdentity sharedInstance] setUserInformationDictionary:self.registrationInfoDictionary];
        
        BOABHttpReq *httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
        [self.registrationInfoDictionary setObject:kAPIActionRegister forKey:kParamKeyAction];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:self.registrationInfoDictionary json:YES];
        [self.view setUserInteractionEnabled:NO];
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

- (IBAction)dateOfBirthButtonPressed:(id)sender
{
    if (currentTextField) {
        [currentTextField resignFirstResponder];
    }
    [self.dobPickerContainerView setBackgroundColor:[UIColor stasherPopUpBGColor]];
    self.dobPickerContainerView.clipsToBounds = YES;
    self.dobPickerContainerView.layer.cornerRadius = 10.0f;
    self.dobPickerContainerView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.dobPickerContainerView.layer.borderWidth=1.0f;
    [self.dobPickerContainerView setHidden:NO];
    [self.transparentImageBG setHiddenAnimated:NO];
    [self.buttonCloseBackGroundPopUp setHidden:NO];
    //[self.dobDatePicker setMaximumDate:[NSDate date]];
}

- (IBAction)dobPickerDoneButtonPressed:(id)sender
{
     [self.dobPickerContainerView setHidden:YES];
     [self.transparentImageBG setHiddenAnimated:YES];
     [self.buttonCloseBackGroundPopUp setHidden:YES];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *theDate = [dateFormat stringFromDate:self.dobDatePicker.date];
    selectedDOBStr = theDate;
    
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"MMMM d, YYYY"];
    NSString *dateStr = [dateFormat2 stringFromDate:[dateFormat dateFromString:theDate]];
    [self.txtFieldAge setText:dateStr];
}

- (IBAction)dobPickerCancelButtonPressed:(id)sender
{
    [self.dobPickerContainerView setHidden:YES];
    [self.transparentImageBG setHiddenAnimated:YES];
    [self.buttonCloseBackGroundPopUp setHidden:YES];
}

- (IBAction)genderButtonPressed:(id)sender
{
    if (currentTextField) {
        [currentTextField resignFirstResponder];
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
    if (currentTextField) {
        [currentTextField resignFirstResponder];
    }
    if (countryNamesActionSheet == nil){
        //[self prepareCountriesActionsheet];
    }
        
    //[countryNamesActionSheet showInView:self.view];
    if (countryNamesVC) {
        [countryNamesVC.view removeFromSuperview];
        countryNamesVC = nil;
    }
    countryNamesVC = [[STCountryNamesViewController alloc] initWithNibName:@"STCountryNamesViewController" bundle:[NSBundle mainBundle] andCountryArray:self.countryNamesDictsArray];
    countryNamesVC.view.frame = self.view.frame;
    countryNamesVC.delegate = self;
    [self.view addSubview:countryNamesVC.view withAnimation:YES];
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

# pragma mark ----- Custm Methods


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
    countryNamesActionSheet.delegate = self;
    
    for (NSDictionary* countryDict in self.countryNamesDictsArray) {
        [countryNamesActionSheet addButtonWithTitle:[NSString stringWithFormat:@"%@",[countryDict objectForKey:@"country_name"]]];
    }
    
    [countryNamesActionSheet addButtonWithTitle:@"Cancel"];
    countryNamesActionSheet.cancelButtonIndex = self.countryNamesDictsArray.count;
}

- (void) launchStepThreeRegistration
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STRegisterStepThreeViewController *registerStepthreeVC = [storyboard instantiateViewControllerWithIdentifier:@"RegisterStepThreeViewController"];
    [self.navigationController pushViewController:registerStepthreeVC animated:YES];
}

# pragma mark ----- Textfield Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTextField = textField;
     if (!IS_STANDARD_IPHONE_6_PLUS) {
         if ( textField == self.txtFieldAge) {
             CGRect viewFrame = self.view.frame;
             viewFrame.origin.y = -80.0f;
             //[self.view setFrame:viewFrame];
             [self.containerScrollView setContentOffset:CGPointMake(0,80.0f) animated:YES];
         }
         if (isiPhone4s) {
             CGRect viewFrame = self.view.frame;
             viewFrame.origin.y = -80.0f;
             //[self.view setFrame:viewFrame];
             [self.containerScrollView setContentOffset:CGPointMake(0,80.0f) animated:YES];
         }
     }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (!IS_STANDARD_IPHONE_6_PLUS) {
        [textField resignFirstResponder];
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y = 0.0f;
        //[self.view setFrame:viewFrame];
        [self.containerScrollView setContentOffset:CGPointMake(0,0) animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtFieldFirstName) {
        [textField resignFirstResponder];
        [self.txtFieldLastName becomeFirstResponder];
    }
    else if (textField == self.txtFieldLastName){
        [textField resignFirstResponder];
        [self dateOfBirthButtonPressed:nil];
    }
    else{
        [textField resignFirstResponder];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = TRUE;
    if (textField == self.txtFieldFirstName || textField == self.txtFieldLastName) {
        if ([string validateAlpha]) {
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
        self.profilePickerImageData = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0)];
    }else{
        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self.profilePicButton setBackgroundImage:image forState:UIControlStateNormal];
        self.profilePickerImageData = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0)];
    }
}



# pragma mark ----- Actionsheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == countryNamesActionSheet) {
        if ([self.countryNamesDictsArray count] > buttonIndex) {
            [self.txtFieldCountry setText:[[self.countryNamesDictsArray objectAtIndex:buttonIndex] objectForKey:@"country_name"]];
            countryID = [[[self.countryNamesDictsArray objectAtIndex:buttonIndex] objectForKey:@"id"] intValue];
        }
    }
    else if (actionSheet == genderActionSheet){
        if (buttonIndex != [actionSheet cancelButtonIndex])
            [self.txtFieldGender setText:[actionSheet buttonTitleAtIndex:buttonIndex]];
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
                    if ([[STUserIdentity sharedInstance] userIdentity] == CHILDUSER) {
                        if (avatarSelectVC) {
                            avatarSelectVC.delegate = nil;
                            avatarSelectVC = nil;
                        }
                        avatarSelectVC = [[STAvatarsViewController alloc] initWithNibName:@"STAvatarsViewController" bundle:nil];
                        avatarSelectVC.delegate = self;
                        [self.navigationController pushViewController:avatarSelectVC animated:YES];
                    }
                }
                    break;
            }
                break;
                
            default:
                break;
        }
    }
}

# pragma mark ----- CountryNamesDelegate

- (void)countryNamesViewOkPressedWithCountryId:(int)selectedCountryIndex
{
    if (self.countryNamesDictsArray && self.countryNamesDictsArray.count > selectedCountryIndex) {
        [self.txtFieldCountry setText:[[self.countryNamesDictsArray objectAtIndex:selectedCountryIndex] objectForKey:@"country_name"]];
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


# pragma mark ----- AvatarVC Delegate

- (void)avatarSelectedWithImgName:(NSString *)imgNameStr
{
    [self.profilePicButton setBackgroundImage:[UIImage imageNamed:imgNameStr] forState:UIControlStateNormal];
    self.profilePickerImageData = UIImagePNGRepresentation([UIImage imageNamed:imgNameStr]);
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
                [self.view setUserInteractionEnabled:YES];
                if ([responseDictionary objectForKey:@"success"] != nil) {
                    if ([responseDictionary objectForKey:@"success"] ) {
                        if ([responseDictionary objectForKey:@"usedetails"] && [[responseDictionary objectForKey:@"usedetails"] isKindOfClass:[NSDictionary class]]) {
                            [[STUserIdentity sharedInstance] setUserInformationDictionary:[[responseDictionary objectForKey:@"usedetails"] mutableCopy]];
                            NSMutableDictionary *logInInfoDictionary = [[responseDictionary objectForKey:@"usedetails"] mutableCopy];
                            [logInInfoDictionary setObject:[NSNumber numberWithInt:1] forKey:kUserDefaultsIsUserLoggedIn];
                            [[STLogInManager sharedInstance] updateUserDefaultsInLogInManagerWithDictionary:logInInfoDictionary];
                        }
                        
                        [UIAlertView showWithTitle:@""
                                           message:@"Thanks for registering! We’ve sent you an email with your account details."//[[responseDictionary objectForKey:@"success"] objectForKey:@"message"]
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil
                                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                                  if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
                                                      [self launchStepThreeRegistration];
                                                  }
                                                  else{
                                                      UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                      STBaseTabBarController *baseTabBarController = [storyboard instantiateViewControllerWithIdentifier:@"STBaseTabBarController"];
                                                      [self.navigationController pushViewController:baseTabBarController animated:YES];
                                                  }
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
                                                  [self.navigationController popViewControllerAnimated:YES];
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
    [self.view setUserInteractionEnabled:YES];
    if (error) {
        
    }
}


@end
