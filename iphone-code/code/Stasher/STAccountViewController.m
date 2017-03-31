//
//  STAccountViewController.m
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STAccountViewController.h"
#import "STEntryViewController.h"
#import "SWRevealViewController.h"
#import "STUserIdentity.h"
@interface STAccountViewController ()

@end

@implementation STAccountViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    //[self.revealViewController rightRevealToggle:_settingsButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[_settingsButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the gesture
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Do any additional setup after loading the view.
    [self.headerlabel setFont:[UIFont FontForHeader]];
    [self requestUserDetails];
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

- (IBAction)logOutButtonPressed:(id)sender
{
    [UIAlertView showWithTitle:@""
                       message:@"Do you want to Log Out of Stasher?"
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:[NSArray arrayWithObjects:@"Log Out", nil]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex != [alertView cancelButtonIndex]) {
                              [[STLogInManager sharedInstance] logOut];
                          }
                      }];
}

- (IBAction)settingsButtonPressed:(id)sender
{
    STSettingsViewController *settingsVC = [[STSettingsViewController alloc] initWithNibName:@"STSettingsViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:settingsVC animated:YES];
}


#pragma mark ----- Custom Methods

- (void) requestUserDetails
{
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    if ([httpReq reachable]) {
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        if ([[STUserIdentity sharedInstance] userId] != nil) {
            [paramDict setObject:[[STUserIdentity sharedInstance] userId] forKey:kParamKeyUserID];
            if ([[STUserIdentity sharedInstance] userKnoxFirstTransactionID] != nil && ![[[STUserIdentity sharedInstance] userKnoxFirstTransactionID] isEqualToString:@""]){
                [paramDict setObject:[[STUserIdentity sharedInstance] userKnoxFirstTransactionID] forKey:kParamKeyUserFirstKnoxTID];
            }
            [paramDict setObject:kAPIActionProfile forKey:kParamKeyAction];
            [paramDict setObject:@"yes" forKey:kParamKeySaveResponseLocally];
            [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
            paramDict = nil;
        }
    }
    else{
        NSData *data = [[STCacheManager sharedInstance] getJSONDataForAPIName:kAPIActionProfile];
        if (data != nil) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if (responseDictionary) {
                [self callUserViewsForResponseDict:responseDictionary];
            }
        }
    }
    
}

#pragma mark ----- ParentAccountDelegate

- (void) addChildButtonPressed:(UIButton*)btn
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STAddChildViewController *addChildVC = [storyboard instantiateViewControllerWithIdentifier:@"STAddChildViewController"];
    addChildVC.delegate = self;
    [self.navigationController pushViewController:addChildVC animated:YES];
}

- (void) editProfileButtonPressed:(UIButton *)btn
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STEditProfileViewController *editProfileVC = [storyboard instantiateViewControllerWithIdentifier:@"STEditProfileViewController"];
    editProfileVC.delegate = self;
    [self.navigationController pushViewController:editProfileVC animated:YES];
}

- (void)childDetailsSelectedWithDict:(NSDictionary*)dict
{
    STParentAccountChildDetailsViewController *childDetailsVC = [[STParentAccountChildDetailsViewController alloc] initWithNibName:@"STParentAccountChildDetailsViewController" bundle:[NSBundle mainBundle] withChildDetailsDictionary:dict];
    [self.navigationController pushViewController:childDetailsVC animated:YES];
}

- (void) createChildButtonPressed
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STCreateChildViewController *editProfileVC = [storyboard instantiateViewControllerWithIdentifier:@"STCreateChildViewController"];
    [self.navigationController pushViewController:editProfileVC animated:YES];
}

#pragma mark ---- Add Child Delegate
- (void)childAddedWithUserDetailsDictionary:(NSDictionary*)infoDict
{
    [self requestUserDetails];
}


#pragma mark ----- Child Account Delegate

- (void)childAccountAddParentButtonPressed:(UIButton *)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STAddParentViewController *addParentVC = [storyboard instantiateViewControllerWithIdentifier:@"STAddParentViewController"];
    addParentVC.delegate = self;
    [self.navigationController pushViewController:addParentVC animated:YES];
}

- (void)childAccountEditProfileButtonPressed:(UIButton *)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STEditProfileViewController *editProfileVC = [storyboard instantiateViewControllerWithIdentifier:@"STEditProfileViewController"];
    editProfileVC.delegate = self;
    [self.navigationController pushViewController:editProfileVC animated:YES];
    
}

- (void) childAccountParentDetailsSelectedWithDictionary:(NSDictionary*)dict
{
    STChildAccountParentDetailsViewController *childAccountParentDetailsVC = [[STChildAccountParentDetailsViewController alloc] initWithNibName:@"STChildAccountParentDetailsViewController" bundle:[NSBundle mainBundle] andParentDetailsDictionary:dict];
    [self.navigationController pushViewController:childAccountParentDetailsVC animated:YES];
}

#pragma mark ----- Add Parent Delegate

