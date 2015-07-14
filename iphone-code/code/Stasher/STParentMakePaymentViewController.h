//
//  STParentMakePaymentViewController.h
//  Stasher
//
//  Created by bhushan on 02/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParentPaymentFlowViewController.h"
@interface STParentMakePaymentViewController : UIViewController <STSharedCustomsDelegate>
{

}
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) NSMutableDictionary *childDictionary;
@property (nonatomic, strong) IBOutlet UILabel *labelChildName;
@property (nonatomic, strong) IBOutlet UIImageView *childAvatarImgView;
@property (nonatomic, strong) IBOutlet UIButton *oneTimeButton;
@property (nonatomic, strong) IBOutlet UIButton *recurringButton;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldAmount;
@property (nonatomic, strong) IBOutlet UITextView *txtViewMissionDescription;
@property (nonatomic, strong) IBOutlet UILabel *missionDescriptionCharLimit;
@end
