//
//  STPaymentViewController.m
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STPaymentViewController.h"

@interface STPaymentViewController ()

@end

@implementation STPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.headerLabel setFont:[UIFont FontForHeader]];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
        NSMutableArray *childsArray = [[NSMutableArray alloc] initWithArray:[[STUserIdentity sharedInstance] getChildrenArray]];
        if(!parentPaymentVC)
            parentPaymentVC = [[STParentPaymentViewController alloc] initWithNibName:@"STParentPaymentViewController" bundle:[NSBundle mainBundle] andChildNamesArray:childsArray];
        [parentPaymentVC.view setFrame:CGRectMake(0.0, 0.0, self.containerView.frame.size.width, self.containerView.frame.size.height)];
        parentPaymentVC.delegate = self;
        [self.containerView addSubview:parentPaymentVC.view withAnimation:NO];
    }
    else if ([[STUserIdentity sharedInstance] userIdentity] == CHILDUSER){
        NSMutableArray *parentsArray = [[NSMutableArray alloc] initWithArray:[[STUserIdentity sharedInstance] getParentsArray]];
        if(!childPaymentVC)
            childPaymentVC = [[STChildPaymentViewController alloc] initWithNibName:@"STChildPaymentViewController" bundle:[NSBundle mainBundle] andParentnamesArray:parentsArray];
        childPaymentVC.delegate = self;
        [childPaymentVC.view setFrame:CGRectMake(0.0, 0.0, self.containerView.frame.size.width, self.containerView.frame.size.height)];
        [self.containerView addSubview:childPaymentVC.view withAnimation:NO];
    }
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

#pragma mark ---------------------- Parent ----------------------

- (void)addChildButtonPressed
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STAddChildViewController *addChildVC = [storyboard instantiateViewControllerWithIdentifier:@"STAddChildViewController"];
    addChildVC.delegate = self;
    [self.navigationController pushViewController:addChildVC animated:YES];
}

- (void)childAddedWithUserDetailsDictionary:(NSDictionary*)infoDict
{
    [self requestUserDetails];
}

- (void)childNameSelectedWithDictionary:(NSDictionary*)childDict
{
    NSLog(@"child dict %@",childDict);
    
    if ([childDict objectForKey:kParamKeyUserFirstKnoxTID] != nil && ![[childDict objectForKey:kParamKeyUserFirstKnoxTID] isEqualToString:@""]) {
        
    }else{
        [UIAlertView showWithTitle:@""
                           message:@"You must link the Child's savings account before transferring funds. Would you like to link one now?"
                 cancelButtonTitle:@"No"
                 otherButtonTitles:[NSArray arrayWithObjects:@"Yes", nil]
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex != [alertView cancelButtonIndex]) {
                                  [self addBankAccountButtonPressedForBankAccountType:2 andUserInfoDict:childDict];
                              }
                          }];
        return;
    }
    
    
    if ([[STUserIdentity sharedInstance] userKnoxFirstTransactionID] != nil && ![[[STUserIdentity sharedInstance] userKnoxFirstTransactionID] isEqualToString:@""]) {
        if ([childDict objectForKey:kParamKeyUserFirstKnoxTID] != nil && ![[childDict objectForKey:kParamKeyUserFirstKnoxTID] isEqualToString:@""]) {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            STParentMakePaymentViewController *parentMakePaymentVC = [storyboard instantiateViewControllerWithIdentifier:@"STParentMakePaymentViewController"];
            parentMakePaymentVC.childDictionary = [childDict mutableCopy];
            [self.navigationController pushViewController:parentMakePaymentVC animated:YES];
        }else{
            [UIAlertView showWithTitle:@""
                               message:@"You must link the Child's savings account before transferring funds. Would you like to link one now?"
                     cancelButtonTitle:@"No"
                     otherButtonTitles:[NSArray arrayWithObjects:@"Yes", nil]
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  if (buttonIndex != [alertView cancelButtonIndex]) {
                                      [self addBankAccountButtonPressedForBankAccountType:2 andUserInfoDict:childDict];
                                  }
                              }];
        }
    }else{
        [UIAlertView showWithTitle:@""
                           message:@"You must link your bank account before transfering funds to child. Would you like to link one now?"
                 cancelButtonTitle:@"No"
                 otherButtonTitles:[NSArray arrayWithObjects:@"Yes", nil]
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex != [alertView cancelButtonIndex]) {
                                  [self addBankAccountButtonPressedForBankAccountType:1 andUserInfoDict:nil];
                              }
                          }];
    }
}

