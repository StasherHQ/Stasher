//
//  STForgotPasswordViewController.m
//  Stasher
//
//  Created by bhushan on 14/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STForgotPasswordViewController.h"

@interface STForgotPasswordViewController ()

@end

@implementation STForgotPasswordViewController
@synthesize delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.txtFieldusernameMailId setFont:[UIFont FontForTextFields]];
    self.txtFieldusernameMailId.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.txtFieldusernameMailId.placeholder
                                                                      attributes:@{
                                                                                   NSForegroundColorAttributeName:[UIColor colorWithRed:125.0f/255 green:125.0f/255 blue:125.0f/255 alpha:1.0f],
                                                                                   NSFontAttributeName : [UIFont FontForTextFields]
                                                                                   }
                                       ];
    self.txtFieldusernameMailId.textColor = [UIColor stasherTextColor];
    self.popUpContainerView.clipsToBounds = YES;
    self.popUpContainerView.layer.cornerRadius = 10.0f;
    self.popUpContainerView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.popUpContainerView.layer.borderWidth=1.0f;
    [self.okButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.cancelButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
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

- (IBAction)sendPasswordButtonPressed:(id)sender
{
    if ([self.txtFieldusernameMailId.text validateNotEmpty]) {
        if ([self.txtFieldusernameMailId.text validateAlphanumeric] || [self.txtFieldusernameMailId.text validateEmail]) {
            BOABHttpReq *httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
            [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:self.txtFieldusernameMailId.text,kParamKeyUsername,kAPIActionForgotPassword,kParamKeyAction, nil] json:YES];
        }
        else{
            [UIAlertView showWithTitle:@""
                               message:@"Enter a valid E-mail address or Username."
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  if (buttonIndex == [alertView cancelButtonIndex]) {
                                      [self.txtFieldusernameMailId becomeFirstResponder];
                                  }
                              }];
        }
    }
    else{
        [UIAlertView showWithTitle:@""
                           message:@"Enter a E-mail address or Username."
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                  [self.txtFieldusernameMailId becomeFirstResponder];
                              }
                          }];
    }
}

- (IBAction)forgePasswordCancelButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(forgetpasswordCanceled)]) {
        [self.delegate forgetpasswordCanceled];
    }
}

#pragma mark ----- Textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = TRUE;
    return shouldChange;
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
                                          if ([self.delegate respondsToSelector:@selector(sendPaswordToEmailButtonPressed)]) {
                                              [self.delegate sendPaswordToEmailButtonPressed];
                                          }
                                      }
                                  }];
            }
            else if ([responseDictionary objectForKey:@"error"]){
                [UIAlertView showWithTitle:@""
                                   message:[[responseDictionary objectForKey:@"error"] objectForKey:@"message"]
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex]) {
                                          if ([self.delegate respondsToSelector:@selector(sendPaswordToEmailButtonPressed)]) {
                                              [self.delegate sendPaswordToEmailButtonPressed];
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
