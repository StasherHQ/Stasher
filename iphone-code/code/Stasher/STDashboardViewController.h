//
//  STDashboardViewController.h
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParentDashboardViewController.h"
#import "STChildDashboardViewController.h"
#import "STParentAccountChildDetailsViewController.h"
#import "STBearPopUpViewController.h"
#import "STAddParentViewController.h"
#import "STAddChildViewController.h"
#import "STParentPaymentFlowViewController.h"
#import "STAccountViewController.h"

@interface STDashboardViewController : UIViewController <ParentDashboardDelegate, BearPopUpDelegate, AddParentDelegate, AddChildDelegate, ParentPaymentFlowDelegate>
{
    STParentDashboardViewController *parentdashboardVC;
    STChildDashboardViewController *childDashboardVC ;
    STParentAccountChildDetailsViewController *childDetailsVC;
    STBearPopUpViewController *bearPopUpVC;
    BOABHttpReq *httpReq;
}

@property (nonatomic, strong) IBOutlet UIView *dashboardContainerView;
@property (nonatomic, strong) IBOutlet UILabel *headerlabel;
@end