- (void)parentAddedWithUserDetailsDictionary:(NSDictionary*)infoDict
{
    [self requestUserDetails];
}



#pragma mark ----- EditProfile Delegate

- (void)profileSuccessfullyEdited
{
    [self requestUserDetails];
}

- (void)passwordChangedLogInAgain
{
    /*
    [UIAlertView showWithTitle:@""
                       message:@"Password Changed, You will be logged out!"
             cancelButtonTitle:@"OK"
             otherButtonTitles:nil
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                               [self logOutButtonPressed:nil];
                          }
                      }];
     */
   
}

#pragma mark ----- BOABHttpReqDelegates
- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        NSLog(@"Profile responseDict %@",responseDictionary);
        if (responseDictionary) {
            [self callUserViewsForResponseDict:responseDictionary];
        }
    }
}

- (void)BOABHttpReqFailedWithError:(NSError*)error
{
    if (error) {
        NSData *data = [[STCacheManager sharedInstance] getJSONDataForAPIName:kAPIActionProfile];
        if (data != nil) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if (responseDictionary) {
                 [self callUserViewsForResponseDict:responseDictionary];
            }
        }
    }
}

- (void) callUserViewsForResponseDict:(NSDictionary*)responseDictionary
{
    if (responseDictionary) {
        if ([responseDictionary objectForKey:@"usedetails"] && [[responseDictionary objectForKey:@"usedetails"] isKindOfClass:[NSDictionary class]]) {
            [[STUserIdentity sharedInstance] setUserInformationDictionary:[[responseDictionary objectForKey:@"usedetails"] mutableCopy]];
            NSMutableDictionary *logInInfoDictionary = [[responseDictionary objectForKey:@"usedetails"] mutableCopy];
            [logInInfoDictionary setObject:[NSNumber numberWithInt:1] forKey:kUserDefaultsIsUserLoggedIn];
            [[STLogInManager sharedInstance] updateUserDefaultsInLogInManagerWithDictionary:logInInfoDictionary];
            CGRect frameForAccountView = self.accountContainerView.frame;
            frameForAccountView.origin.y = 0.0f;
            NSLog(@"usertype %d",[[STUserIdentity sharedInstance] userIdentity]);
            if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
                if (parentAccountVC) {
                    parentAccountVC.delegate = nil;
                    [parentAccountVC.view removeFromSuperview];
                    parentAccountVC = nil;
                }
                parentAccountVC = [[STParentAccountViewController alloc] initWithNibName:@"STParentAccountViewController" bundle:[NSBundle mainBundle] withChildArray:nil];
                
                if ([responseDictionary objectForKey:kParamKeyChild]) {
                    if ([[responseDictionary objectForKey:kParamKeyChild] isKindOfClass:[NSArray class]]) {
                        parentAccountVC.childArray = [[responseDictionary objectForKey:kParamKeyChild] mutableCopy];
                    }
                }
                [parentAccountVC.view setFrame:frameForAccountView];
                CGRect parentViewRect = parentAccountVC.view.frame;
                parentViewRect.size.width = self.accountContainerView.frame.size.width;
                parentViewRect.size.height = self.accountContainerView.frame.size.height;
                [self.accountContainerView addSubview:parentAccountVC.view withAnimation:NO];
                parentAccountVC.delegate = self;
                [parentAccountVC.childNamesTable reloadData];
                [parentAccountVC refreshViewForEditedProfile];
                [parentAccountVC refreshViewOnForNewChilds];
            }
            else if ([[STUserIdentity sharedInstance] userIdentity] == CHILDUSER){
                if (childAccountVC) {
                    childAccountVC.delegate = nil;
                    [childAccountVC.view removeFromSuperview];
                    childAccountVC = nil;
                }
                NSString *vcIdentifier;
                vcIdentifier = @"STChildAccountViewController";
                childAccountVC = [[STChildAccountViewController alloc] initWithNibName:vcIdentifier bundle:[NSBundle mainBundle]];
                if ([responseDictionary objectForKey:kParamKeyParent]) {
                    if ([[responseDictionary objectForKey:kParamKeyParent] isKindOfClass:[NSArray class]]) {
                        childAccountVC.parentArray = [[responseDictionary objectForKey:kParamKeyParent] mutableCopy];
                    }
                }
                [childAccountVC.view setFrame:frameForAccountView];
                CGRect childViewRect = childAccountVC.view.frame;
                childViewRect.size.width = self.accountContainerView.frame.size.width;
                childViewRect.size.height = self.accountContainerView.frame.size.height;
                [self.accountContainerView addSubview:childAccountVC.view withAnimation:NO];
                childAccountVC.delegate = self;
                [childAccountVC.parentNamesTable reloadData];
                [childAccountVC refreshViewForNewParents];
                [childAccountVC refreshViewLabelsOnEditProfile];
            }
        }
    }
}


#pragma mark ----- LogInManager Delegate
- (void)userLoggedOutSuccessfully
{
    
    
}


@end
