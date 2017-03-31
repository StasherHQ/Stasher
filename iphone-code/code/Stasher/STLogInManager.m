//
//  STLogInManager.m
//  Stasher
//
//  Created by bhushan on 14/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STLogInManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


NSString *const SCSessionStateChangedNotification = @"com.oabtesting.FacebookLogin:SCSessionStateChangedNotification";

static STLogInManager* __instance = nil;

@implementation STLogInManager
+(STLogInManager*) sharedInstance
{
    @synchronized(self) {
        if ( __instance == nil ) {
            __instance = [[STLogInManager alloc] init];
        }
        return __instance;
    }
}

- (BOOL)isUserLoggedIn
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsIsUserLoggedIn]!=nil) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsIsUserLoggedIn] boolValue] == YES) {
            return YES;
        }
    }
    
    return NO;
}

- (void)setDelegate:(id<LogInManagerDelegate>)delegate
{
    _delegate = delegate;
}

- (void)updateUserDefaultsInLogInManagerWithDictionary:(NSDictionary*)logInCredentialsDict
{
   if([logInCredentialsDict objectForKey:kUserDefaultsIsUserLoggedIn] != nil)
       [[NSUserDefaults standardUserDefaults] setObject:[logInCredentialsDict objectForKey:kUserDefaultsIsUserLoggedIn] forKey:kUserDefaultsIsUserLoggedIn];
    
   if([logInCredentialsDict objectForKey:kParamKeyEmail] != nil)
       [[NSUserDefaults standardUserDefaults] setObject:[logInCredentialsDict objectForKey:kParamKeyEmail] forKey:kUserDefaultsLoggedInEmailId];
    
    if([logInCredentialsDict objectForKey:kParamKeyUsername] != nil)
        [[NSUserDefaults standardUserDefaults] setObject:[logInCredentialsDict objectForKey:kParamKeyUsername] forKey:kUserDefaultsLoggedInusername];
    
    if ([logInCredentialsDict objectForKey:kParamKeyUserType] != nil) {
        if ([[logInCredentialsDict objectForKey:kParamKeyUserType] intValue] == 3) {
            [[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:kUserDefaultsUserType];
        }
        if ([[logInCredentialsDict objectForKey:kParamKeyUserType] intValue] == 4) {
            [[NSUserDefaults standardUserDefaults] setObject:@"4" forKey:kUserDefaultsUserType];
        }
    }
    
    if([logInCredentialsDict objectForKey:kParamKeyFirstname] != nil)
        [[NSUserDefaults standardUserDefaults] setObject:[logInCredentialsDict objectForKey:kParamKeyFirstname] forKey:kUserDefaultsUserFirstName];
    
    if([logInCredentialsDict objectForKey:kParamKeyLastname] != nil)
        [[NSUserDefaults standardUserDefaults] setObject:[logInCredentialsDict objectForKey:kParamKeyLastname] forKey:kUserDefaultsUserLastName];
    
    if([logInCredentialsDict objectForKey:kParamKeyUserID] != nil)
        [[NSUserDefaults standardUserDefaults] setObject:[logInCredentialsDict objectForKey:kParamKeyUserID] forKey:kUserDefaultsUserId];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)logOut
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultsIsUserLoggedIn];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultsLoggedInEmailId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultsLoggedInusername];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultsUserType];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultsUserFirstName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultsUserLastName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultsUserId];
    [[STUserIdentity sharedInstance] flushUserInfoIdentity];
    FBSDKLoginManager *logMeOut = [[FBSDKLoginManager alloc] init];
    [logMeOut logOut];
    
    if ([self.delegate respondsToSelector:@selector(userLoggedOutSuccessfully)]) {
        [self.delegate userLoggedOutSuccessfully];
    }
}


#pragma mark ----- The Facebook