- (void)addBankAccountButtonPressedForBankAccountType:(int)bankAccType andUserInfoDict:(NSDictionary*)dict
{
    if (bankAccType == 1) {
        /*
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        STParentPaymentFlowViewController *parentPaymentFlowVC = [storyboard instantiateViewControllerWithIdentifier:@"STParentPaymentFlowViewController"];
        parentPaymentFlowVC.paymentParamsDict  = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0.01",@"amount",@"Add parent bank account",@"description", nil];
        parentPaymentFlowVC.delegate = self;
        parentPaymentFlowVC.bankAccountTypeInt = 1;
        [self.navigationController pushViewController:parentPaymentFlowVC animated:YES];
         */
        if (linkBankAccountVC) {
            linkBankAccountVC = nil;
        }
        linkBankAccountVC = [[STPaymentLinkBankViewController alloc] initWithNibName:@"STPaymentLinkBankViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:linkBankAccountVC animated:YES];
    }else if (bankAccType == 2){
        /*
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        STParentPaymentFlowViewController *parentPaymentFlowVC = [storyboard instantiateViewControllerWithIdentifier:@"STParentPaymentFlowViewController"];
        parentPaymentFlowVC.paymentParamsDict  = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0.01",@"amount",@"Add child bank account",@"description", dict,@"childInfoDict",nil];
        parentPaymentFlowVC.delegate = self;
        parentPaymentFlowVC.bankAccountTypeInt = 2;
        [self.navigationController pushViewController:parentPaymentFlowVC animated:YES];
         */
        if (linkBankAccountVC) {
            linkBankAccountVC = nil;
        }
        linkBankAccountVC = [[STPaymentLinkBankViewController alloc] initWithNibName:@"STPaymentLinkBankViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:linkBankAccountVC animated:YES];
    }
    
}

- (void)addBankAccountButtonPressed
{
    [self addBankAccountButtonPressedForBankAccountType:1 andUserInfoDict:nil];
}

- (void)addAccountSuccessFullWithDict:(NSDictionary *)dict andBankAccountUserType:(int)bankAccType
{
    if (bankAccType == 1) {
        if (parentPaymentVC!=nil) {
            parentPaymentVC.dictBankAccountInfo = [NSMutableDictionary dictionaryWithDictionary:[dict mutableCopy]];
            [parentPaymentVC refreshViewOnLinkedAccount];
        }
    }else if (bankAccType == 2){
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        STParentMakePaymentViewController *parentMakePaymentVC = [storyboard instantiateViewControllerWithIdentifier:@"STParentMakePaymentViewController"];
        parentMakePaymentVC.childDictionary = [dict mutableCopy];
        [self.navigationController pushViewController:parentMakePaymentVC animated:YES];
    }
}

#pragma mark ---------------------- Child -----------------------

- (void)childPaymentRequestPaymentParentSelectedWithDictionary:(NSDictionary*)dict
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STChildPaymentRequestViewController *childPaymentRequestVC = [storyboard instantiateViewControllerWithIdentifier:@"STChildPaymentRequestViewController"];
    childPaymentRequestVC.parentInfoDict = [dict mutableCopy];
    [self.navigationController pushViewController:childPaymentRequestVC animated:YES];
}

#pragma mark ----- Custom Methods

- (void) requestUserDetails
{
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    if ([[STUserIdentity sharedInstance] userId] != nil) {
        [paramDict setObject:[[STUserIdentity sharedInstance] userId] forKey:kParamKeyUserID];
        [paramDict setObject:kAPIActionProfile forKey:kParamKeyAction];
        [paramDict setObject:@"yes" forKey:kParamKeySaveResponseLocally];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
        paramDict = nil;
    }
}

#pragma mark ----- BOABHttpReqDelegates
- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if (responseDictionary) {
            if ([responseDictionary objectForKey:@"usedetails"] && [[responseDictionary objectForKey:@"usedetails"] isKindOfClass:[NSDictionary class]]) {
                [[STUserIdentity sharedInstance] setUserInformationDictionary:[[responseDictionary objectForKey:@"usedetails"] mutableCopy]];
                NSMutableDictionary *logInInfoDictionary = [[responseDictionary objectForKey:@"usedetails"] mutableCopy];
                [logInInfoDictionary setObject:[NSNumber numberWithInt:1] forKey:kUserDefaultsIsUserLoggedIn];
                [[STLogInManager sharedInstance] updateUserDefaultsInLogInManagerWithDictionary:logInInfoDictionary];
                NSLog(@"usertype %d",[[STUserIdentity sharedInstance] userIdentity]);
                if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
                    if (parentPaymentVC) {
                        if ([responseDictionary objectForKey:kParamKeyChild]) {
                            if ([[responseDictionary objectForKey:kParamKeyChild] isKindOfClass:[NSArray class]]) {
                                parentPaymentVC.childrenArray = [[responseDictionary objectForKey:kParamKeyChild] mutableCopy];
                            }
                        }
                        [parentPaymentVC.childNamesListTableView reloadData];
                    }
                }
                else if ([[STUserIdentity sharedInstance] userIdentity] == CHILDUSER){
                }
            }
        }
    }
}
@end
