//
//  STParentPaymentFlowViewController.h
//  Stasher
//
//  Created by bhushan on 06/02/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ParentPaymentFlowDelegate <NSObject>

@optional

- (void)addAccountSuccessFullWithDict:(NSDictionary*)dict andBankAccountUserType:(int)bankAccType;

@end


@interface STParentPaymentFlowViewController : UIViewController <BOABHttpReqDelegate>
{
    BOABHttpReq *httpReq;
}

@property (weak) id <ParentPaymentFlowDelegate> delegate;
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UIWebView *paymentWebView;
@property (nonatomic, strong) NSMutableDictionary *paymentParamsDict;
@property (nonatomic, strong) STActivityIndicatorView *activityIndicatorView;
@property (nonatomic, assign) int bankAccountTypeInt;
@end
