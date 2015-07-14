//
//  STParentAddMissionViewController.m
//  Stasher
//
//  Created by bhushan on 24/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STParentAddMissionViewController.h"

@interface STParentAddMissionViewController ()

@end

@implementation STParentAddMissionViewController

- (void)viewWillAppear:(BOOL)animated
{
    if(self.isEditMode){
        [self.headerLabel setText:@"Edit Mission"];
        [self prePopulateControlsForEditMission];
        [self.assignMissionButton setTitle:@"Save" forState:UIControlStateNormal];
    }else if (self.isMissionDetailMode){
        [self.headerLabel setText:@"Mission Details"];
        [self prePopulateControlsForEditMission];
    }
    else{
        [self.headerLabel setText:@"Add Mission"];
        [self.assignMissionButton setTitle:@"Assign Mission" forState:UIControlStateNormal];
    }
    [self refreshViewForMissionDetails];
    
    [self.buttonSwitchPrivate.titleLabel setFont:[UIFont FontForButtonsWithSize:9.0f]];
    [self.buttonSwitchPublic.titleLabel setFont:[UIFont FontForButtonsWithSize:9.0f]];
    [self.buttonSwitchYes.titleLabel setFont:[UIFont FontForButtonsWithSize:9.0f]];
    [self.buttonSwitchNo.titleLabel setFont:[UIFont FontForButtonsWithSize:9.0f]];
    [self.buttonSwitchCash.titleLabel setFont:[UIFont FontForButtonsWithSize:9.0f]];
    [self.buttonSwitchGift.titleLabel setFont:[UIFont FontForButtonsWithSize:9.0f]];
    [self.labelSelectDueDateTime setFont:[UIFont FontForButtonsWithSize:9.0f]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.scrollViewContainer setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 20.0f)];
    if (!self.requestParamsDictionary) {
        self.requestParamsDictionary = [[NSMutableDictionary alloc] init];
    }
    
    [self.missionSetDateButton setEnabled:YES];
    [self.headerLabel setFont:[UIFont FontForHeader]];
    [self.saveDraftMissionButton.titleLabel setFont:[UIFont FontForButtonsWithSize:13.0f]];
    [self.assignMissionButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    self.dateTimePickerContainerView.clipsToBounds = YES;
    self.dateTimePickerContainerView.layer.cornerRadius = 10.0f;
    self.dateTimePickerContainerView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.dateTimePickerContainerView.layer.borderWidth=1.0f;
    [self.dateTimePickerContainerView setBackgroundColor:[UIColor stasherPopUpBGColor]];
    [self.labelSelectMissionDate setFont:[UIFont FontGothamRoundedMediumWithSize:9.0f]];
    
    [self setUpChildrenScrollView];
    
    for (id txtFields in [self.controlsContainerView subviews]){
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
    self.missionTitleTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    self.missionDescriptionTextView.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    [self.labelMissionDescCharLimit setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
    [self.labelMissionNameCharLimit setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
    [self.labelMissionDescCharLimit setFont:[UIFont FontGothamRoundedWithSize:9.0f]];
    [self.labelMissionNameCharLimit setFont:[UIFont FontGothamRoundedWithSize:9.0f]];
    [self.missionDescriptionTextView setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
    [self.missionDescriptionTextView setFont:[UIFont FontForTextFields]];
    [self.missionSetDateButton.titleLabel setFont:[UIFont FontForTextFields]];
    [self.missionSetDateButton setTitleColor:[UIColor stasherTextFieldPlaceHolderColor] forState:UIControlStateNormal];
    
    [self.labelHeadingSelectChild setFont:[UIFont FontForAddMissionTitles:9.0f]];
    [self.labelHeadingIsTimeBased setFont:[UIFont FontForAddMissionTitles:9.0f]];
    [self.labelHeadingReward setFont:[UIFont FontForAddMissionTitles:9.0f]];
    [self.labelHeadingMissionScope setFont:[UIFont FontForAddMissionTitles:9.0f]];
    
    [self.labelHeadingIsTimeBased setTextColor:[UIColor stasherTextColor]];
    [self.labelHeadingMissionScope setTextColor:[UIColor stasherTextColor]];
    [self.labelHeadingReward setTextColor:[UIColor stasherTextColor]];
    [self.labelHeadingSelectChild setTextColor:[UIColor stasherTextColor]];
    
    [self.buttonDatePickerOk.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.buttonDatePickerCancel.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    
    [self.rewardTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //[[STSharedCustoms sharedAddGestureInstanceWithDelegate:self] addRightSwipeGestureRecognizerToMe];
    
    CGRect rewardSwitchFrame = self.switchRewardType.frame;
    rewardSwitchFrame.origin.x = self.view.frame.size.width - self.rewardCustomSwitch.frame.size.width - 12.0f;
    rewardSwitchFrame.size.width = self.rewardCustomSwitch.frame.size.width;
    rewardSwitchFrame.size.height = self.rewardCustomSwitch.frame.size.height;
    [self.rewardCustomSwitch setFrame:rewardSwitchFrame];
    [self.controlsContainerView addSubview:self.rewardCustomSwitch];
    
    CGRect timeBasedSwitchFrame = self.switchTimeBased.frame;
    timeBasedSwitchFrame.origin.x = self.view.frame.size.width - self.timeBasedCustomSwitchView.frame.size.width - 12.0f;
    timeBasedSwitchFrame.size.width = self.timeBasedCustomSwitchView.frame.size.width;
    timeBasedSwitchFrame.size.height = self.timeBasedCustomSwitchView.frame.size.height;
    [self.timeBasedCustomSwitchView setFrame:timeBasedSwitchFrame];
    [self.controlsContainerView addSubview:self.timeBasedCustomSwitchView];
    
    CGRect scopeSwitchFrame = self.switchMissionScope.frame;
    scopeSwitchFrame.origin.x = self.view.frame.size.width - self.scopeCustomSwitchView.frame.size.width - 12.0f;
    scopeSwitchFrame.size.width = self.scopeCustomSwitchView.frame.size.width;
    scopeSwitchFrame.size.height = self.scopeCustomSwitchView.frame.size.height;
    [self.scopeCustomSwitchView setFrame:scopeSwitchFrame];
    [self.controlsContainerView addSubview:self.scopeCustomSwitchView];
    
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


# pragma mark ----- Actions

- (IBAction)customYesNoSwitchOverlayButtonPressed:(id)sender
{
    if ([self.switchTimeBased isOn]) {
        [self customSwitchNoButtonPressed:nil];
    }else{
        
        [self customSwitchYesButtonPressed:nil];
    }
}

- (IBAction)customCashGiftSwitchOverlayButtonPressed:(id)sender
{
    if ([self.switchRewardType isOn]) {
       
        [self buttonSecondPressed:nil];
    } else {
         [self buttonFirstPressed:nil];
    }
}

- (IBAction)customPublicPrivateSwitchOverlayButtonPressed:(id)sender
{
    if ([self.switchMissionScope isOn]) {
        [self customSwitchPrivateButtonPressed:nil];
    } else {
        [self customSwitchPublicButtonPressed:nil];
    }
}

- (IBAction)buttonFirstPressed:(id)sender
{
    [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
        [self.imgViewGreen setCenter:self.buttonSwitchCash.center];
        [self.switchRewardType setOn:YES];
        [self rewardTypeSwitchValueChanged:self.switchRewardType];
    }];
}

- (IBAction)buttonSecondPressed:(id)sender
{
    [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
        [self.imgViewGreen setCenter:self.buttonSwitchGift.center];
        [self.switchRewardType setOn:NO];
        [self rewardTypeSwitchValueChanged:self.switchRewardType];
    }];
}

- (IBAction)customSwitchYesButtonPressed:(id)sender
{
    [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
        [self.imgViewGreenTimeSwitch setCenter:self.buttonSwitchYes.center];
         [self.switchTimeBased setOn:YES];
        [self timeBasedSwitchValueChanged:self.switchTimeBased];
    }];
}

- (IBAction)customSwitchNoButtonPressed:(id)sender
{
    [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
        [self.imgViewGreenTimeSwitch setCenter:self.buttonSwitchNo.center];
        [self.switchTimeBased setOn:NO];
         [self timeBasedSwitchValueChanged:self.switchTimeBased];
    }];
}

- (IBAction)customSwitchPublicButtonPressed:(id)sender
{
    [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
        [self.imgViewGreenScopeSwitch setCenter:self.buttonSwitchPublic.center];
        [self.switchMissionScope setOn:YES];
        [self missionScopeSwitchSwitchValueChanged:self.switchMissionScope];
    }];
}

- (IBAction)customSwitchPrivateButtonPressed:(id)sender
{
    [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
        [self.imgViewGreenScopeSwitch setCenter:self.buttonSwitchPrivate.center];
        [self.switchMissionScope setOn:NO];
        [self missionScopeSwitchSwitchValueChanged:self.switchMissionScope];
    }];
}

- (IBAction)backButtonPressed:(id)sender
{
    if (self.isMissionDetailMode == FALSE) {
        [UIAlertView showWithTitle:@""
                           message:@"Are you sure you want to exit this screen? Your changes have not been saved."
                 cancelButtonTitle:@"Yes"
                 otherButtonTitles:[NSArray arrayWithObjects:@"No", nil]
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                  [self.navigationController popViewControllerAnimated:YES];
                              }else{
                                  
                              }
                          }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightGestureHandle
{
    [self.navigationController popViewControllerAnimated:YES];
    [STSharedCustoms sharedAddGestureInstanceWithDelegate:nil];
}
- (IBAction)setDateTimeButtonPressed:(id)sender
{
    [self.missionDateTimePicker setMinimumDate:[NSDate date]];
    [self.transparentImageView setHiddenAnimated:NO];
    [self.buttonClosePopUp setHidden:NO];
    [self.dateTimePickerContainerView setHidden:NO];
    [self.view bringSubviewToFront:self.dateTimePickerContainerView];
}
- (IBAction)assignMissionButtonPressed:(id)sender
{
    [self.requestParamsDictionary setObject:@"no" forKey:kAddMissionParamKeyIsDraft];
    [self addMissionSendRequest];
}

- (IBAction)saveAsDraftButtonPressed:(id)sender
{
    [self.requestParamsDictionary setObject:@"yes" forKey:kAddMissionParamKeyIsDraft];
    [self addMissionSendRequest];
}
- (IBAction)timeBasedSwitchValueChanged:(id)sender
{
    if ([self.switchTimeBased isOn]) {
        [self.missionSetDateButton setEnabled:YES];
        [self.labelSelectDueDateTime setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
    }
    else{
         [self.missionSetDateButton setEnabled:NO];
        [self.labelSelectDueDateTime setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
        [self.labelSelectDueDateTime setText:@"Select Due Date and Time"];
    }
}
- (IBAction)rewardTypeSwitchValueChanged:(id)sender
{
    if ([self.switchRewardType isOn]) {
        [self.rewardTextField setPlaceholder:@"Enter reward (numbers only)"];
        [self.rewardTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    }
    else{
       [self.rewardTextField setPlaceholder:@"Enter reward"];
        [self.rewardTextField setKeyboardType:UIKeyboardTypeDefault];
    }
}
- (IBAction)missionScopeSwitchSwitchValueChanged:(id)sender
{
    if ([self.switchMissionScope isOn]) {
        [self.requestParamsDictionary setObject:@"yes" forKey:kAddMissionParamKeyIsPublic];
    }
    else{
        [self.requestParamsDictionary setObject:@"no" forKey:kAddMissionParamKeyIsPublic];
    }
}

- (IBAction)pickerContainerDoneButtonPressed:(id)sender
{
    [self.dateTimePickerContainerView setHidden:YES];
    /*
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
   [dateFormat setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSString *theDate = [dateFormat stringFromDate:self.missionDateTimePicker.date];
    */
    
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"MM/dd/yy hh:mm"];
    [dateFormat2 setTimeZone:[NSTimeZone localTimeZone]];
    NSString *theDate2 = [dateFormat2 stringFromDate:self.missionDateTimePicker.date];
    [self.labelSelectDueDateTime setText:theDate2];
    
    [self.requestParamsDictionary setObject:theDate2 forKey:kAddMissionParamKeyTotalTime];
    
    [self.transparentImageView setHiddenAnimated:YES];
    [self.buttonClosePopUp setHidden:YES];
}

- (IBAction)dobPickerCancelButtonPressed:(id)sender
{
    [self.dateTimePickerContainerView setHidden:YES];
    [self.transparentImageView setHiddenAnimated:YES];
    [self.buttonClosePopUp setHidden:YES];
}

# pragma mark ------ TextView Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL shouldChange = YES;
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    if (textView == self.missionDescriptionTextView) {
        NSString *missionTitleString = [textView.text stringByAppendingString:text];
        if (missionTitleString.length > 250) {
            shouldChange = NO;
        }
    }
    return shouldChange;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == self.missionDescriptionTextView) {
        if ([self.missionDescriptionTextView.text isEqualToString:@"Mission Description (Optional) (Ex: Don’t forget to close the lid of the trash bin when you’re done!)"]) {
            textView.text = @"";
        }
    }
    textView.textColor = [UIColor stasherTextColor];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == self.missionDescriptionTextView) {
        if (![textView.text validateNotEmpty]) {
            textView.textColor = [UIColor stasherTextFieldPlaceHolderColor];
            textView.text = @"Mission Description (Optional) (Ex: Don’t forget to close the lid of the trash bin when you’re done!)";
        }
    }
}


# pragma mark ----- Textfield Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.isMissionDetailMode) {
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!IS_STANDARD_IPHONE_6 && !IS_STANDARD_IPHONE_6_PLUS) {
        if (textField == self.rewardTextField) {
            CGRect viewFrame = self.view.frame;
            viewFrame.origin.y = -120.0f;
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
        if (textField == self.rewardTextField) {
            if ([self.switchRewardType isOn]) {
                if (textField.text.length > 0 && ![textField.text containsString:@"$"]) {
                    [self.rewardTextField setText:[NSString stringWithFormat:@"$%@",self.rewardTextField.text]];
                }
            }
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.rewardTextField) {
        if ([self.switchRewardType isOn]) {
            if (textField.text.length > 0 && ![textField.text containsString:@"$"]) {
                textField.text = [NSString stringWithFormat:@"$%@",textField.text];
            }
        }
    }
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = TRUE;
    if (textField == self.rewardTextField) {
        if ([self.switchRewardType isOn]) {
            if ([string validateNumeric]) {
                shouldChange = TRUE;
            }else if([string containsString:@"."] && ![textField.text containsString:@"."]){
                shouldChange = TRUE;
            }
            else{
                shouldChange = FALSE;
            }
        }
        else{
            if ([string validateAlphanumericSpace]) {
                shouldChange = TRUE;
            }
            else{
                shouldChange = FALSE;
            }
        }
    }
    else if (textField == self.missionTitleTextField){
        NSString *missionTitleString = [textField.text stringByAppendingString:string];
        if (missionTitleString.length > 50) {
            shouldChange = NO;
        }
    }
    return shouldChange;
}

# pragma mark ----- Custom Methods

- (void) setUpChildrenScrollView
{
    NSMutableArray *childrenArray;
    if (self.isMissionDetailMode) {
        childrenArray = [[NSMutableArray alloc] init];
        if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
            [childrenArray addObject:[self.requestParamsDictionary objectForKey:kParamKeyChild]];
        }else{
            [childrenArray addObject:[self.requestParamsDictionary objectForKey:kParamKeyParent]];
        }
        
    }else{
        childrenArray = [[NSMutableArray alloc] initWithArray:[[STUserIdentity sharedInstance] getChildrenArray]];
    }
    
    if (childrenArray && [childrenArray count] > 0) {
        CGRect buttonFrame = CGRectMake(12.0f, 0, 49.0f, 49.0f);
        for(NSDictionary *dict in childrenArray)
        {
            UIButton *childButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [childButton setTag:[[dict objectForKey:kParamKeyUserID] intValue]];
            [childButton setBackgroundColor:[UIColor clearColor]];
            [childButton setFrame:buttonFrame];
            [childButton addTarget:self action:@selector(childButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            if (self.isMissionDetailMode) {
                if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
                    if ([self.requestParamsDictionary objectForKey:kParamKeyChild]) {
                        if ([[self.requestParamsDictionary objectForKey:kParamKeyChild] objectForKey:kParamKeyUserID]) {
                            if ([[dict objectForKey:kParamKeyUserID] intValue] == [[[self.requestParamsDictionary objectForKey:kParamKeyChild] objectForKey:kParamKeyUserID] intValue]) {
                                [self performSelector:@selector(childButtonPressed:) withObject:childButton afterDelay:0.5];
                            }
                        }
                    }
                }else{
                    if ([self.requestParamsDictionary objectForKey:kParamKeyParent]) {
                        if ([[self.requestParamsDictionary objectForKey:kParamKeyParent] objectForKey:kParamKeyUserID]) {
                            if ([[dict objectForKey:kParamKeyUserID] intValue] == [[[self.requestParamsDictionary objectForKey:kParamKeyParent] objectForKey:kParamKeyUserID] intValue]) {
                                [self performSelector:@selector(childButtonPressed:) withObject:childButton afterDelay:0.5];
                            }
                        }
                    }
                }
            }else{
                if ([self.requestParamsDictionary objectForKey:kParamKeyChild]) {
                    if ([[self.requestParamsDictionary objectForKey:kParamKeyChild] objectForKey:kParamKeyUserID]) {
                        if ([[dict objectForKey:kParamKeyUserID] intValue] == [[[self.requestParamsDictionary objectForKey:kParamKeyChild] objectForKey:kParamKeyUserID] intValue]) {
                            [self performSelector:@selector(childButtonPressed:) withObject:childButton afterDelay:0.5];
                        }
                    }
                }else{
                        [self performSelector:@selector(childButtonPressed:) withObject:childButton afterDelay:0.5];
                }
            }
            
            UIImageView *profilePicImageView = [[UIImageView alloc] initWithFrame:childButton.frame];
            if (![[dict objectForKey:kParamKeyAvatar] isKindOfClass:[NSNull class]]) {
                [profilePicImageView setImageWithURL:[NSURL URLWithString:[dict objectForKey:kParamKeyAvatar]] placeholderImage:[UIImage imageNamed:@"Stasher_FacePlaceHolder"]];
            }
            CGRect imgViewFrame = profilePicImageView.frame;
            imgViewFrame.size.width = 48.0f;
            imgViewFrame.size.height = 48.0f;
            [profilePicImageView setFrame:imgViewFrame];
            
            UILabel *childNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonFrame.origin.x, 52.0f, 49.0f, 80.0f)];
            [childNameLabel setNumberOfLines:0];
            if (self.isMissionDetailMode) {
                [childNameLabel setText:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:kParamKeyFirstname],[dict objectForKey:kParamKeyLastname]]];
            }else{
                [childNameLabel setText:[dict objectForKey:kParamKeyUsername]];
            }
            
            [childNameLabel setTextColor:[UIColor stasherTextColor]];
            [childNameLabel setFont:[UIFont FontGothamRoundedMediumWithSize:11.0f]];
            [self.scrollViewChildrens addSubview:childNameLabel];
            [childNameLabel setTextAlignment:NSTextAlignmentCenter];
            [childNameLabel sizeToFit];
            [childNameLabel setCenter:CGPointMake(profilePicImageView.center.x, childNameLabel.center.y)];
            [self.scrollViewChildrens addSubview:profilePicImageView];
            [self.scrollViewChildrens addSubview:childButton];
            childButton.clipsToBounds = YES;
            childButton.layer.cornerRadius = childButton.frame.size.width/2.0f;
            childButton.layer.borderColor=[UIColor clearColor].CGColor;
            childButton.layer.borderWidth=2.0f;
            profilePicImageView.clipsToBounds = YES;
            profilePicImageView.layer.cornerRadius = childButton.frame.size.width/2.0f;
            profilePicImageView.contentMode = UIViewContentModeScaleAspectFill;
            profilePicImageView.layer.borderColor=[UIColor clearColor].CGColor;
            profilePicImageView.layer.borderWidth=2.0f;
            buttonFrame.origin.x+=buttonFrame.size.width + 8.0f;
        }
        CGSize contentSize = self.scrollViewChildrens.frame.size;
        contentSize.width = buttonFrame.origin.x;
        [self.scrollViewChildrens setContentSize:contentSize];
    }
    childrenArray = nil;
}

