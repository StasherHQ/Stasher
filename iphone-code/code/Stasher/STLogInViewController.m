//
//  STLogInViewController.m
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STLogInViewController.h"
#import "STBaseTabBarController.h"

@interface STLogInViewController ()

@end

@implementation STLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.headerLabel setFont:[UIFont FontGothamRoundedMediumWithSize:16.0f]];
    [self.txtFieldPassword setFont:[UIFont FontForTextFields]];
    [self.txtFieldPassword setTextColor:[UIColor stasherTextColor]];
    [self.txtFieldUsernameId setFont:[UIFont FontForTextFields]];
    [self.txtFieldUsernameId setTextColor:[UIColor stasherTextColor]];
    [self.txtFieldPassword setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.txtFieldUsernameId setAutocorrectionType:UITextAutocorrectionTypeNo];
    self.txtFieldPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.txtFieldPassword.placeholder
                                                                      attributes:@{
                                                                                   NSForegroundColorAttributeName:[UIColor stasherTextFieldPlaceHolderColor],
                                                                                   NSFontAttributeName : [UIFont FontForTextFields]
                                                                                   }];
    self.txtFieldUsernameId.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.txtFieldUsernameId.placeholder
                                                                                  attributes:@{
                                                                                               NSForegroundColorAttributeName:[UIColor stasherTextFieldPlaceHolderColor],
                                                                                               NSFontAttributeName : [UIFont FontForTextFields]
                                                                                               }];
    
    [self.logInButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0]];
    [self.forgotPasswordButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0]];
    [self.forgotPasswordButton.titleLabel setTextColor:[UIColor stasherTextColor]];
    if (IS_STANDARD_IPHONE_6) {
        [self.logInViaFacebooButtonk.titleLabel setFont:[UIFont FontForButtonsWithSize:8.0f]];
    }else{
        [self.logInViaFacebooButtonk.titleLabel setFont:[UIFont FontForButtonsWithSize:10.0f]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark ----- Actions

- (IBAction)logInButtonPressed:(id)sender
{
    [self.view setUserInteractionEnabled:NO];
    [self.txtFieldPassword resignFirstResponder];
    [self performSelector:@selector(logIn) withObject:self afterDelay:0.05];
}

- (void)logIn
{
    if ([self.txtFieldPassword.text validateNotEmpty] && [self.txtFieldUsernameId.text validateNotEmpty]) {
        if ([self.txtFieldUsernameId.text validateEmail] || [self.txtFieldUsernameId.text validateNotEmpty]) {
            httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
            NSMutableDictionary *paramsDict = [[NSMutableDictionary alloc] init];
            [paramsDict setObject:self.txtFieldUsernameId.text forKey:kParamKeyUsername];
            [paramsDict setObject:self.txtFieldPassword.text forKey:kParamKeyPassword];
            [paramsDict setObject:kAPIActionLogin forKey:kParamKeyAction];
            [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramsDict json:YES];
        }
        else{
            [UIAlertView showWithTitle:@""
                               message:@"Enter a valid E-mail address."
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  if (buttonIndex == [alertView cancelButtonIndex]) {
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
- (IBAction)forgotPasswordButtonPressed:(id)sender
{
    forgotPasswordVC = [[STForgotPasswordViewController alloc] initWithNibName:@"STForgotPasswordViewController" bundle:[NSBundle mainBundle]];
    forgotPasswordVC.delegate = self;
    [forgotPasswordVC.view setFrame:self.view.frame];
    [self.view addSubview:forgotPasswordVC.view withAnimation:YES];
}

- (IBAction)LogInViaFacebookButtonPressed:(id)sender
{
    [[STLogInManager sharedInstance] setDelegate:self];
    [[STLogInManager sharedInstance] openSessionWithAllowLoginUI:YES];
}

- (void) sendPaswordToEmailButtonPressed
{
    if (forgotPasswordVC != nil) {
        [forgotPasswordVC.view removeFromSuperviewwithAnimation:YES];
    }
}

- (void) forgetpasswordCanceled
{
    if (forgotPasswordVC != nil) {
        [forgotPasswordVC.view removeFromSuperviewwithAnimation:YES];
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

#pragma mark ----- Custom Methods
- (void) launchUserBaseTabsScreen
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STBaseTabBarController *baseTabBarController = [storyboard instantiateViewControllerWithIdentifier:@"STBaseTabBarController"];
    [self.navigationController pushViewController:baseTabBarController animated:YES];
}

#pragma mark ----- Textfield Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtFieldUsernameId) {
        [self.txtFieldPassword becomeFirstResponder];
    }
    else
        [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = TRUE;
    if (textField == self.txtFieldPassword) {
        if ([string validateAlphanumeric]) {
            shouldChange = TRUE;
        }
        else{
            shouldChange = FALSE;
        }
    }
    
    return shouldChange;
}

#pragma mark ----- LogInManagerDelegate

- (void)facebookLogInSuccessfulWithUserDictionary:(NSDictionary *)userInfoDict
{
    NSLog(@"facebooklogIn Dict %@",userInfoDict);
    
    if (userInfoDict != nil) {
        NSMutableDictionary* localUserInfoDict = [[NSMutableDictionary alloc] init];
        [localUserInfoDict setObject:[userInfoDict objectForKey:@"first_name"] forKey:kParamKeyFirstname];
        [localUserInfoDict setObject:[userInfoDict objectForKey:@"last_name"] forKey:kParamKeyLastname];
        [localUserInfoDict setObject:[userInfoDict objectForKey:@"gender"] forKey:kParamKeyGender];
        [localUserInfoDict setObject:[userInfoDict objectForKey:@"email"] forKey:kParamKeyEmail];
        //[localUserInfoDict setObject:[[userInfoDict objectForKey:@"location"] objectForKey:@"name"] forKey:kParamKeyCountry];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
        NSDate *theDate = [dateFormat dateFromString:[userInfoDict objectForKey:@"birthday"]];
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
        if ([dateFormat2 stringFromDate:theDate])
            [localUserInfoDict setObject:[dateFormat2 stringFromDate:theDate] forKey:kParamKeyDateOfBirth];
        if ([[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture",[userInfoDict objectForKey:@"id"]]]] base64EncodedStringWithOptions:0] != nil) {
            [localUserInfoDict setObject:[[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture",[userInfoDict objectForKey:@"id"]]]] base64EncodedStringWithOptions:0]  forKey:kParamKeyAvatar];
        }
        if (httpReq) {
            httpReq.delegate = nil;
            httpReq = nil;
        }
        httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
        [localUserInfoDict setObject:kAPIActionFacebookLogIn forKey:kParamKeyAction];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:localUserInfoDict json:YES];
    }
}


#pragma mark - BOABHttpReqDelegates

- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    [self.view setUserInteractionEnabled:YES];
     NSString *actionName = [[conn.userInfo objectForKey:KParamsKey] objectForKey:kParamKeyAction];
    if ([actionName isEqualToString:kAPIActionFacebookLogIn]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"IsFaceBookLogIn"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"IsFaceBookLogIn"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (resonseData) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if (responseDictionary) {
            if ([responseDictionary objectForKey:@"usedetails"] && [[responseDictionary objectForKey:@"usedetails"] isKindOfClass:[NSDictionary class]]) {
                [[STUserIdentity sharedInstance] setUserInformationDictionary:[[responseDictionary objectForKey:@"usedetails"] mutableCopy]];
                NSMutableDictionary *logInInfoDictionary = [[responseDictionary objectForKey:@"usedetails"] mutableCopy];
                [logInInfoDictionary setObject:[NSNumber numberWithInt:1] forKey:kUserDefaultsIsUserLoggedIn];
                [[STLogInManager sharedInstance] updateUserDefaultsInLogInManagerWithDictionary:logInInfoDictionary];
                [self launchUserBaseTabsScreen];
            }
            else if ([responseDictionary objectForKey:@"error"]){
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

- (void)BOABHttpReqFailedWithError:(NSError*)error
{
    [self.view setUserInteractionEnabled:YES];
    if (error) {
        
    }
}


@end
