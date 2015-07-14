//
//  STRegisterStepThreeViewController.m
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STRegisterStepThreeViewController.h"
#import "STBaseTabBarController.h"

@interface STRegisterStepThreeViewController ()

@end

@implementation STRegisterStepThreeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.buttonSaveLater.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.buttonSaveLater setTitleColor:[UIColor stasherTextColor] forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bankTransactionFinished:) name:kNotificationIdentifier_BankTransactionFinished object:nil];
    // Do any additional setup after loading the view.
    [self.headerLabelRegistration setText:@"Registration"];
    [self.headerLabelRegistration setFont:[UIFont FontForHeader]];
    [self.headerLabelStep setFont:[UIFont FontForHeader]];
    [self.headerLabelStep sizeToFit];
    [self.headerLabelRegistration sizeToFit];
    [self.selectBankDetailsLabel setFont:[UIFont FontForHeaderNoBold]];
    [self.selectBankDetailsLabel setTextColor:[UIColor stasherTextColor]];

    //create dictionary with user information
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    
    //add api key
    [userInfo setObject:@"4aa327f5ac661878d6178e2c2b44aa5a9a0708d2" forKey:@"api_key"];
    
    //add api password
    [userInfo setObject:@"7a383e494ac323569402b9f1fe591c1735906202" forKey:@"api_password"];
    
    //add amount as string
    [userInfo setObject:@"0.01" forKey:@"amount"];
    //[userInfo setObject:@"0.01" forKey:@"amount"];
    
    //add invoice detail];
    [userInfo setObject:@"Registration Token Transaction" forKey:@"invoice_detail"];
    //[userInfo setObject:@"invoice detail" forKey:@"invoice_detail"];
    
    //add information request
    [userInfo setObject:@"show_all" forKey:@"information_request"];
    
    //add recurring detail
    [userInfo setObject:@"ot" forKey:@"reccuring"];
    
    //add redirect URL
    [userInfo setObject:@"fb743090835784071://" forKey:@"redirect_url"];
    
    //make url string with user info on the end
    NSString *url = [NSString stringWithFormat:@"https://knoxpayments.com/pay?api_key=%@&api_password=%@&amount=%@&invoice_detail=%@&information_request=%@&recurring=%@&redirect_url=%@",[userInfo objectForKey:@"api_key"],[userInfo objectForKey:@"api_password"],[userInfo objectForKey:@"amount"],[userInfo objectForKey:@"invoice_detail"],[userInfo objectForKey:@"information_request"],[userInfo objectForKey:@"reccuring"],[userInfo objectForKey:@"redirect_url"] ];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"%@",url);
    
    //create URL and request
    NSURL *nsurl = [NSURL URLWithString:url];
    NSURLRequest *nsrequest = [NSURLRequest requestWithURL:nsurl];
    [self.paymentsWebView loadRequest:nsrequest];
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

- (IBAction)saveDetailsButtonPressed:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STBaseTabBarController *baseTabsController = [storyboard instantiateViewControllerWithIdentifier:@"STBaseTabBarController"];
    [self.navigationController pushViewController:baseTabsController animated:YES];
}

- (IBAction)saveLaterButtonPressed:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STBaseTabBarController *baseTabsController = [storyboard instantiateViewControllerWithIdentifier:@"STBaseTabBarController"];
    [self.navigationController pushViewController:baseTabsController animated:YES];
}

- (void)bankTransactionFinished:(NSNotification*)notification
{
    NSDictionary *dict = [notification userInfo];
    if (dict) {
        if ([dict objectForKey:@"pay_id"]) {
            [[STUserIdentity sharedInstance] setUserKnoxFirstTransactionID:[dict objectForKey:@"pay_id"]];
            if (httpReq) {
                httpReq.delegate = nil;
                httpReq = nil;
            }
            httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
            NSString *userIdString, *apiActionString;
            userIdString = kParamKeyParentID;
            apiActionString = kAPIActionAddBankAccount;
            [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[[STUserIdentity sharedInstance] userId] intValue]], userIdString,apiActionString,kParamKeyAction,[dict objectForKey:@"pay_id"],kParamKeyTransactionID,nil] json:YES];
        }
        if ([dict objectForKey:@"completed"]) {
            
        }
    }
    [self saveLaterButtonPressed:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationIdentifier_BankTransactionFinished object:nil];
}


# pragma mark ----- Textfield Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark ----- WebView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (self.activityIndicatorView!=nil) {
        [self.activityIndicatorView removeFromSuperview];
        self.activityIndicatorView = nil;
    }
    self.activityIndicatorView = [[STActivityIndicatorView alloc] initWithDefaultSizeandSuperView:self.view];
    [self.activityIndicatorView startAnimation];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicatorView stopAnimation];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityIndicatorView stopAnimation];
    if (self.activityIndicatorView!=nil) {
        [self.activityIndicatorView removeFromSuperview];
        self.activityIndicatorView = nil;
    }
}

#pragma mark ----- BOABHttpReqDelegates

- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if (responseDictionary) {
            NSLog(@"transaction_id sent to server...");
        }
    }
}


@end