- (void)childButtonPressed:(id)sender
{
    if (self.isMissionDetailMode == TRUE) {
        return;
    }
    UIButton *btn = (UIButton*) sender;
    if (!childBUttonArray) {
        childBUttonArray = [[NSMutableArray alloc] init];
    }
    if (!childIdsArray) {
        childIdsArray = [[NSMutableArray alloc] init];
    }

    if (![childBUttonArray containsObject:btn]) {
        //[btn setBackgroundColor:[UIColor greenColor]];
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = btn.frame.size.width/2.0f;
        btn.layer.borderColor=[UIColor colorWithRed:101.0f/255 green:194.0f/255 blue:15.0f/255 alpha:1.0].CGColor;
        btn.layer.borderWidth=2.0f;
        [childBUttonArray addObject:btn];
        if (!childIdsArray) {
            childIdsArray = [[NSMutableArray alloc] init];
        }
        [childIdsArray addObject:[NSNumber numberWithInteger:btn.tag]];
    }
    else{
        //[btn setBackgroundColor:[UIColor clearColor]];
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = btn.frame.size.width/2.0f;
        btn.layer.borderColor=[UIColor clearColor].CGColor;
        btn.layer.borderWidth=2.0f;
        [childBUttonArray removeObject:btn];
        [childIdsArray removeObject:[NSNumber numberWithInteger:btn.tag]];
    }
}

