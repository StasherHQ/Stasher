//
//  STParentAccountViewController.h
//  Stasher
//
//  Created by bhushan on 18/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParentPaymentCustomCell.h"
#import "STUserCustomTableViewCell.h"
#import "STMyChildParentNamesCustomTableViewCell.h"

@protocol ParentAccountDeleegate <NSObject>

@optional

- (void) addChildButtonPressed:(UIButton*)btn;

- (void) editProfileButtonPressed:(UIButton*)btn;

- (void)childDetailsSelectedWithDict:(NSDictionary*)dict;

- (void) createChildButtonPressed;

@end


@interface STParentAccountViewController : UIViewController
{
    
}


@property (weak) id <ParentAccountDeleegate> delegate;
@property (nonatomic, strong) IBOutlet UIButton *profilePicButton;
@property (nonatomic, strong) IBOutlet UIImageView *profilePicImageView;
@property (nonatomic, strong) IBOutlet UILabel *labelUsername;
@property (nonatomic, strong) IBOutlet UILabel *labelFullname;
@property (nonatomic, strong) IBOutlet UIButton *editProfileButton;
@property (nonatomic, strong) IBOutlet UIButton *addChildButton;
@property (nonatomic, strong) IBOutlet UIButton *addChildButtonNoTable;
@property (nonatomic, strong) IBOutlet UITableView *childNamesTable;
@property (nonatomic, strong) IBOutlet UILabel *myChildrenslabel;
@property (nonatomic, strong) NSMutableArray *childArray;
@property (nonatomic, strong) IBOutlet UIScrollView *containerScrollView;
@property (nonatomic, strong) IBOutlet UIView *controlsContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightControlContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightParentTableView;

@property (nonatomic, strong) IBOutlet UIButton *createChildButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withChildArray:(NSMutableArray*)thisChildArray;
- (void)refreshViewOnForNewChilds;
- (void)refreshViewForEditedProfile;

@end
