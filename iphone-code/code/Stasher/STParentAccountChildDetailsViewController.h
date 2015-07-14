//
//  STParentAccountChildDetailsViewController.h
//  Stasher
//
//  Created by bhushan on 02/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STMyChildParentNamesCustomTableViewCell.h"
#import "STUserCustomTableViewCell.h"
#import "STParentPaymentFlowViewController.h"
#import "STPaymentLinkBankViewController.h"
@interface STParentAccountChildDetailsViewController : UIViewController <STSharedCustomsDelegate, ParentPaymentFlowDelegate>
{
    BOABHttpReq *httpReq;
    
    STPaymentLinkBankViewController *linkBankAccountVC;
}



@property (nonatomic, strong) NSMutableDictionary *childDetailsDictionary;
@property (nonatomic, strong) IBOutlet UITableView *tableOtherCommanders;
@property (nonatomic, strong) NSMutableArray *otherCommandersArray;

@property (nonatomic, strong) IBOutlet UILabel *labelUsername;
@property (nonatomic, strong) IBOutlet UILabel *labelCompleteName;
@property (nonatomic, strong) IBOutlet UILabel *labelAge;
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UIButton *historyButton;
@property (nonatomic, strong) IBOutlet UIButton *transferButton;
@property (nonatomic, strong) IBOutlet UIImageView *childProfilePicImgView;
@property (nonatomic, strong) IBOutlet UILabel *otherChallengersLabel;
@property (nonatomic, strong) IBOutlet UILabel *childSavingsLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *containerScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;
@property (nonatomic, strong) IBOutlet UIView *controlsContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightControlContainerView;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withChildDetailsDictionary:(NSDictionary*)thisChildsDictionary;
@end
