//
//  STChildDashboardViewController.h
//  Stasher
//
//  Created by bhushan on 21/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STGraphView.h"
#import "STParentMyActivityCustomCell.h"

@interface STChildDashboardViewController : UIViewController <BOABHttpReqDelegate>
{
    BOABHttpReq *httpReq;
    CGPoint pointNow;
    CGPoint actualMyBadgesHeaderViewCenter;
}


@property (nonatomic, strong) NSMutableArray *parentsArray;
@property (nonatomic, strong) NSMutableArray *myActivityArray;
@property (nonatomic, strong) IBOutlet UIView *graphContainerView;
@property (nonatomic, strong) IBOutlet UILabel *childNameLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *containerScrollView;
@property (nonatomic, strong) IBOutlet UIButton *myBadgesButton;
@property (nonatomic, strong) IBOutlet UIView *scrollChildContainerView;
@property (nonatomic, strong) IBOutlet UIButton *profilePicButton;
@property (nonatomic, strong) IBOutlet UIImageView *profilePicImgView;
@property (nonatomic, strong) IBOutlet UILabel *lblFirstName;
@property (nonatomic, strong) IBOutlet UILabel *lblLastName;
@property (nonatomic, strong) IBOutlet UILabel *lblActiveMissionsCount;
@property (nonatomic, strong) IBOutlet UILabel *lblPendingMissionsCount;
@property (nonatomic, strong) IBOutlet UILabel *lblCompletedMissionsCount;
@property (nonatomic, strong) IBOutlet UILabel *lblActiveMissionsHeading;
@property (nonatomic, strong) IBOutlet UILabel *lblPendingMissionsHeading;
@property (nonatomic, strong) IBOutlet UILabel *lblCompletedMissionsHeading;
@property (nonatomic, strong) IBOutlet UILabel *lblTotal;
@property (nonatomic, strong) IBOutlet UILabel *lblSaved;
@property (nonatomic, strong) IBOutlet UILabel *lblInAWeek;
@property (nonatomic, strong) IBOutlet UILabel *lblDollar;
@property (nonatomic, strong) IBOutlet UILabel *lblSavingsAmount;
@property (nonatomic, strong) IBOutlet UIButton *activityButton;
@property (nonatomic, strong) IBOutlet UIView *badgesContainerView;
@property (nonatomic, strong) IBOutlet UIView *activityContainerView;
@property (nonatomic, strong) IBOutlet UIImageView *badge1ImgView;
@property (nonatomic, strong) IBOutlet UIImageView *badge2ImgView;
@property (nonatomic, strong) IBOutlet UIImageView *badge3ImgView;
@property (nonatomic, strong) IBOutlet UIImageView *badge4ImgView;
@property (nonatomic, strong) IBOutlet UIImageView *badge5ImgView;
@property (nonatomic, strong) IBOutlet UITableView *myActivityTableView;
@property (nonatomic, strong) IBOutlet UILabel *labelNoGraphData;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewStickDivider;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightMyActivityTableViewContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightmyActivityTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightControlsContView;


@property (nonatomic, strong) IBOutlet UILabel *labelBadge1;
@property (nonatomic, strong) IBOutlet UILabel *labelBadge2;
@property (nonatomic, strong) IBOutlet UILabel *labelBadge3;
@property (nonatomic, strong) IBOutlet UILabel *labelBadge4;
@property (nonatomic, strong) IBOutlet UILabel *labelBadge5;

@property (nonatomic, strong) IBOutlet UIView *myBadgesHeaderView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithDashboardParentArray:(NSMutableArray*)thisParentArray;
- (void)requestChildGraphDetails;

@end
