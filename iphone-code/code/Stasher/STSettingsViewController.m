//
//  STSettingsViewController.m
//  Stasher
//
//  Created by Bhushan on 16/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import "STSettingsViewController.h"

@interface STSettingsViewController ()

@end

@implementation STSettingsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.headerlabel setFont:[UIFont FontForHeader]];
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

# pragma mark ----- Actions

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *) appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}

- (NSString *) build
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
}

-(NSString *) versionBuild
{
    NSString * version = [self appVersion];
    NSString * build = [self build];
    
    NSString * versionBuild = [NSString stringWithFormat: @"Version %@", version];
    
    if (![version isEqualToString: build]) {
        versionBuild = [NSString stringWithFormat: @"%@(%@)", versionBuild, build];
    }
    
    return versionBuild;
}

#pragma mark ----- Table Settings List
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(12, 3, self.view.frame.size.width, 35.0f);
    myLabel.font = [UIFont FontForButtonsWithSize:13.0f];
    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    [myLabel setTextColor:[UIColor stasherTextColor]];
    UIView *headerView = [[UIView alloc] init];
    [headerView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [headerView addSubview:myLabel];
    
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = @"";
    switch (section) {
        case 0:
            sectionTitle = @"ACCOUNT & SECURITY";
            break;
        case 1:
            sectionTitle = @"INFORMATION & SUPPORT";
            break;
        case 2:
            sectionTitle = @"";
            break;
        case 3:
            sectionTitle = @"";
            break;
        default:
            break;
    }
    return sectionTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 4;
            break;
        case 1:
            rows = 5;
            break;
        case 2:
            rows = 1;
            break;
        case 3:
            rows = 0;
            break;
        default:
            break;
    }
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    [cell.textLabel setTextColor:[UIColor stasherTextColor]];
    [cell.textLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    [cell.textLabel setText:@"Edit Profile"];
                    break;
                case 1:
                    [cell.textLabel setText:@"Alerts & Notification"];
                    break;
                case 2:
                    [cell.textLabel setText:@"Social Networks"];
                    break;
                case 3:
                    [cell.textLabel setText:@"Payments"];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    [cell.textLabel setText:@"Help Center"];
                    break;
                case 1:
                    [cell.textLabel setText:@"Send Feedback"];
                    break;
                case 2:
                    [cell.textLabel setText:@"User Agreement"];
                    break;
                case 3:
                    [cell.textLabel setText:@"Privacy Policy"];
                    break;
                case 4:
                    [cell.textLabel setText:@"Rate Stasher"];
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    [cell.textLabel setText:@"Sign Out"];
                    break;
                default:
                    break;
            }
            break;
        case 3:
            break;
        default:
            break;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    STEditProfileViewController *editProfileVC = [storyboard instantiateViewControllerWithIdentifier:@"STEditProfileViewController"];
                    editProfileVC.delegate = self;
                    [self.navigationController pushViewController:editProfileVC animated:YES];
                }
                    break;
                case 1:
                    if (notificationSettingsVC) {
                        notificationSettingsVC = nil;
                    }
                    notificationSettingsVC = [[STNotificationSettingsViewController alloc] initWithNibName:@"STNotificationSettingsViewController" bundle:nil];
                    [self.navigationController pushViewController:notificationSettingsVC animated:YES];
                    break;
                case 2:
                    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"IsFaceBookLogIn"] isEqualToString:@"YES"]){
                        if (socialSettingsVC) {
                            socialSettingsVC = nil;
                        }
                        socialSettingsVC = [[STSocialNetworkSettingsViewController alloc] initWithNibName:@"STSocialNetworkSettingsViewController" bundle:nil];
                        [self.navigationController pushViewController:socialSettingsVC animated:YES];
                    }else{
                        [UIAlertView showWithTitle:@""
                                           message:@"You are not using any Facebook Login."
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil
                                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          }];
                    }
                   
                    break;
                case 3:
                    [UIAlertView showWithTitle:@""
                                       message:@"Payments section will be added once Payment gateway is available."
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      }];
                    break;
                case 4:
                    break;
                case 5:
                    break;
                case 6:
                    break;
                case 7:
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    if ([MFMailComposeViewController canSendMail]) {
                        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
                        [composeViewController setMailComposeDelegate:self];
                        [composeViewController setToRecipients:@[@"help@stasherapp.com"]];
                        [composeViewController setSubject:@"Help"];
                        [self presentViewController:composeViewController animated:YES completion:nil];
                    }
                    break;
                case 1:
                    if ([MFMailComposeViewController canSendMail]) {
                        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
                        [composeViewController setMailComposeDelegate:self];
                        [composeViewController setToRecipients:@[@"bianca@stasherapp.com"]];
                        [composeViewController setSubject:@"Feedback"];
                        [self presentViewController:composeViewController animated:YES completion:nil];
                    }
                    break;
                case 2:
                    if (termsVC) {
                        termsVC = nil;
                    }
                    termsVC = [[STTermsAndConditionsViewController alloc] initWithNibName:@"STTermsAndConditionsViewController" bundle:nil andIsThroughSettings:YES andIsPrivacyPolicy:NO orIsUserAgreement:YES];
                    [self.navigationController pushViewController:termsVC animated:YES];
                    break;
                case 3:
                    if (termsVC) {
                        termsVC = nil;
                    }
                    termsVC = [[STTermsAndConditionsViewController alloc] initWithNibName:@"STTermsAndConditionsViewController" bundle:nil andIsThroughSettings:YES andIsPrivacyPolicy:YES orIsUserAgreement:NO];
                    [self.navigationController pushViewController:termsVC animated:YES];
                    break;
                case 4:{
                    NSString *iTunesLink = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=972598883&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software";
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
                }
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    [UIAlertView showWithTitle:@""
                                       message:@"Do you want to Log Out of Stasher?"
                             cancelButtonTitle:@"Cancel"
                             otherButtonTitles:[NSArray arrayWithObjects:@"Log Out", nil]
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          if (buttonIndex != [alertView cancelButtonIndex]) {
                                              [[STLogInManager sharedInstance] logOut];
                                          }
                                      }];
                    break;
                default:
                    break;
            }
            break;
        case 3:
            switch (indexPath.row) {
                case 0:
                    break;
                default:
                    break;
            }
            break;
        case 4:
            break;
        default:
            break;
    }
}


#pragma mark ----- EditProfile Delegate

- (void)profileSuccessfullyEdited
{
    if ([[self.navigationController viewControllers] count] > 2) {
        if ([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-3] isKindOfClass:[STAccountViewController class]]){
            STAccountViewController *vc = (STAccountViewController*)[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-3];
            [vc requestUserDetails];
        }
    }
}

- (void)passwordChangedLogInAgain
{
    
    
}

#pragma mark ----- MailComposer Delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //Add an alert in case of failure
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
