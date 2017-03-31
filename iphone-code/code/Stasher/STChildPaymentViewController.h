//
//  STChildPaymentViewController.h
//  Stasher
//
//  Created by bhushan on 02/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STChildPaymentCustomCell.h"
#import "STUserCustomTableViewCell.h"

@protocol ChildPaymentDelegate <NSObject>

@optional

- (void)childPaymentRequestPaymentParentSelectedWithDictionary:(NSDictionary*)dict;

@end

@interface STChildPaymentViewController : UIViewController
{

}

@property (weak) id <ChildPaymentDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *parentArray;
@property (nonatomic, strong) IBOutlet UITableView *parentNamesTable;
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UILabel *mySavingsLabel;
@property (nonatomic, strong) IBOutlet UILabel *requestFromLabel;
@property (nonatomic, strong) IBOutlet UILabel *savingsAmountLabel;
@property (nonatomic, strong) IBOutlet UILabel *savingsDollarLabel;
@property (nonatomic, strong) IBOutlet UIButton *myHistoryLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *containerScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;
@property (nonatomic, strong) IBOutlet UIView *controlsContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightControlContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightParentTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andParentnamesArray:(NSMutableArray*)thisParentsArray;
@end
