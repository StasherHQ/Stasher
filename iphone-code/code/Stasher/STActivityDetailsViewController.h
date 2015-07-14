//
//  STActivityDetailsViewController.h
//  Stasher
//
//  Created by Bhushan on 24/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STActivityDetailsViewController : UIViewController
{
    BOABHttpReq *httpReq;
}

@property (nonatomic, assign) ActivityType *activityType;
@property (nonatomic, strong) IBOutlet NSDictionary *detailsDict;
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UILabel *labelActivityDescription;
@property (nonatomic, strong) IBOutlet UIView *atContainerView;
@property (nonatomic, strong) IBOutlet UIView *atView11;
@property (nonatomic, strong) IBOutlet UILabel *labelActivityTitleView11;
@property (nonatomic, strong) IBOutlet UIButton *buttonCancelATView11;
@property (nonatomic, strong) IBOutlet UIButton *buttonAcceptATView11;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewProfilePicView11;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailsDict:(NSDictionary*)dict;

@end
