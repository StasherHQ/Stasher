//
//  STParentPaymentViewController.h
//  Stasher
//
//  Created by bhushan on 02/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParentPaymentCustomCell.h"
#import "STUserCustomTableViewCell.h"
@protocol ParentPaymentDelegate <NSObject>

@optional

- (void)addChildButtonPressed;
- (void)childNameSelectedWithDictionary:(NSDictionary*)childDict;
- (void)addBankAccountButtonPressed;

@end

@interface STParentPaymentViewController : UIViewController
{
    BOABHttpReq *httpReq;
}
@property (weak) id <ParentPaymentDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *childrenArray;
@property (nonatomic, strong) IBOutlet UITableView *childNamesListTableView;
@property (nonatomic, strong) IBOutlet UILabel *headerlabel;
@property (nonatomic, strong) IBOutlet UIButton *addChildButton;
@property (nonatomic, strong) IBOutlet UIButton *addBankAccountButton;
@property (nonatomic, strong) IBOutlet UILabel *myChildrenLabel;
@property (nonatomic, strong) IBOutlet UILabel *myCardsLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *containerScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;
@property (nonatomic, strong) IBOutlet UIView *controlsContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightControlContainerView;
@property (nonatomic, strong) IBOutlet UILabel *labelHeadingMyChildren;

@property (nonatomic, strong) IBOutlet UIImageView *ImgViewNoBankAcc;
@property (nonatomic, strong) IBOutlet UILabel *labelNoBankAccTitle;
@property (nonatomic, strong) IBOutlet UILabel *labelNoBankAcc;

@property (nonatomic, strong) IBOutlet UILabel *labelHeadingMyCards;
@property (nonatomic, strong) IBOutlet UITableView *tableViewBankAccounts;

@property (nonatomic, strong) NSMutableDictionary *dictBankAccountInfo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBankAccountsTableHeight;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andChildNamesArray:(NSMutableArray*)thisChildsArray;
- (void) refreshViewOnLinkedAccount;
@end