- (void) addMissionSendRequest
{
    if (![self.missionTitleTextField.text validateNotEmpty]) {
        [UIAlertView showWithTitle:@""
                           message:@"Enter Mission Title"
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                  
                              }
                          }];
        return;
    }
    if (![self.rewardTextField.text validateNotEmpty]) {
        [UIAlertView showWithTitle:@""
                           message:@"Enter Reward"
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                  
                              }
                          }];
        return;
    }
    
    if (childIdsArray == nil || [childIdsArray count] == 0) {
        [UIAlertView showWithTitle:@""
                           message:@"Choose child for mission"
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                  
                              }
                          }];
        return;
    }
    

    if ([self.switchTimeBased isOn]) {
        [self.requestParamsDictionary setObject:@"yes" forKey:kAddMissionParamKeyIsTimeBased];
    }
    else{
        [self.requestParamsDictionary setObject:@"no" forKey:kAddMissionParamKeyIsTimeBased];
    }
    if ([self.switchRewardType isOn]) {
        [self.requestParamsDictionary setObject:@"cash" forKey:kAddMissionParamKeyRewardType];
    }
    else{
        [self.requestParamsDictionary setObject:@"gift" forKey:kAddMissionParamKeyRewardType];
    }
    if ([self.switchMissionScope isOn]) {
        [self.requestParamsDictionary setObject:@"yes" forKey:kAddMissionParamKeyIsPublic];
    }
    else{
        [self.requestParamsDictionary setObject:@"no" forKey:kAddMissionParamKeyIsPublic];
    }
    [self.requestParamsDictionary setObject:self.missionTitleTextField.text forKey:kAddMissionParamKeyTitle];
    if (![self.missionDescriptionTextView.text isEqualToString:@"Mission Description (Optional) (Ex: Don’t forget to close the lid of the trash bin when you’re done!)"]) {
        [self.requestParamsDictionary setObject:self.missionDescriptionTextView.text forKey:kAddMissionParamKeyDescription];
    }
    [self.requestParamsDictionary setObject:[NSNumber numberWithInt:[[[STUserIdentity sharedInstance] userId] intValue]] forKey:kParamKeyParentID];
    [self.requestParamsDictionary setObject:[childIdsArray componentsJoinedByString:@","] forKey:kParamKeyChildID];
    [self.requestParamsDictionary setObject:[self.rewardTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]] forKey:kAddMissionParamKeyRewards];
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dtStr = [dateFormat stringFromDate:[NSDate date]];
    
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    [dateFormat2 setTimeZone:[NSTimeZone localTimeZone]];
    
    
    [self.requestParamsDictionary setObject:[dateFormat2 stringFromDate:[dateFormat dateFromString:dtStr]] forKey:@"inserted_date"];
    
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    if(! self.isEditMode)
        [self.requestParamsDictionary setObject:kAPIActionAddMission forKey:kParamKeyAction];
    else
        [self.requestParamsDictionary setObject:kAPIActionEditMission forKey:kParamKeyAction];
    
    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:self.requestParamsDictionary json:YES];
}

