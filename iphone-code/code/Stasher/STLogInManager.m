//
//  STLogInManager.m
//  Stasher
//
//  Created by bhushan on 14/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STLogInManager.h"
#import <FacebookSDK/FacebookSDK.h>


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
    [FBSession.activeSession closeAndClearTokenInformation];
    
    if ([self.delegate respondsToSelector:@selector(userLoggedOutSuccessfully)]) {
        [self.delegate userLoggedOutSuccessfully];
    }
}


#pragma mark ----- The Facebook

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState)state
                      error:(NSError *)error
{
    switch (state) {
            
        case FBSessionStateOpen:
        {
                if (FBSession.activeSession.isOpen) {
                    [[FBRequest requestForMe] startWithCompletionHandler:
                     ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                         if (!error) {
                             
                             NSLog(@"%@,%@,%@",[user objectForKey:@"id"],[user objectForKey:@"email"],user.first_name);
                             /*
                             [[NSUserDefaults standardUserDefaults] setValue:[user objectForKey:@"id"] forKey:@"FBUserId"];
                             [[NSUserDefaults standardUserDefaults] setValue:user.first_name forKey:@"FBUserName"];
                             [[NSUserDefaults standardUserDefaults] setValue:user.last_name forKey:@"FBLastName"];
                             [[NSUserDefaults standardUserDefaults] setValue:[user objectForKey:@"email"] forKey:@"FBUserEmail"];
                             */
                             
                             if ([__instance.delegate respondsToSelector:@selector(facebookLogInSuccessfulWithUserDictionary:)]) {
                                 [__instance.delegate facebookLogInSuccessfulWithUserDictionary:user];
                             }
                         }
                     }];
                }
        }
            break;
            
            
        case FBSessionStateClosed:
        {
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
            //show log in view
        }
            break;
            
            
        case FBSessionStateClosedLoginFailed:
        {
            //show login view
            
        }
            break;
            
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SCSessionStateChangedNotification
                                                        object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error: %@",
                                                                     [STLogInManager FBErrorCodeDescription:error.code]]
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        [self fbResync];
        
    }
}

-(void)fbResync
{
    ACAccountStore *accountStore;
    ACAccountType *accountTypeFB;
    if ((accountStore = [[ACAccountStore alloc] init]) && (accountTypeFB = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook] ) ){
        
        NSArray *fbAccounts = [accountStore accountsWithAccountType:accountTypeFB];
        id account;
        if (fbAccounts && [fbAccounts count] > 0 && (account = [fbAccounts objectAtIndex:0])){
            
            [accountStore renewCredentialsForAccount:account completion:^(ACAccountCredentialRenewResult renewResult, NSError *error) {
                //we don't actually need to inspect renewResult or error.
                if (error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error: %@",
                                                                                 [STLogInManager FBErrorCodeDescription:error.code]]
                                                                        message:error.localizedDescription
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
            }];
        }
    }
}
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI{
    
    return [FBSession openActiveSessionWithReadPermissions:@[@"email", @"user_birthday", @"user_location"]
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                             if (error) {
                                                 [UIAlertView showWithTitle:@""
                                                                    message:@"Facebook login cancelled"
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil
                                                                   tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                       if (buttonIndex == [alertView cancelButtonIndex]) {
                                                                           
                                                                       }
                                                                   }];
                                             }else
                                                 [self sessionStateChanged:session state:state error:error];
                                         }];
    
}

- (BOOL)openSessionWithoutAllowLoginUI:(BOOL)allowLoginUI
{
    
    return [FBSession openActiveSessionWithReadPermissions:@[@"email", @"user_birthday", @"user_location"]
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                             if (error) {
                                                 [UIAlertView showWithTitle:@""
                                                                    message:@"Facebook login cancelled"
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil
                                                                   tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                       if (buttonIndex == [alertView cancelButtonIndex]) {
                                                                           
                                                                       }
                                                                   }];
                                             }
                                             //[self sessionStateChanged:session state:state error:error];
                                         }];
    
}

+ (NSString *)FBErrorCodeDescription:(FBErrorCode) code {
    switch(code){
        case FBErrorInvalid :{
            return @"FBErrorInvalid";
        }
        case FBErrorOperationCancelled:{
            return @"FBErrorOperationCancelled";
        }
        case FBErrorLoginFailedOrCancelled:{
            return @"FBErrorLoginFailedOrCancelled";
        }
        case FBErrorRequestConnectionApi:{
            return @"FBErrorRequestConnectionApi";
        }case FBErrorProtocolMismatch:{
            return @"FBErrorProtocolMismatch";
        }
        case FBErrorHTTPError:{
            return @"FBErrorHTTPError";
        }
        case FBErrorNonTextMimeTypeReturned:{
            return @"FBErrorNonTextMimeTypeReturned";
        }
            //        case FBErrorNativeDialog:{
            //            return @"FBErrorNativeDialog";
            //        }
        default:
            return @"[Unknown]";
    }
}


@end
