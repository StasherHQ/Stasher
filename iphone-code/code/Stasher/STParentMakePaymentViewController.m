//
//  STParentMakePaymentViewController.m
//  Stasher
//
//  Created by bhushan on 02/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STParentMakePaymentViewController.h"

@interface STParentMakePaymentViewController ()

@end

@implementation STParentMakePaymentViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.labelChildName setTextColor:[UIColor stasherTextColor]];
    UIFont *font1 = [UIFont FontGothamRoundedMediumWithSize:14.0f];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",[self.childDictionary objectForKey:kParamKeyFirstname]] attributes: arialDict];
    
    UIFont *font2 = [UIFont FontGothamRoundedBookWithSize:14.0f];
    NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[self.childDictionary objectForKey:kParamKeyLastname]] attributes: arialDict2];
    
    [aAttrString1 appendAttributedString:aAttrString2];
    self.labelChildName.attributedText = aAttrString1;
    
    if (![[self.childDictionary objectForKey:kParamKeyAvatar] isKindOfClass:[NSNull class]] && ![[self.childDictionary objectForKey:kParamKeyAvatar] isEqualToString:@""]) {
        [self.childAvatarImgView setImageWithURL:[NSURL URLWithString:[self.childDictionary objectForKey:kParamKeyAvatar]] placeholderImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }else{
        [self.childAvatarImgView setImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.headerLabel setFont:[UIFont FontForHeader]];
    self.childAvatarImgView.clipsToBounds = YES;
    self.childAvatarImgView.layer.cornerRadius = self.childAvatarImgView.frame.size.width/2.0f;
    self.childAvatarImgView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.childAvatarImgView.layer.borderWidth=0.5f;
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
    
    [self.oneTimeButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.recurringButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.txtViewMissionDescription setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
    [self.txtViewMissionDescription setFont:[UIFont FontForTextFields]];
    [self.missionDescriptionCharLimit setFont:[UIFont FontGothamRoundedMediumWithSize:9.0f]];
    [self.missionDescriptionCharLimit setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
    [self.txtFieldAmount setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
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

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)oneTimeButtonPressed:(id)sender
{
    if ([self.txtFieldAmount.text validateNotEmpty] && [self.txtViewMissionDescription.text validateNotEmpty]) {
        if ([[STUserIdentity sharedInstance] userKnoxFirstTransactionID]!=nil && ![[[STUserIdentity sharedInstance] userKnoxFirstTransactionID] isEqualToString:@""]) {
            [UIAlertView showWithTitle:@""
                               message:@"Auto Transfer under development"
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              }];
        }else{
            [UIAlertView showWithTitle:@""
                               message:@"Link Bank Account First"
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              }];
        }
    }else{
        NSString *message;
        if (![self.txtFieldAmount.text validateNotEmpty]) {
            message = @"Please enter amount.";
        }else{
            message = @"Please enter description.";
        }
        [UIAlertView showWithTitle:@""
                           message:message
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          }];
    }
}

- (IBAction)recurringButtonPressed:(id)sender
{
    if ([self.txtFieldAmount.text validateNotEmpty]) {
        if ([[STUserIdentity sharedInstance] userKnoxFirstTransactionID]!=nil && ![[[STUserIdentity sharedInstance] userKnoxFirstTransactionID] isEqualToString:@""]) {
            [UIAlertView showWithTitle:@""
                               message:@"Auto Transfer under development"
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              }];
        }else{
            [UIAlertView showWithTitle:@""
                               message:@"Link Bank Account First"
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              }];
        }
    }else{
        NSString *message;
        if (![self.txtFieldAmount.text validateNotEmpty]) {
            message = @"Please enter amount.";
        }else{
            message = @"Please enter description.";
        }
        [UIAlertView showWithTitle:@""
                           message:message
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          }];
    }
}

- (void)rightGestureHandle
{
    [self.navigationController popViewControllerAnimated:YES];
    [STSharedCustoms sharedAddGestureInstanceWithDelegate:nil];
}

- (void)sendKnoxRequestWithAmount:(NSString*)amt transactionType:(NSString*)transactionType
{
    NSLog(@"sendKnoxRequest to OAB Server...");
}

#pragma mark ----- TextView Delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL shouldChange = YES;
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    if (textView == self.txtViewMissionDescription) {
        NSString *missionTitleString = [textView.text stringByAppendingString:text];
        if (missionTitleString.length > 250) {
            shouldChange = NO;
        }
    }
    return shouldChange;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == self.txtViewMissionDescription) {
        if ([self.txtViewMissionDescription.text isEqualToString:@"What's it for?"]) {
            textView.text = @"";
        }
    }
    textView.textColor = [UIColor stasherTextColor];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == self.txtViewMissionDescription) {
        if (![textView.text validateNotEmpty]) {
            textView.textColor = [UIColor stasherTextFieldPlaceHolderColor];
            textView.text = @"What's it for?";
        }
    }
}
# pragma mark ----- Textfield Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!IS_STANDARD_IPHONE_6 && !IS_STANDARD_IPHONE_6_PLUS) {
        if (textField == self.txtFieldAmount) {
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
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length > 0 && ![textField.text containsString:@"$"]) {
        textField.text = [NSString stringWithFormat:@"$%@",textField.text];
    }
    
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = TRUE;
    if (textField == self.txtFieldAmount) {
        if ([string validateNumeric]) {
            shouldChange = TRUE;
        }else if([string containsString:@"."] && ![textField.text containsString:@"."]){
             shouldChange = TRUE;
        }
        else{
            shouldChange = FALSE;
        }
    }
    return shouldChange;
}



@end
