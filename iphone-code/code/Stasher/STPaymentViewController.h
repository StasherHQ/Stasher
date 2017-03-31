//
//  STPaymentViewController.h
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParentPaymentViewController.h"
#import "STChildPaymentViewController.h"
#import "STAddChildViewController.h"
#import "STParentMakePaymentViewController.h"
#import "STChildPaymentRequestViewController.h"
#import "STPaymentLinkBankViewController.h"

@interface STPaymentViewController : UIViewController <ParentPaymentDelegate, AddChildDelegate, ChildPaymentDelegate, ParentPaymentFlowDelegate>
{
    STParentPaymentViewController *parentPaymentVC;
    STChildPaymentViewController *childPaymentVC;
    BOABHttpReq *httpReq;
    STPaymentLinkBankViewController *linkBankAccountVC;
}

@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutlet UIScrollView *paymentsScrollview;
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@end
