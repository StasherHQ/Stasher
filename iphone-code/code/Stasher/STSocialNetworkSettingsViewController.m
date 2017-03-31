//
//  STSocialNetworkSettingsViewController.m
//  Stasher
//
//  Created by Bhushan on 30/04/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import "STSocialNetworkSettingsViewController.h"

@interface STSocialNetworkSettingsViewController ()

@end

@implementation STSocialNetworkSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.headerLabel setFont:[UIFont FontForHeader]];
    [self.removeFbButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
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

- (IBAction)removeFacebookButtonPressed:(id)sender
{
    [[STLogInManager sharedInstance] logOut];
}

@end
