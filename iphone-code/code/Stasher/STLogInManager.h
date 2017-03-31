//
//  STLogInManager.h
//  Stasher
//
//  Created by bhushan on 14/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LogInManagerDelegate <NSObject>

@optional

- (void)facebookLogInSuccessfulWithUserDictionary:(NSDictionary*)userInfoDict;
- (void)userLoggedOutSuccessfully;

@end

@interface STLogInManager : NSObject
{

}

@property (nonatomic, weak) id <LogInManagerDelegate> delegate;

+ (STLogInManager*) sharedInstance ;
- (BOOL)openSessionWithAllowLoginUI:(UIViewController* )viewController;
- (void)updateUserDefaultsInLogInManagerWithDictionary:(NSDictionary*)logInCredentialsDict;
- (BOOL)isUserLoggedIn;
- (void)logOut;
@end
