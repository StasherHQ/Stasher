//
//  STChildActivityViewController.h
//  Stasher
//
//  Created by bhushan on 03/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STChildMyActivityCustomCell.h"
#import "STChildGlobalActivityCustomCell.h"

@protocol ChildActivityDelegate <NSObject>

@optional

- (void) ChildActivityCellDidSelectWithDict:(NSDictionary*)dict;

@end


@interface STChildActivityViewController : UIViewController
{
     BOABHttpReq *httpReq;
}
@property (weak) id <ChildActivityDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *activityHeaderScrollview;
@property (nonatomic, strong) IBOutlet UIPageControl *activityPageControl;

@property (nonatomic, strong) IBOutlet UIView *myActivityView;
@property (nonatomic, strong) IBOutlet UIView *globalActivityView;
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UITableView *myActivityTableView;
@property (nonatomic, strong) IBOutlet UITableView *globalActivityTableView;
@property (nonatomic, strong) NSMutableArray *myActivityArray;
@property (nonatomic, strong) NSMutableArray *globalActivityArray;

@property (nonatomic, strong) IBOutlet UIImageView *ImgViewNoActivity;
@property (nonatomic, strong) IBOutlet UILabel *labelNoActivityTitle;
@property (nonatomic, strong) IBOutlet UILabel *labelNoRecentActivity;

- (void)requestActivity;

@end
