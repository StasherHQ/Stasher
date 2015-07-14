//
//  STRegisterStepOneViewController.m
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STRegisterStepOneViewController.h"

@interface STRegisterStepOneViewController ()

@end

@implementation STRegisterStepOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDictionary:(NSMutableDictionary*)dictionary
{
    self = [super initWithNibName:@"STRegisterStepOneViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.launchInfoDictionary = [[NSMutableDictionary alloc] initWithDictionary:dictionary];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.headerLabelRegistration sizeToFit];
    [self.headerLabelSteps sizeToFit];
    [self changeHeaderText:NSLocalizedString( @"Step 1 of 3", nil)];
    [self.headerLabelRegistration setFont:[UIFont FontGothamRoundedMediumWithSize:16.0f]];
    [self.headerLabelSteps sizeToFit];
    [self.areYouParentLabel setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    [self.areYouParentLabel setTextColor:[UIColor stasherTextColor]];
    [self.underAgeLabel setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    [self.underAgeLabel setTextColor:[UIColor stasherTextColor]];
    [self.aboveAgeNextButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.belowAgeNextButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.buttonParentSwitchYes.titleLabel setFont:[UIFont FontForButtonsWithSize:6.5f]];
    [self.buttonAgeSwitchYes.titleLabel setFont:[UIFont FontForButtonsWithSize:6.5f]];
    [self.buttonAgeSwitchNo.titleLabel setFont:[UIFont FontForButtonsWithSize:6.5f]];
    [self.buttonParentSwitchNo.titleLabel setFont:[UIFont FontForButtonsWithSize:6.5f]];
    [self setUpTextFieldAttributes];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //[[STSharedCustoms sharedAddGestureInstanceWithDelegate:self] addRightSwipeGestureRecognizerToMe];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
    if([self.parentSwitch isOn])
        [self addAboveAgeRegistrationViewAsSubview];
    
    if (self.launchInfoDictionary) {
        if ([self.launchInfoDictionary objectForKey:kParamKeyEmail]) {
            [self.txtFieldEmailAddress setText:[self.launchInfoDictionary objectForKey:kParamKeyEmail]];
        }
    }
    [self changeHeaderText:NSLocalizedString( @"Step 1 of 3", nil)];
    [self performSelector:@selector(setUpFrames) withObject:nil afterDelay:0.1];
}

- (void)setUpFrames
{
    CGRect parentSwitchFrame = self.parentSwitch.frame;
    parentSwitchFrame.origin.x = self.view.frame.size.width - self.parentCustomSwitchView.frame.size.width - 8.0f;
    parentSwitchFrame.origin.y = self.areYouParentLabel.center.y;
    parentSwitchFrame.size.width = self.parentCustomSwitchView.frame.size.width;
    parentSwitchFrame.size.height = self.parentCustomSwitchView.frame.size.height;
    [self.parentCustomSwitchView setFrame:parentSwitchFrame];
    [self.parentCustomSwitchView setCenter:CGPointMake(self.parentCustomSwitchView.center.x, self.areYouParentLabel.center.y-2)];
    [self.view addSubview:self.parentCustomSwitchView];
    
    CGRect ageSwitchFrame = self.ageSwitch.frame;
    ageSwitchFrame.origin.x = self.view.frame.size.width - self.ageCustomSwitchView.frame.size.width - 8.0f;
    ageSwitchFrame.size.width = self.ageCustomSwitchView.frame.size.width;
    ageSwitchFrame.size.height = self.ageCustomSwitchView.frame.size.height;
    [self.ageCustomSwitchView setFrame:ageSwitchFrame];
    [self.view addSubview:self.ageCustomSwitchView];
    [self.ageCustomSwitchView setHidden:YES];
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

- (IBAction)nextButtonPressed:(id)sender
{
    if (stepOneParamDict) {
        stepOneParamDict = nil;
    }
    [[STUserIdentity sharedInstance] setUserIdentity:[self.parentSwitch isOn]?PARENTUSER:CHILDUSER];
    [[STUserIdentity sharedInstance] setIsUserUnderAge:[self.ageSwitch isOn]? YES:NO ];
    if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
        if ([self.txtFieldEmailAddress.text validateNotEmpty] && [self.txtFieldPassword.text validateNotEmpty] && [self.txtFieldUsername.text validateNotEmpty]) {
            if ([self.txtFieldEmailAddress.text validateEmail]) {
                stepOneParamDict = [[NSMutableDictionary alloc] init];
                [stepOneParamDict setObject:self.txtFieldEmailAddress.text forKey:kParamKeyEmail];
                [stepOneParamDict setObject:self.txtFieldPassword.text forKey:kParamKeyPassword];
                [stepOneParamDict setObject:self.txtFieldUsername.text forKey:kParamKeyUsername];
                //[self launchStepRegistrationWithDictionary:dict];
                if (httpReq) {
                    httpReq.delegate = nil;
                    httpReq = nil;
                }
                httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
                [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:kAPIActionRegistrationStepOne,kParamKeyAction, self.txtFieldUsername.text, kParamKeyUsername,self.txtFieldEmailAddress.text, kParamKeyEmail,nil] json:YES];
            }
            else{
                [UIAlertView showWithTitle:@""
                                   message:@"Enter a valid E-mail address."
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex]) {
                                          [self.txtFieldEmailAddress becomeFirstResponder];
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
    else{
        if ([[STUserIdentity sharedInstance] isUserUnderAge]) {
            if ([self.txtFieldParentsEmailAddress.text validateNotEmpty] && [self.txtFieldUnderAgeUsername.text validateNotEmpty]) {
                if ([self.txtFieldParentsEmailAddress.text validateEmail]) {
                    stepOneParamDict = [[NSMutableDictionary alloc] init];
                    [stepOneParamDict setObject:self.txtFieldParentsEmailAddress.text forKey:@"email"];
                    [stepOneParamDict setObject:self.txtFieldUnderAgeUsername.text forKey:@"username"];
                    //[self launchStepRegistrationWithDictionary:dict];
                    if (httpReq) {
                        httpReq.delegate = nil;
                        httpReq = nil;
                    }
                    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
                    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:kAPIActionRegistrationStepOne,kParamKeyAction, self.txtFieldUnderAgeUsername.text, kParamKeyUsername,self.txtFieldParentsEmailAddress.text, kParamKeyEmail,nil] json:YES];
                }
                else{
                    [UIAlertView showWithTitle:@""
                                       message:@"Enter a valid E-mail address."
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          if (buttonIndex == [alertView cancelButtonIndex]) {
                                              [self.txtFieldParentsEmailAddress becomeFirstResponder];
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
        else{
            if ([self.txtFieldEmailAddress.text validateNotEmpty] && [self.txtFieldPassword.text validateNotEmpty] && [self.txtFieldUsername.text validateNotEmpty]) {
                if ([self.txtFieldEmailAddress.text validateEmail]) {
                    stepOneParamDict = [[NSMutableDictionary alloc] init];
                    [stepOneParamDict setObject:self.txtFieldEmailAddress.text forKey:@"email"];
                    [stepOneParamDict setObject:self.txtFieldPassword.text forKey:@"password"];
                    [stepOneParamDict setObject:self.txtFieldUsername.text forKey:@"username"];
                    //[self launchStepRegistrationWithDictionary:dict];
                    if (httpReq) {
                        httpReq.delegate = nil;
                        httpReq = nil;
                    }
                    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
                    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:kAPIActionRegistrationStepOne,kParamKeyAction, self.txtFieldUsername.text, kParamKeyUsername,self.txtFieldEmailAddress.text, kParamKeyEmail,nil] json:YES];
                }
                else{
                    [UIAlertView showWithTitle:@""
                                       message:@"Enter a valid E-mail address."
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          if (buttonIndex == [alertView cancelButtonIndex]) {
                                              [self.txtFieldEmailAddress becomeFirstResponder];
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
    }
}

- (void)changeHeaderText:(NSString*)text
{
    UIFont *font1 = [UIFont FontGothamRoundedMediumWithSize:14.0f];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",@"Registration"] attributes: arialDict];
    
    UIFont *font2 = [UIFont FontGothamRoundedBookWithSize:14.0f];
    NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text] attributes: arialDict2];
    
    [aAttrString1 appendAttributedString:aAttrString2];
    self.headerLabelRegistration.attributedText = aAttrString1;
}

- (void) launchStepRegistrationWithDictionary:(NSMutableDictionary*)dict
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    NSString *storyBoardIdentifier;
    if (isiPhone4s) {
        storyBoardIdentifier = @"STRegisterStepTwoViewController.3.5";
    }
    else if(IS_STANDARD_IPHONE_6_PLUS){
        storyBoardIdentifier = @"STRegisterStepTwoViewController.5.5";
    }
    else{
        storyBoardIdentifier = @"STRegisterStepTwoViewController";
    }
    
    STRegisterStepTwoViewController *registerStepTwoVC = [storyboard instantiateViewControllerWithIdentifier:storyBoardIdentifier];
    if (self.launchInfoDictionary) {
        if([self.launchInfoDictionary objectForKey:kParamKeyFirstname]){
            [dict setObject:[self.launchInfoDictionary objectForKey:kParamKeyFirstname] forKey:kParamKeyFirstname];
        }
        if([self.launchInfoDictionary objectForKey:kParamKeyLastname]){
            [dict setObject:[self.launchInfoDictionary objectForKey:kParamKeyLastname] forKey:kParamKeyLastname];
        }
        if([self.launchInfoDictionary objectForKey:kParamKeyGender]){
            [dict setObject:[self.launchInfoDictionary objectForKey:kParamKeyGender] forKey:kParamKeyGender];
        }
        if([self.launchInfoDictionary objectForKey:kParamKeyDateOfBirth]){
            [dict setObject:[self.launchInfoDictionary objectForKey:kParamKeyDateOfBirth] forKey:kParamKeyDateOfBirth];
        }
        if([self.launchInfoDictionary objectForKey:kParamKeyAvatar]){
            [dict setObject:[self.launchInfoDictionary objectForKey:kParamKeyAvatar] forKey:kParamKeyAvatar];
        }
    }
    registerStepTwoVC.registrationInfoDictionary = [NSMutableDictionary dictionaryWithDictionary:dict];
    [self.navigationController pushViewController:registerStepTwoVC animated:YES];
}

- (IBAction)parentSwitchValueChanged:(id)sender{
    UISwitch *thisParentSwitch = (UISwitch*) sender;
    if (thisParentSwitch == self.parentSwitch) {
        if (![thisParentSwitch isOn]) {
            [self.ageCustomSwitchView setHidden:NO];
            [self.underAgeLabel setHidden:NO];
            [self.aboveAgeRegistrationFieldView removeFromSuperviewwithAnimation:YES];
            [self addBelowAgeRegistrationViewAsSubview];
            [self changeHeaderText:NSLocalizedString( @"Step 1 of 2", nil)];
            [[STUserIdentity sharedInstance] setUserIdentity:CHILDUSER];
        }
        else{
            [self.ageCustomSwitchView setHidden:YES];
            [self.underAgeLabel setHidden:YES];
            [self addAboveAgeRegistrationViewAsSubview];
            [self.belowAgeRegistrationFieldView removeFromSuperviewwithAnimation:YES];
            [self changeHeaderText:NSLocalizedString( @"Step 1 of 3", nil)];
            [[STUserIdentity sharedInstance] setUserIdentity:PARENTUSER];
        }
    }
}

- (IBAction)underAgeSwitchValueChanged:(id)sender{
    UISwitch *thisAgeSwitch = (UISwitch*) sender;
    if (thisAgeSwitch == self.ageSwitch) {
        if (![thisAgeSwitch isOn]) {
            CGRect aboveAgeViewFrame = self.aboveAgeRegistrationFieldView.frame;
            aboveAgeViewFrame.origin.y = self.underAgeLabel.frame.origin.y + 2 * self.underAgeLabel.frame.size.height;
            aboveAgeViewFrame.size.width = self.view.frame.size.width - self.aboveAgeRegistrationFieldView.frame.origin.x;
            [self.aboveAgeRegistrationFieldView setFrame:aboveAgeViewFrame];
            [self.view addSubview:self.aboveAgeRegistrationFieldView withAnimation:YES];
            [self changeHeaderText:NSLocalizedString( @"Step 1 of 2", nil)];
            [[STUserIdentity sharedInstance] setIsUserUnderAge:FALSE];
        }
        else{
            [self.aboveAgeRegistrationFieldView removeFromSuperviewwithAnimation:YES];
            [self addBelowAgeRegistrationViewAsSubview];
            [self changeHeaderText:NSLocalizedString( @"Step 1 of 2", nil)];
            [[STUserIdentity sharedInstance] setIsUserUnderAge:TRUE];
        }
    }
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

- (IBAction)underAgeFinishButtonPressed:(id)sender
{
    if (![self.txtFieldParentsEmailAddress.text validateEmail]) {
        [UIAlertView showWithTitle:@""
                           message:@"Please enter valid email address."
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              
                          }];
    }else{
        if (httpReq) {
            httpReq.delegate = nil;
            httpReq = nil;
        }
        httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        [paramDict setObject:self.txtFieldParentsEmailAddress.text forKey:kParamKeyEmail];
        [paramDict setObject:self.txtFieldUnderAgePassword forKey:kParamKeyPassword];
        [paramDict setObject:kAPIActionInviteParent forKey:kParamKeyAction];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
        paramDict = nil;
    }
}

#pragma mark ----- Custom Methods

- (void) addAboveAgeRegistrationViewAsSubview
{
    CGRect aboveAgeViewFrame = self.aboveAgeRegistrationFieldView.frame;
    aboveAgeViewFrame.origin.y = self.underAgeLabel.frame.origin.y;
    aboveAgeViewFrame.size.width = self.view.frame.size.width - self.aboveAgeRegistrationFieldView.frame.origin.x;
    [self.aboveAgeRegistrationFieldView setFrame:aboveAgeViewFrame];
    [self.view addSubview:self.aboveAgeRegistrationFieldView withAnimation:YES];
}

- (void) addBelowAgeRegistrationViewAsSubview
{
    CGRect belowAgeViewFrame = self.belowAgeRegistrationFieldView.frame;
    belowAgeViewFrame.origin.y = self.underAgeLabel.frame.origin.y + 2 * self.underAgeLabel.frame.size.height;
    belowAgeViewFrame.size.width = self.view.frame.size.width - self.belowAgeRegistrationFieldView.frame.origin.x;
    [self.belowAgeRegistrationFieldView setFrame:belowAgeViewFrame];
    [self.view addSubview:self.belowAgeRegistrationFieldView withAnimation:YES];
    
    CGRect ageSwitchFrame = self.ageSwitch.frame;
    ageSwitchFrame.origin.x = self.view.frame.size.width - self.ageCustomSwitchView.frame.size.width - 8.0f;
    ageSwitchFrame.size.width = self.ageCustomSwitchView.frame.size.width;
    ageSwitchFrame.size.height = self.ageCustomSwitchView.frame.size.height;
    [self.ageCustomSwitchView setFrame:ageSwitchFrame];
    [self.view addSubview:self.ageCustomSwitchView];
    [self.ageCustomSwitchView setHidden:NO];
}

- (void) setUpTextFieldAttributes
{
    for (id txtFields in [self.aboveAgeRegistrationFieldView subviews]){
        if ([txtFields isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*) txtFields;
            [textField setFont:[UIFont FontForTextFields]];
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder
                                                                              attributes:@{
                                                                                           NSForegroundColorAttributeName:[UIColor stasherTextFieldPlaceHolderColor],
                                                                                           NSFontAttributeName : [UIFont FontForTextFields]
                                                                                           }
                                               ];
            textField.textColor = [UIColor stasherTextColor];
        }
    }
    for (id txtFields in [self.belowAgeRegistrationFieldView subviews]){
        if ([txtFields isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*) txtFields;
            [textField setFont:[UIFont FontForTextFields]];
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder
                                                                              attributes:@{
                                                                                           NSForegroundColorAttributeName:[UIColor stasherTextFieldPlaceHolderColor],
                                                                                           NSFontAttributeName : [UIFont FontForTextFields]
                                                                                           }
                                               ];
            textField.textColor = [UIColor stasherTextColor];
        }
    }
}

- (IBAction)parentCustomSwitchYesButtonPressed:(id)sender
{
    if ([self.parentSwitch isOn]) {
        [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
            [self.imgViewGreenParentCustomSwitch setCenter:CGPointMake(13, self.imgViewGreenParentCustomSwitch.center.y)];
            [self.parentSwitch setOn:NO];
            [self parentSwitchValueChanged:self.parentSwitch];
            [self.buttonParentSwitchYes setHiddenAnimated:YES];
            [self.buttonParentSwitchNo setHiddenAnimated:NO];
            [self.imgViewGreenParentCustomSwitch setImage:[UIImage imageNamed:@"toggle_graycircle"]];
            [self.imgViewBGParentCustomSwitch setImage:[UIImage imageNamed:@"toggle_graybg"]];
        }];
    }else{
        [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
            [self.imgViewGreenParentCustomSwitch setCenter:CGPointMake(self.parentCustomSwitchView.frame.size.width-13, self.imgViewGreenParentCustomSwitch.center.y)];
            [self.parentSwitch setOn:YES];
            [self parentSwitchValueChanged:self.parentSwitch];
            [self.buttonParentSwitchYes setHiddenAnimated:NO];
            [self.buttonParentSwitchNo setHiddenAnimated:YES];
            [self.imgViewGreenParentCustomSwitch setImage:[UIImage imageNamed:@"toggle_yellowcircle"]];
            [self.imgViewBGParentCustomSwitch setImage:[UIImage imageNamed:@"toggle_greenBG"]];
            
        }];
    }
}

- (IBAction)parentCustomSwitchNoButtonPressed:(id)sender
{
    [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
        [self.imgViewGreenParentCustomSwitch setCenter:self.buttonParentSwitchNo.center];
        [self.parentSwitch setOn:NO];
        [self parentSwitchValueChanged:self.parentSwitch];
    }];
}

- (IBAction)ageCustomSwitchYesButtonPressed:(id)sender
{
    if([self.ageSwitch isOn]){
        [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
            [self.imgViewGreenAgeCustomSwitch setCenter:CGPointMake(13, self.imgViewGreenAgeCustomSwitch.center.y)];
            [self.ageSwitch setOn:NO];
            [self underAgeSwitchValueChanged:self.ageSwitch];
            [self.buttonAgeSwitchYes setHiddenAnimated:YES];
            [self.buttonAgeSwitchNo setHiddenAnimated:NO];
            [self.imgViewGreenAgeCustomSwitch setImage:[UIImage imageNamed:@"toggle_graycircle"]];
            [self.imgViewBGAgeCustomSwitch setImage:[UIImage imageNamed:@"toggle_graybg"]];
        }];
    }else{
        [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
            [self.imgViewGreenAgeCustomSwitch setCenter:CGPointMake(self.ageCustomSwitchView.frame.size.width-13, self.imgViewGreenAgeCustomSwitch.center.y)];
            [self.ageSwitch setOn:YES];
            [self underAgeSwitchValueChanged:self.ageSwitch];
            [self.buttonAgeSwitchYes setHiddenAnimated:NO];
            [self.buttonAgeSwitchNo setHiddenAnimated:YES];
            [self.imgViewGreenAgeCustomSwitch setImage:[UIImage imageNamed:@"toggle_yellowcircle"]];
            [self.imgViewBGAgeCustomSwitch setImage:[UIImage imageNamed:@"toggle_greenBG"]];
        }];
    }
    
}

- (IBAction)ageCustomSwitchNoButtonPressed:(id)sender
{
    [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
        [self.imgViewGreenAgeCustomSwitch setCenter:self.buttonAgeSwitchNo.center];
        [self.ageSwitch setOn:NO];
       [self underAgeSwitchValueChanged:self.ageSwitch];
    }];
}

