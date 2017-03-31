//
//  AppDelegate.m
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

NSDictionary *returnDict;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // register for notification..
    UIApplication *applicatio = [UIApplication sharedApplication];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingEnabled"]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingEnabled"] isEqualToString:@"YES"]) {
            if ([applicatio respondsToSelector:@selector(registerUserNotificationSettings:)])
            {
                UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert) categories:nil];
                [application registerUserNotificationSettings:settings];
                //[[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }
    }else{
        if ([applicatio respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert) categories:nil];
            [application registerUserNotificationSettings:settings];
            //[[UIApplication sharedApplication] registerForRemoteNotifications];
        }
    }
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
    
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    deviceTokenStr = [[[NSString stringWithFormat:@"%@",deviceToken]
                           stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"device token %@",deviceTokenStr);
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{

}

-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error

{
    NSLog(@"Failed to get token, error: %@", error);
}
-(BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation

{
    if ([[STLogInManager sharedInstance] isUserLoggedIn]) {
        //need to get the response from the payment when it is done and log it.
        NSLog(@"%@",[url absoluteString]);
        //parse the return URL to isolate pay_id and complete status
        returnDict = [self parseUrlString:[url absoluteString]];
        
        //send notification to resign webview
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNotificationIdentifier_BankTransactionFinished object:nil userInfo:returnDict]];
        /*
        //get pay_id and completed status from dictionary
        NSString *payID = [returnDict valueForKey:@"pay_id"];
        NSString *completed = [returnDict valueForKey:@"completed"];
        
        //log pay_id and status
        //NSLog(@"pay id or transaction_id= %@", payID );
        //NSLog(@"status = %@",completed);
        
        [UIAlertView showWithTitle:@""
                           message:completed
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                  
                              }
                          }];
        [UIAlertView showWithTitle:@"Important Development Alert"
                           message:[NSString stringWithFormat:@"Note this %@ transaction_id for development",payID]
                 cancelButtonTitle:@"Note then Close!"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                                  NSLog(@"pay_id %@",payID);
                              }
                          }];
         */
    }else{
        BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                      openURL:url
                                                            sourceApplication:sourceApplication
                                                                   annotation:annotation
                        ];
        // Add any custom logic here.
        return handled;
    }
    return YES;
}

-(NSDictionary *)parseUrlString:(NSString *)urlString {
    
    //get last path and log (return URL)
    NSString *lastPath = [urlString lastPathComponent];
    NSLog(@"last path = %@",lastPath);
    
    //remove question mark from path
    lastPath = [lastPath stringByReplacingCharactersInRange:NSMakeRange(0, 0) withString:@""];
    //create new dictionary to store parsed peices of
    NSMutableDictionary *newDict = [NSMutableDictionary new];
    //create array by separating path components
    NSArray *pathComponents = [lastPath componentsSeparatedByString:@"&"];
    //separeate key and value pars by parsing at = sign
    for (NSString *keyValuePair in pathComponents) {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [pairComponents objectAtIndex:0];
        NSString *value = [pairComponents objectAtIndex:1];
        //add to dictionary *newDict
        [newDict setObject:value forKey:key];
    }
    
    //return dictionary with pay_id and status
    return newDict;
    
}




@end
