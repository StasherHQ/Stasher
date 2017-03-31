//
//  STNotificationSettingsViewController.m
//  Stasher
//
//  Created by Bhushan on 30/04/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import "STNotificationSettingsViewController.h"

@interface STNotificationSettingsViewController ()

@end

@implementation STNotificationSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.headerLabel setFont:[UIFont FontForHeader]];
    [self.labelSettingHeading setFont:[UIFont FontForButtonsWithSize:11.0f]];
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


- (IBAction)switchValuChanged:(id)sender
{
    UISwitch *notificationSwitch = (UISwitch*) sender;
    if ([notificationSwitch isOn]) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"NotificationSettingEnabled"];
    }else{
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"NotificationSettingEnabled"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