#pragma mark ----- Textfield Methods

-(IBAction)textFieldDidChange :(UITextField *)textField{
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!IS_STANDARD_IPHONE_6 && !IS_STANDARD_IPHONE_6_PLUS) {
        if (isiPhone5) {
            if (textField == self.txtFieldPassword || textField == self.txtFieldParentsEmailAddress) {
                CGRect viewFrame = self.view.frame;
                viewFrame.origin.y = -40.0f;
                [self.view setFrame:viewFrame];
            }
        }
        else {
            CGRect viewFrame = self.view.frame;
            viewFrame.origin.y = -100.0f;
            [self.view setFrame:viewFrame];
        }
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
    if (textField == self.txtFieldEmailAddress) {
        [self.txtFieldUsername becomeFirstResponder];
    }
    else if (textField == self.txtFieldUsername){
        [self.txtFieldPassword becomeFirstResponder];
    }
    else if (textField == self.txtFieldUnderAgeUsername){
        [self.txtFieldUnderAgePassword becomeFirstResponder];
    }
    else if (textField == self.txtFieldUnderAgePassword){
        [self.txtFieldParentsEmailAddress becomeFirstResponder];
    }
    else
        [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = TRUE;
    if (textField == self.txtFieldUsername || textField == self.txtFieldPassword || textField == self.txtFieldUnderAgeUsername || textField == self.txtFieldUnderAgePassword) {
        if ([string validateAlphanumeric]) {
            shouldChange = TRUE;
        }
        else{
            shouldChange = FALSE;
        }
    }
    return shouldChange;
}


# pragma mark ----- BOABHttpReqDelegates

- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        if([[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionInviteParent]){
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
            if ([responseDict objectForKey:@"success"] && [[responseDict objectForKey:@"success"] objectForKey:@"message"]) {
                [UIAlertView showWithTitle:@""
                                   message:[[responseDict objectForKey:@"success"] objectForKey:@"message"]
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex]) {
                                          
                                      }
                                  }];
            }
            else if ([responseDict objectForKey:@"error"] && [[responseDict objectForKey:@"error"] objectForKey:@"message"]){
                [UIAlertView showWithTitle:@""
                                   message:[[responseDict objectForKey:@"error"] objectForKey:@"message"]
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex]) {
                                      }
                                  }];
            }
        }else{
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
            if (responseDictionary!=nil) {
                if ([responseDictionary objectForKey:@"success"] != nil) {
                    [self launchStepRegistrationWithDictionary:stepOneParamDict];
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
    if (error) {
        
    }
}


@end
