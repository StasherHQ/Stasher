//
//  STParentPaymentFlowViewController.m
//  Stasher
//
//  Created by bhushan on 06/02/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import "STParentPaymentFlowViewController.h"

@interface STParentPaymentFlowViewController ()

@end

@implementation STParentPaymentFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.headerLabel setFont:[UIFont FontForHeader]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bankTransactionFinished:) name:kNotificationIdentifier_BankTransactionFinished object:nil];
    //create dictionary with user information
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    
    //add api key
    [userInfo setObject:@"4aa327f5ac661878d6178e2c2b44aa5a9a0708d2" forKey:@"api_key"];
    
    //add api password
    [userInfo setObject:@"7a383e494ac323569402b9f1fe591c1735906202" forKey:@"api_password"];
    
    //add amount as string
    if (self.paymentParamsDict && [self.paymentParamsDict objectForKey:@"amount"]!=nil) {
        [userInfo setObject:[self.paymentParamsDict objectForKey:@"amount"] forKey:@"amount"];
    }
    //[userInfo setObject:@"0.01" forKey:@"amount"];
    
    //add invoice detail];
    if (self.paymentParamsDict && [self.paymentParamsDict objectForKey:@"description"]!=nil) {
        [userInfo setObject:[self.paymentParamsDict objectForKey:@"description"] forKey:@"invoice_detail"];
    }
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
    [self.paymentWebView loadRequest:nsrequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)bankTransactionFinished:(NSNotification*)notification
{
    NSDictionary *dict = [notification userInfo];
    if (dict) {
        if ([[dict objectForKey:@"completed"] isEqualToString:@"canceled"]) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        if ([dict objectForKey:@"pay_id"]) {
            [[STUserIdentity sharedInstance] setUserKnoxFirstTransactionID:[dict objectForKey:@"pay_id"]];
            if (httpReq) {
                httpReq.delegate = nil;
                httpReq = nil;
            }
            httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
           
            if (self.bankAccountTypeInt == 1) {
                NSString *apiActionString;
                apiActionString = kAPIActionAddBankAccount;
                [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[[STUserIdentity sharedInstance] userId] intValue]], kParamKeyParentID,apiActionString,kParamKeyAction,[dict objectForKey:@"pay_id"],kParamKeyTransactionID,nil] json:YES];
            }else if (self.bankAccountTypeInt == 2){
                NSString *apiActionString;
                apiActionString = kAPIActionAddBankAccountChild;
                NSString *childUserID;
                childUserID = [[self.paymentParamsDict objectForKey:@"childInfoDict"] objectForKey:kParamKeyUserID];
                [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[childUserID intValue]], kParamKeyChildID,apiActionString,kParamKeyAction,[dict objectForKey:@"pay_id"],kParamKeyTransactionID,nil] json:YES];
            }
        }
        if ([dict objectForKey:@"completed"]) {
            
        }
    }
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
            if ([self.delegate respondsToSelector:@selector(addAccountSuccessFullWithDict:andBankAccountUserType:)]) {
                [self.delegate addAccountSuccessFullWithDict:responseDictionary andBankAccountUserType:self.bankAccountTypeInt];
            }
        }
    }
}


@end
