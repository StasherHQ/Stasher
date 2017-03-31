//
//  STParentDashboardViewController.h
//  Stasher
//
//  Created by bhushan on 24/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STGraphView.h"
#import "STParentPaymentCustomCell.h"
#import "STUserCustomTableViewCell.h"

@protocol ParentDashboardDelegate <NSObject>

@optional

- (void)parentDashboardChildDetailsSelectedWithDictionary:(NSDictionary*)dict;

@end


@interface STParentDashboardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,BOABHttpReqDelegate>
{
    CGPoint pointNow;
    BOABHttpReq *httpReq;
}

@property (weak) id <ParentDashboardDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *childrenArray;
@property (nonatomic, strong) IBOutlet UITableView *childNamesListTableView;
@property (nonatomic, strong) IBOutlet UIView *graphContainerView;
@property (nonatomic, strong) IBOutlet UILabel *labelDeposites;
@property (nonatomic, strong) IBOutlet UILabel *labelPendingMissions;
@property (nonatomic, strong) IBOutlet UILabel *labelActiveMissions;
@property (nonatomic, strong) IBOutlet UILabel *labelDepositesInAWeek;
@property (nonatomic, strong) IBOutlet UILabel *labelHeadingPendingMission;
@property (nonatomic, strong) IBOutlet UILabel *labelHeadingActiveMission;
@property (nonatomic, strong) IBOutlet UILabel *labelMyChildren;
@property (nonatomic, strong) IBOutlet UIScrollView *containerScrollView;
@property (nonatomic, strong) IBOutlet UILabel *labelNoGraphData;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;
@property (nonatomic, strong) IBOutlet UIView *controlsContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightControlContainerView;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewStickDivider;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithDashboardChildArray:(NSMutableArray*)thisChildArray;

- (void)requestParentGraphData;

@end
