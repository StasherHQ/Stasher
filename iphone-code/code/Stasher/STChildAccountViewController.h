//
//  STChildAccountViewController.h
//  Stasher
//
//  Created by bhushan on 18/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STChildPaymentCustomCell.h"
#import "STUserCustomTableViewCell.h"
#import "STMyChildParentNamesCustomTableViewCell.h"

@protocol ChildAccountDelegate <NSObject>

@optional

- (void) childAccountAddParentButtonPressed:(UIButton*)sender;
- (void) childAccountEditProfileButtonPressed:(UIButton*)sender;
- (void) childAccountParentDetailsSelectedWithDictionary:(NSDictionary*)dict;
@end

@interface STChildAccountViewController : UIViewController
{

}

@property (weak) id <ChildAccountDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *parentArray;
@property (nonatomic, strong) IBOutlet UIButton *profilePicButton;
@property (nonatomic, strong) IBOutlet UIImageView *profilePicImageView;
@property (nonatomic, strong) IBOutlet UILabel *labelUsername;
@property (nonatomic, strong) IBOutlet UILabel *labelFullname;
@property (nonatomic, strong) IBOutlet UIButton *editProfileButton;
@property (nonatomic, strong) IBOutlet UITableView *parentNamesTable;
@property (nonatomic, strong) IBOutlet UIButton *addCommandersNoTableButton;
@property (nonatomic, strong) IBOutlet UIButton *addCommandersButton;
@property (nonatomic, strong) IBOutlet UILabel *noCommandersLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *containerScrollView;
@property (nonatomic, strong) IBOutlet UILabel *labelMyCommanders;
@property (nonatomic, strong) IBOutlet UILabel *labelMySavings;
@property (nonatomic, strong) IBOutlet UIView *controlsContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightControlContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightParentTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withParentArray:(NSMutableArray*)thisParentArray;
- (void)refreshViewForNewParents;
- (void)refreshViewLabelsOnEditProfile;

@end