- (void) editMissionRefreshViewWithDictionary:(NSDictionary*)dict
{
    self.requestParamsDictionary = [NSMutableDictionary dictionaryWithDictionary:dict];
}

- (void)refreshViewForMissionDetails
{
    if (self.isMissionDetailMode) {
        [self.assignMissionButton setHidden:YES];
        [self.missionDescriptionTextView setEditable:NO];
        [self.missionDateTimePicker setEnabled:NO];
        [self.missionSetDateButton setEnabled:NO];
        [self.rewardCustomSwitch setUserInteractionEnabled:NO];
        [self.rewardCustomSwitch setAlpha:0.7];
        [self.scopeCustomSwitchView setUserInteractionEnabled:NO];
        [self.scopeCustomSwitchView setAlpha:0.7];
        [self.timeBasedCustomSwitchView setUserInteractionEnabled:NO];
        [self.timeBasedCustomSwitchView setAlpha:0.7];
        if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
            [self.labelHeadingSelectChild setText:@"Mission Assigned to:"];
        }else{
            [self.labelHeadingSelectChild setText:@"Mission Assigned by:"];
        }
        [self.labelSelectDueDateTime setTextColor:[UIColor stasherTextColor]];
        
    }else{
        [self.assignMissionButton setHidden:NO];
        [self.missionDescriptionTextView setEditable:YES];
        [self.missionDateTimePicker setEnabled:YES];
        [self.missionSetDateButton setEnabled:YES];
        [self.rewardCustomSwitch setUserInteractionEnabled:YES];
        [self.rewardCustomSwitch setAlpha:1];
        [self.scopeCustomSwitchView setUserInteractionEnabled:YES];
        [self.scopeCustomSwitchView setAlpha:1];
        [self.timeBasedCustomSwitchView setUserInteractionEnabled:YES];
        [self.timeBasedCustomSwitchView setAlpha:1];
        [self.labelSelectDueDateTime setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
    }
}

