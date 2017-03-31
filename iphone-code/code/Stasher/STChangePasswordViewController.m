//
//  STChangePasswordViewController.m
//  Stasher
//
//  Created by bhushan on 19/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STChangePasswordViewController.h"

@interface STChangePasswordViewController ()

@end

@implementation STChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.headerlabel setFont:[UIFont FontForHeader]];
    [self.buttonSave.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
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

- (void)rightGestureHandle
{
    [self.navigationController popViewControllerAnimated:YES];
    [STSharedCustoms sharedAddGestureInstanceWithDelegate:nil];
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

- (IBAction)savePasswordChangeButtonPressed:(id)sender
{
   
    if (!self.changPasswordParamDictionary) {
        self.changPasswordParamDictionary = [[NSMutableDictionary alloc] init];
    }
    [self.changPasswordParamDictionary setObject:self.txtFieldOldPassword.text forKey:kChangePasswordParamKeyOldPassword];
    [self.changPasswordParamDictionary setObject:self.txtFieldNewPassword.text forKey:kChangePasswordParamKeyNewPassword];
    [self.changPasswordParamDictionary setObject:self.txtFieldConfirmPassword.text forKey:kChangePasswordParamKeyConfirmPassword];
    if([[STUserIdentity sharedInstance] userId])
        [self.changPasswordParamDictionary setObject:[[STUserIdentity sharedInstance] userId] forKey:kParamKeyUserID];
    [self.changPasswordParamDictionary setObject:kAPIActionChangePassword forKey:kParamKeyAction];
    
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:self.changPasswordParamDictionary json:YES];
}

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----- Custom Methods

- (void)popChangePasswordController
{
    if ([self.delegate respondsToSelector:@selector(passwordHasBeenChanged)]) {
        [self.delegate passwordHasBeenChanged];
    }
}


#pragma mark ----- Textfield Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtFieldOldPassword) {
        [self.txtFieldNewPassword becomeFirstResponder];
    }
    else if (textField == self.txtFieldNewPassword){
        [self.txtFieldConfirmPassword becomeFirstResponder];
    }
    else
        [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = TRUE;
    if (textField == self.txtFieldOldPassword || textField == self.txtFieldNewPassword || textField == self.txtFieldConfirmPassword) {
        if ([string validateAlphanumeric]) {
            shouldChange = TRUE;
        }
        else{
            shouldChange = FALSE;
        }
    }
    return shouldChange;
}

#pragma mark - BOABHttpReqDelegates
- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if ([responseDict objectForKey:@"success"]) {
            [UIAlertView showWithTitle:@""
                               message:[[responseDict objectForKey:@"success"] objectForKey:@"message"]
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  if (buttonIndex == [alertView cancelButtonIndex]) {
                                      [self.navigationController popViewControllerAnimated:YES];
                                      [self performSelector:@selector(popChangePasswordController) withObject:nil afterDelay:0.5];
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
