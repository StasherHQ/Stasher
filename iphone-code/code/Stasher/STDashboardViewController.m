//
//  STDashboardViewController.m
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STDashboardViewController.h"


@interface STDashboardViewController ()

@end

@implementation STDashboardViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self performSelector:@selector(requestUserDetails) withObject:nil afterDelay:0.1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.headerlabel setFont:[UIFont FontForHeader]];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
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

#pragma mark ----- Request User Details

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
            if (deviceTokenStr != nil) {
                [paramDict setObject:deviceTokenStr forKey:@"uid"];
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


#pragma mark ----- ParentDashboardDelegates
- (void)parentDashboardChildDetailsSelectedWithDictionary:(NSDictionary*)dict
{
    if (childDetailsVC) {
        childDetailsVC = nil;
    }
    childDetailsVC = [[STParentAccountChildDetailsViewController alloc] initWithNibName:@"STParentAccountChildDetailsViewController" bundle:[NSBundle mainBundle] withChildDetailsDictionary:dict];
    [self.navigationController pushViewController:childDetailsVC animated:YES];
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
            NSLog(@"usertype %d",[[STUserIdentity sharedInstance] userIdentity]);
            if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
                    NSMutableArray *childsArray = [[NSMutableArray alloc] init];
                if ([responseDictionary objectForKey:kParamKeyChild]) {
                    if ([[responseDictionary objectForKey:kParamKeyChild] isKindOfClass:[NSArray class]]) {
                        childsArray = [[NSMutableArray alloc] initWithArray:[[responseDictionary objectForKey:kParamKeyChild] mutableCopy]];
                    }
                }
                    
                if (childsArray != nil) {
                }
                if (parentdashboardVC != nil) {
                    [parentdashboardVC.view removeFromSuperview];
                    parentdashboardVC.delegate = nil;
                    parentdashboardVC = nil;
                }
                parentdashboardVC = [[STParentDashboardViewController alloc] initWithNibName:@"STParentDashboardViewController" bundle:[NSBundle mainBundle] WithDashboardChildArray:childsArray];
                parentdashboardVC.delegate = self;
                [parentdashboardVC.view setFrame:CGRectMake(0.0, 0.0, self.dashboardContainerView.frame.size.width, self.dashboardContainerView.frame.size.height)];
                [self.dashboardContainerView addSubview:parentdashboardVC.view withAnimation:YES];
                if (parentdashboardVC) {
                    [parentdashboardVC requestParentGraphData];
                }
                if ([[STUserIdentity sharedInstance] shouldShowTutorials]) {
                    if ([childsArray count]>0) {
                        
                    }else{
                        if (bearPopUpVC==nil) {
                            bearPopUpVC = [[STBearPopUpViewController alloc] initWithNibName:@"STBearPopUpViewController" bundle:[NSBundle mainBundle]];
                            bearPopUpVC.BearPopUpKind = ADDCHILDBEARPOPUP;
                            bearPopUpVC.delegate = self;
                            [bearPopUpVC.view setFrame:self.view.frame];
                            [bearPopUpVC.view addPopUpOnKeyWindow];
                            
                        }
                    }
                    
                 }
              }
            else if ([[STUserIdentity sharedInstance] userIdentity] == CHILDUSER){
                NSMutableArray *parentsArray = [[NSMutableArray alloc] init];
                if ([responseDictionary objectForKey:kParamKeyParent]) {
                    if ([[responseDictionary objectForKey:kParamKeyParent] isKindOfClass:[NSArray class]]) {
                        parentsArray = [[responseDictionary objectForKey:kParamKeyParent] mutableCopy];
                    }
                }
                if (parentsArray != nil) {
                }
                if (childDashboardVC != nil) {
                    [childDashboardVC.view removeFromSuperview];
                    childDashboardVC = nil;
                }
                childDashboardVC = [[STChildDashboardViewController alloc] initWithNibName:@"STChildDashboardViewController" bundle:[NSBundle mainBundle] WithDashboardParentArray:parentsArray];
                [childDashboardVC.view setFrame:CGRectMake(0.0, 0.0, self.dashboardContainerView.frame.size.width, self.dashboardContainerView.frame.size.height)];
                [self.dashboardContainerView addSubview:childDashboardVC.view withAnimation:YES];
                if (childDashboardVC) {
                    [childDashboardVC requestChildGraphDetails];
                }
                
                if ([[STUserIdentity sharedInstance] shouldShowTutorials]) {
                    if (bearPopUpVC==nil) {
                        bearPopUpVC = [[STBearPopUpViewController alloc] initWithNibName:@"STBearPopUpViewController" bundle:[NSBundle mainBundle]];
                        bearPopUpVC.BearPopUpKind = ADDPARENTBEARPOPUP;
                        bearPopUpVC.delegate = self;
                        [bearPopUpVC.view setFrame:self.view.frame];
                        [bearPopUpVC.view addPopUpOnKeyWindow];
                    }
                }
                if ([[STUserIdentity sharedInstance] shouldShowBadgeAlert]) {
                    [UIAlertView showWithTitle:@""
                                       message:@"Congratulations! You just earned your first badge!"
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
}


#pragma mark ----- BearPopUp Delegate

- (void)bearPopUpButtonPressedWithPopUpKind:(BearPopUpType)bearPopUpKind
{
    if (bearPopUpVC!=nil) {
        if (bearPopUpKind == ADDPARENTBEARPOPUP) {
            if (bearPopUpVC!=nil) {
                [bearPopUpVC.view removePopUpOnKeyWindow];
                bearPopUpVC.delegate = nil;
                bearPopUpVC = nil;
            }
            
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            STAddParentViewController *addParentVC = [storyboard instantiateViewControllerWithIdentifier:@"STAddParentViewController"];
            addParentVC.delegate = self;
            [self.navigationController pushViewController:addParentVC animated:YES];
        }else if (bearPopUpKind == THANKSFORADDINGPARENTBEARPOPUP){
            if (bearPopUpVC!=nil) {
                [bearPopUpVC.view removePopUpOnKeyWindow];
                bearPopUpVC.delegate = nil;
                bearPopUpVC = nil;
            }
            bearPopUpVC = [[STBearPopUpViewController alloc] initWithNibName:@"STBearPopUpViewController" bundle:[NSBundle mainBundle]];
            bearPopUpVC.BearPopUpKind = ADDCHILDBEARPOPUP;
            bearPopUpVC.delegate = self;
            [bearPopUpVC.view setFrame:self.view.frame];
            [bearPopUpVC.view addPopUpOnKeyWindow];
        }else if (bearPopUpKind == ADDCHILDBEARPOPUP){
            if (bearPopUpVC!=nil) {
                [bearPopUpVC.view removePopUpOnKeyWindow];
                bearPopUpVC.delegate = nil;
                bearPopUpVC = nil;
            }
            
            [self.tabBarController setSelectedIndex:4];
        }else if (bearPopUpKind == BANKACCOUNTLATERBEARPOPUP){
            if (bearPopUpVC!=nil) {
                [bearPopUpVC.view removePopUpOnKeyWindow];
                bearPopUpVC.delegate = nil;
                bearPopUpVC = nil;
            }
        }else if (bearPopUpKind == BANKACCOUNTDONEBEARPOPUP){
            if (bearPopUpVC!=nil) {
                [bearPopUpVC.view removePopUpOnKeyWindow];
                bearPopUpVC.delegate = nil;
                bearPopUpVC = nil;
            }
        }else if (bearPopUpKind == THANKSFORADDINGACHILDNOBANKBEARPOPUP){
            if (bearPopUpVC!=nil) {
                [bearPopUpVC.view removePopUpOnKeyWindow];
                bearPopUpVC.delegate = nil;
                bearPopUpVC = nil;
            }
        }
    }
}

# pragma mark ----- AddParentDelegates

- (void)parentAddedWithUserDetailsDictionary:(NSDictionary*)infoDict
{
    if (bearPopUpVC!=nil) {
        [bearPopUpVC.view removePopUpOnKeyWindow];
        bearPopUpVC.delegate = nil;
        bearPopUpVC = nil;
    }
    bearPopUpVC = [[STBearPopUpViewController alloc] initWithNibName:@"STBearPopUpViewController" bundle:[NSBundle mainBundle]];
    bearPopUpVC.BearPopUpKind = THANKSFORADDINGPARENTBEARPOPUP;
    bearPopUpVC.delegate = self;
    [bearPopUpVC.view setFrame:self.view.frame];
    [bearPopUpVC.view addPopUpOnKeyWindow];
}

- (void)bearPopUpLaterButtonPressed
{
    if (bearPopUpVC!=nil) {
        [bearPopUpVC.view removePopUpOnKeyWindow];
        bearPopUpVC.delegate = nil;
        bearPopUpVC = nil;
    }
    bearPopUpVC = [[STBearPopUpViewController alloc] initWithNibName:@"STBearPopUpViewController" bundle:[NSBundle mainBundle]];
    bearPopUpVC.BearPopUpKind = BANKACCOUNTLATERBEARPOPUP;
    bearPopUpVC.delegate = self;
    [bearPopUpVC.view setFrame:self.view.frame];
    [bearPopUpVC.view addPopUpOnKeyWindow];
}

- (void)bearPopUpSetUpButtonPressed
{
    if (bearPopUpVC!=nil) {
        [bearPopUpVC.view removePopUpOnKeyWindow];
        bearPopUpVC.delegate = nil;
        bearPopUpVC = nil;
    }
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STParentPaymentFlowViewController *parentPaymentFlowVC = [storyboard instantiateViewControllerWithIdentifier:@"STParentPaymentFlowViewController"];
    parentPaymentFlowVC.delegate = self;
    parentPaymentFlowVC.bankAccountTypeInt = 1;
    [self.navigationController pushViewController:parentPaymentFlowVC animated:YES];
}

#pragma mark ----- AddChildDelegates

- (void)childAddedWithUserDetailsDictionary:(NSDictionary *)infoDict
{
    if (bearPopUpVC!=nil) {
        [bearPopUpVC.view removePopUpOnKeyWindow];
        bearPopUpVC.delegate = nil;
        bearPopUpVC = nil;
    }
    if ([[[STUserIdentity sharedInstance] userKnoxFirstTransactionID] isKindOfClass:[NSNull class]] || [[[STUserIdentity sharedInstance] userKnoxFirstTransactionID] isEqualToString:@""]) {
        bearPopUpVC = [[STBearPopUpViewController alloc] initWithNibName:@"STBearPopUpViewController" bundle:[NSBundle mainBundle]];
        bearPopUpVC.BearPopUpKind = THANKSFORADDINGACHILDBEARPOPUP;
        bearPopUpVC.delegate = self;
        [bearPopUpVC.view setFrame:self.view.frame];
        [bearPopUpVC.view addPopUpOnKeyWindow];
    }else{
        bearPopUpVC = [[STBearPopUpViewController alloc] initWithNibName:@"STBearPopUpViewController" bundle:[NSBundle mainBundle]];
        bearPopUpVC.BearPopUpKind = THANKSFORADDINGACHILDNOBANKBEARPOPUP;
        bearPopUpVC.delegate = self;
        [bearPopUpVC.view setFrame:self.view.frame];
        [bearPopUpVC.view addPopUpOnKeyWindow];
    }
    
}

# pragma mark ----- ParentPaymentFlowDelegates

- (void)addAccountSuccessFullWithDict:(NSDictionary*)dict andBankAccountUserType:(int)bankAccType
{
    if (bearPopUpVC!=nil) {
        [bearPopUpVC.view removePopUpOnKeyWindow];
        bearPopUpVC.delegate = nil;
        bearPopUpVC = nil;
    }
    bearPopUpVC = [[STBearPopUpViewController alloc] initWithNibName:@"STBearPopUpViewController" bundle:[NSBundle mainBundle]];
    bearPopUpVC.BearPopUpKind = BANKACCOUNTDONEBEARPOPUP;
    bearPopUpVC.delegate = self;
    [bearPopUpVC.view setFrame:self.view.frame];
    [bearPopUpVC.view addPopUpOnKeyWindow];
}

@end
