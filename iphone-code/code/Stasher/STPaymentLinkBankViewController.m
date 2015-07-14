//
//  STPaymentLinkBankViewController.m
//  Stasher
//
//  Created by Bhushan on 03/06/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import "STPaymentLinkBankViewController.h"

@interface STPaymentLinkBankViewController ()

@end

@implementation STPaymentLinkBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (void) addActivityIndicatorView
{
    if (self.activityIndicatorView) {
        self.activityIndicatorView = nil;
    }
    self.activityIndicatorView = [[STActivityIndicatorView alloc] initWithDefaultSizeandSuperView:self.view];
    [self.activityIndicatorView startAnimation];
}

- (void)removeActivityIndicatorView
{
    if (self.activityIndicatorView) {
        [self.activityIndicatorView stopAnimation];
        [self.activityIndicatorView removeFromSuperview];
    }
}

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buttonLinkAccountPressed:(id)sender
{
    [self addActivityIndicatorView];
   // NSString *jsonRequest = [[[[NSString stringWithFormat:@"%@", requestHeadersDict] stringByReplacingOccurrencesOfString:@"=" withString:@":"] stringByReplacingOccurrencesOfString:@";" withString:@","] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    //NSString *jsonRequest = [NSString stringWithFormat:@"{\"JsonRequest\":{\"api_key\": \"%@\",\"api_pass\": \"%@\",\"bank_name\": \"%@\",\"user_name\": \"%@\",\"user_pass\": \"%@\"}}",KNOXAPIKEY,KNOXAPIPASSWORD,@"CHASUS33",self.textFieldUsername.text,self.textFieldPassword.text];
    
     NSString *jsonRequest = [NSString stringWithFormat:@"{\"api_key\":\"%@\",\"api_pass\":\"%@\",\"swift_code\":\"%@\",\"user_name\":\"%@\",\"user_pass\":\"%@\"}",KNOXAPIKEY,KNOXAPIPASSWORD,@"CHASUS",self.textFieldUsername.text,self.textFieldPassword.text];
    
    NSLog(@"JsonRequest to Knox %@", jsonRequest);
    
    NSURL *url = [NSURL URLWithString:KNOX_LINK_BANK_URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        receivedData = [NSMutableData data] ;
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self removeActivityIndicatorView];
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
    if (responseDictionary) {
        NSLog(@"responseDictionary %@",responseDictionary);
    }
}


@end
