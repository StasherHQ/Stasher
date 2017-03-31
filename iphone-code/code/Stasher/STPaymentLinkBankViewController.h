//
//  STPaymentLinkBankViewController.h
//  Stasher
//
//  Created by Bhushan on 03/06/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STPaymentLinkBankViewController : UIViewController <NSURLConnectionDelegate>
{
    
    NSMutableData *receivedData;
}


@property (nonatomic, strong) IBOutlet UIButton *buttonLinkAccount;

@property (nonatomic, strong) IBOutlet UITextField *textFieldBankName;

@property (nonatomic, strong) IBOutlet UITextField *textFieldUsername;

@property (nonatomic, strong) IBOutlet UITextField *textFieldPassword;

@property (nonatomic, strong) STActivityIndicatorView *activityIndicatorView;



@end
