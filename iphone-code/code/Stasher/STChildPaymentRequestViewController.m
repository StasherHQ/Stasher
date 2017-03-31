//
//  STChildPaymentRequestViewController.m
//  Stasher
//
//  Created by bhushan on 03/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STChildPaymentRequestViewController.h"

@interface STChildPaymentRequestViewController ()

@end

@implementation STChildPaymentRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.headerLabel setFont:[UIFont FontForHeader]];
    [self.requestButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
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
    [self.txtViewMissionDescription setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
    [self.txtViewMissionDescription setFont:[UIFont FontForTextFields]];
    [self.missionDescriptionCharLimit setFont:[UIFont FontGothamRoundedMediumWithSize:9.0f]];
    [self.missionDescriptionCharLimit setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
    [self.txtFieldAmount setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[STSharedCustoms sharedAddGestureInstanceWithDelegate:self] addRightSwipeGestureRecognizerToMe];
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

- (IBAction)requestPaymentButtonPressed:(id)sender
{
    if (![self.txtFieldAmount.text validateNotEmpty]) {
        [UIAlertView showWithTitle:@""
                           message:@"Enter Amount!"
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              
                          }];
    }else if (![self.txtViewMissionDescription.text validateNotEmpty] || [self.txtViewMissionDescription.text isEqualToString:@"What's it for?"]){
        [UIAlertView showWithTitle:@""
                           message:@"Enter Mission Description!"
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              
                          }];
    }else{
        [self requestPaymentServerCall];
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
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length > 0 && ![textField.text containsString:@"$"]) {
        textField.text = [NSString stringWithFormat:@"$%@",textField.text];
    }
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


# pragma mark ----- Request Server

- (void) requestPaymentServerCall
{
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    if ([[STUserIdentity sharedInstance] userId] != nil) {
        [paramDict setObject:[self.parentInfoDict objectForKey:kParamKeyUserID] forKey:kParamKeyParentID];
        [paramDict setObject:[[STUserIdentity sharedInstance] userId] forKey:kParamKeyChildID];
        [paramDict setObject:[self.txtViewMissionDescription text] forKey:kParamKeyComment];
        [paramDict setObject:[self.txtFieldAmount text] forKey:kParamKeyComment];
        [paramDict setObject:kAPIActionChildRequestPayment forKey:kParamKeyAction];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
        paramDict = nil;
    }
}

# pragma mark ----- BOABHttpReqDelegates

- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if (responseDictionary) {
            {
                if ([responseDictionary objectForKey:@"success"]) {
                    [UIAlertView showWithTitle:@""
                                       message:[[responseDictionary objectForKey:@"success"] objectForKey:@"message"]
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          [self.navigationController popViewControllerAnimated:YES];
                                      }];
                }
                else if ([responseDictionary objectForKey:@"error"]) {
                    [UIAlertView showWithTitle:@""
                                       message:[[responseDictionary objectForKey:@"error"] objectForKey:@"message"]
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          [self.navigationController popViewControllerAnimated:YES];
                                      }];
                }
            }
        }
    }
}


@end
