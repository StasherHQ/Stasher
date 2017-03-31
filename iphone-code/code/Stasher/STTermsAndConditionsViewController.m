//
//  STTermsAndConditionsViewController.m
//  Stasher
//
//  Created by bhushan on 17/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STTermsAndConditionsViewController.h"

@interface STTermsAndConditionsViewController ()

@end

@implementation STTermsAndConditionsViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andIsThroughSettings:(BOOL)isSettingsCall andIsPrivacyPolicy:(BOOL)isPolicy orIsUserAgreement:(BOOL)isUserAgreement
{
    self = [super initWithNibName:@"STTermsAndConditionsViewController" bundle:nibBundleOrNil];
    if (self) {
        if (isSettingsCall) {
            self.isSettings = isSettingsCall;
            if (isPolicy) {
                self.isPrevacyPolicy =isPolicy;
            }
            if (isUserAgreement) {
                self.isUserAgrrement = isUserAgreement;
            }
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.policyTextView setFont:[UIFont FontForTextFields]];
    [self.policyTextView setTextColor:[UIColor stasherTextColor]];
    [self.headerLabel setFont:[UIFont FontForHeader]];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if (self.isSettings) {
        [self.acceptButton setHidden:YES];
        [self.cancelButton setHidden:YES];
        [self.backButton setHidden:NO];
        CGRect webFrame = self.policyTextView.frame;
        webFrame.size.height = self.view.frame.size.height - 40.0f;
        [self.policyTextView setFrame:webFrame];
        if (self.isPrevacyPolicy) {
            [self.headerLabel setText:@"Privacy Policy"];
        }else{
            [self.headerLabel setText:@"User Agreement"];
        }
    }else{
        [self.acceptButton setHidden:NO];
        [self.cancelButton setHidden:NO];
        [self.backButton setHidden:YES];
    }
    
    if (httpReq != nil) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:@"terms",kParamKeyAction, nil] json:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.policyTextView setContentOffset:CGPointZero];
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

- (IBAction)cancelButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(cancelButtonPressed)]) {
        [self.delegate cancelButtonPressed];
    }
}

- (IBAction)acceptButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(acceptButtonPressed)]) {
        [self.delegate acceptButtonPressed];
    }
}

# pragma mark ----- BOABHttpReqDelegates

- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if (responseDictionary!=nil) {
            NSData *termsData = [[NSData alloc] initWithBase64EncodedString:[responseDictionary objectForKey:@"page_content"] options:0];
            NSString *policyString = [[NSString alloc] initWithData:termsData encoding:0];
            if (self.isPrevacyPolicy) {
                //[self.policyTextView setText:@""];
            }else{
                [self.policyTextView setText:policyString];
            }
            //[self.headerLabel setText:[responseDictionary objectForKey:@"page_title"]];
        }
    }
}

- (void)BOABHttpReqFailedWithError:(NSError*)error
{
    [self.view setUserInteractionEnabled:YES];
    if (error) {
        
    }
}


@end