- (void)loginSuccessWithFacebook
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"id,first_name,last_name,email,gender" forKey:@"fields"];
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 [[NSUserDefaults standardUserDefaults] setValue:[result objectForKey:@"id"] forKey:@"FBUserId"];
                 [[NSUserDefaults standardUserDefaults] setValue:[result objectForKey:@"first_name"] forKey:@"FBUserName"];
                 [[NSUserDefaults standardUserDefaults] setValue:[result objectForKey:@"last_name"] forKey:@"FBLastName"];
                 [[NSUserDefaults standardUserDefaults] setValue:[result objectForKey:@"email"] forKey:@"FBUserEmail"];
                 
                 if ([__instance.delegate respondsToSelector:@selector(facebookLogInSuccessfulWithUserDictionary:)])
                 {
                     [__instance.delegate facebookLogInSuccessfulWithUserDictionary:result];
                 }
             }
         }];
    }
    else
    {
        FBSDKLoginManager *logMeOut = [[FBSDKLoginManager alloc] init];
        [logMeOut logOut];
    }
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:SCSessionStateChangedNotification
//                                                        object:session];
//    
//    if (error) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error: %@",
//                                                                     [STLogInManager FBErrorCodeDescription:error.code]]
//                                                            message:error.localizedDescription
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//        [self fbResync];
//        
//    }
}

-(void)fbResync
{
//    ACAccountStore *accountStore;
//    ACAccountType *accountTypeFB;
//    if ((accountStore = [[ACAccountStore alloc] init]) && (accountTypeFB = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook] ) ){
//        
//        NSArray *fbAccounts = [accountStore accountsWithAccountType:accountTypeFB];
//        id account;
//        if (fbAccounts && [fbAccounts count] > 0 && (account = [fbAccounts objectAtIndex:0])){
//            
//            [accountStore renewCredentialsForAccount:account completion:^(ACAccountCredentialRenewResult renewResult, NSError *error) {
//                //we don't actually need to inspect renewResult or error.
//                if (error){
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error: %@",
//                                                                                 [STLogInManager FBErrorCodeDescription:error.code]]
//                                                                        message:error.localizedDescription
//                                                                       delegate:nil
//                                                              cancelButtonTitle:@"OK"
//                                                              otherButtonTitles:nil];
//                    [alertView show];
//                }
//            }];
//        }
//    }
}
- (BOOL)openSessionWithAllowLoginUI:(UIViewController* )viewController
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"email", @"user_birthday", @"user_location"]
     fromViewController:viewController
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error)
         {
             [UIAlertView showWithTitle:@""
                                message:@"Facebook login failed"
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil
                               tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                   if (buttonIndex == [alertView cancelButtonIndex]) {
                                       
                                   }
                               }];

         }
         else if (result.isCancelled)
         {
             [UIAlertView showWithTitle:@""
                                message:@"Facebook login cancelled"
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil
                               tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                   if (buttonIndex == [alertView cancelButtonIndex]) {
                                       
                                   }
                               }];
         }
         else
         {
             NSLog(@"Logged in");
             [self loginSuccessWithFacebook];
         }
     }];
    
    return true;
}

- (BOOL)openSessionWithoutAllowLoginUI:(UIViewController *)viewController
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"email", @"user_birthday", @"user_location"]
     fromViewController:viewController
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error)
         {
             [UIAlertView showWithTitle:@""
                                message:@"Facebook login failed"
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil
                               tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                   if (buttonIndex == [alertView cancelButtonIndex]) {
                                       
                                   }
                               }];
             
         }
         else if (result.isCancelled)
         {
             [UIAlertView showWithTitle:@""
                                message:@"Facebook login cancelled"
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil
                               tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                   if (buttonIndex == [alertView cancelButtonIndex]) {
                                       
                                   }
                               }];
         }
         else
         {
             NSLog(@"Logged in");
             [self loginSuccessWithFacebook];
         }
     }];
    return true;
}

//+ (NSString *)FBErrorCodeDescription:(FBErrorCode) code {
//    switch(code){
//        case FBErrorInvalid :{
//            return @"FBErrorInvalid";
//        }
//        case FBErrorOperationCancelled:{
//            return @"FBErrorOperationCancelled";
//        }
//        case FBErrorLoginFailedOrCancelled:{
//            return @"FBErrorLoginFailedOrCancelled";
//        }
//        case FBErrorRequestConnectionApi:{
//            return @"FBErrorRequestConnectionApi";
//        }case FBErrorProtocolMismatch:{
//            return @"FBErrorProtocolMismatch";
//        }
//        case FBErrorHTTPError:{
//            return @"FBErrorHTTPError";
//        }
//        case FBErrorNonTextMimeTypeReturned:{
//            return @"FBErrorNonTextMimeTypeReturned";
//        }
//            //        case FBErrorNativeDialog:{
//            //            return @"FBErrorNativeDialog";
//            //        }
//        default:
//            return @"[Unknown]";
//    }
//}
//

@end