- (void)prePopulateControlsForEditMission
{
    if ([self.requestParamsDictionary objectForKey:kAddMissionParamKeyTitle]) {
        [self.missionTitleTextField setTextColor:[UIColor stasherTextColor]];
        [self.missionTitleTextField setText:[self.requestParamsDictionary objectForKey:kAddMissionParamKeyTitle]];
    }
    
    if ([self.requestParamsDictionary objectForKey:kAddMissionParamKeyDescription]) {
        [self.missionDescriptionTextView setTextColor:[UIColor stasherTextColor]];
        [self.missionDescriptionTextView setText:[self.requestParamsDictionary objectForKey:kAddMissionParamKeyDescription]];
    }
    
    if ([self.requestParamsDictionary objectForKey:kAddMissionParamKeyIsPublic]) {
        if ([[self.requestParamsDictionary objectForKey:kAddMissionParamKeyIsPublic] isEqualToString:@"yes"]) {
            [self.switchMissionScope setOn:YES];
        }
        else{
            [self.switchMissionScope setOn:NO];
        }
    }
    
    if ([self.requestParamsDictionary objectForKey:kAddMissionParamKeyIsTimeBased]) {
        if ([[self.requestParamsDictionary objectForKey:kAddMissionParamKeyIsTimeBased] isEqualToString:@"yes"]) {
            [self.switchTimeBased setOn:YES];
            if ([self.requestParamsDictionary objectForKey:kAddMissionParamKeyTotalTime]) {
                [self.labelSelectDueDateTime setText:[self.requestParamsDictionary objectForKey:kAddMissionParamKeyTotalTime]];
                NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                [dateFormat2 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
                [dateFormat2 setTimeZone:[NSTimeZone localTimeZone]];
                NSDate *theDate2 = [dateFormat2 dateFromString:[self.requestParamsDictionary objectForKey:kAddMissionParamKeyTotalTime]];
                NSDateFormatter *dateFormat3 = [[NSDateFormatter alloc] init];
                [dateFormat3 setDateFormat:@"MM/dd/yy hh:mm"];
                [dateFormat3 setTimeZone:[NSTimeZone localTimeZone]];
                [self.labelSelectDueDateTime setText:[dateFormat3 stringFromDate:theDate2]];
            }
        }
        else{
            [self.switchTimeBased setOn:NO];
        }
    }
    
    if ([self.requestParamsDictionary objectForKey:kAddMissionParamKeyRewardType]) {
        if ([[self.requestParamsDictionary objectForKey:kAddMissionParamKeyRewardType] isEqualToString:@"cash"]) {
            if ([self.requestParamsDictionary objectForKey:kAddMissionParamKeyRewards]) {
                [self.rewardTextField setText:[NSString stringWithFormat:@"$%@",[self.requestParamsDictionary objectForKey:kAddMissionParamKeyRewards]]];
            }
            [self.switchRewardType setOn:YES];
        }
        else{
            if ([self.requestParamsDictionary objectForKey:kAddMissionParamKeyRewards]) {
                [self.rewardTextField setText:[self.requestParamsDictionary objectForKey:kAddMissionParamKeyRewards]];
            }
            [self.switchRewardType setOn:NO];
        }
    }
    
    
}

# pragma mark ----- BOABHttpReqDelegates

- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if (responseDictionary!=nil) {
            if ([responseDictionary objectForKey:@"success"]) {
                [UIAlertView showWithTitle:@""
                                   message:[[responseDictionary objectForKey:@"success"] objectForKey:@"message"]
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex]) {
                                          if ([self.delegate respondsToSelector:@selector(missionUpdatedAdded)]) {
                                              [self.delegate missionUpdatedAdded];
                                              [self.navigationController popViewControllerAnimated:YES];
                                          }
                                      }
                                  }];
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
