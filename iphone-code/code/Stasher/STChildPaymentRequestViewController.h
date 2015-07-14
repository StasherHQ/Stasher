//
//  STChildPaymentRequestViewController.h
//  Stasher
//
//  Created by bhushan on 03/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STChildPaymentRequestViewController : UIViewController
{
    BOABHttpReq *httpReq;
}
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UIButton *requestButton;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldAmount;
@property (nonatomic, strong) IBOutlet UITextView *txtViewMissionDescription;
@property (nonatomic, strong) IBOutlet UILabel *missionDescriptionCharLimit;
@property (nonatomic, strong) NSMutableDictionary *parentInfoDict;
@end
