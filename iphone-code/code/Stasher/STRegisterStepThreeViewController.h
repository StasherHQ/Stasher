//
//  STRegisterStepThreeViewController.h
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STRegisterStepThreeViewController : UIViewController <BOABHttpReqDelegate>
{
    BOABHttpReq *httpReq;
}

@property (nonatomic, strong) IBOutlet UITextField *textFieldCardNumber;
@property (nonatomic, strong) IBOutlet UITextField *textFieldExpiryDate;
@property (nonatomic, strong) IBOutlet UITextField *textFieldCVVNumber;
@property (nonatomic, strong) IBOutlet UIButton *buttonSaveDetails;
@property (nonatomic, strong) IBOutlet UIButton *buttonSaveLater;
@property (nonatomic, strong) IBOutlet UIWebView *paymentsWebView;
@property (nonatomic, strong) IBOutlet UILabel *selectBankDetailsLabel;
@property (nonatomic, strong) STActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) IBOutlet UILabel *headerLabelRegistration;
@property (nonatomic, strong) IBOutlet UILabel *headerLabelStep;
@end
