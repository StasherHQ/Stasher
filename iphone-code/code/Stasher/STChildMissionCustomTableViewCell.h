//
//  STChildMissionCustomTableViewCell.h
//  Stasher
//
//  Created by bhushan on 27/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACircularProgressView.h"

@protocol ChildMissionCustomTableCellDelegate <NSObject>

@optional

- (void)childCompleteMissionButtonPressedWithMissionDictionary:(NSDictionary*)dict;
- (void)childAcceptMissionButtonPressedWithMissionDictionary:(NSDictionary*)dict;
- (void)childCancelMissionButtonPressedWithMissionDictionary:(NSDictionary*)dict;

@end

@interface STChildMissionCustomTableViewCell : UITableViewCell
{

}
@property (weak) id <ChildMissionCustomTableCellDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIButton *buttonComplete;
@property (nonatomic, strong) IBOutlet UIButton *buttonCancel;
@property (nonatomic, strong) IBOutlet UILabel *labelMissionCount;
@property (nonatomic, strong) IBOutlet UILabel *labelMissionTitle;
@property (nonatomic, strong) NSDictionary *missionDictionary;
@property (nonatomic, strong) NSString *cellMissionTypeString;
@property (nonatomic, strong) IBOutlet UIButton *buttonChallenger;
@property (nonatomic, strong) IBOutlet UIButton *buttonRemainingTime;
@property (nonatomic, strong) IBOutlet UIButton *buttonReward;
@property (nonatomic, strong) IBOutlet UIButton *buttonStatus;
@property (nonatomic, strong) IBOutlet UILabel *labelRewardAmount;
@property (nonatomic, strong) IBOutlet UILabel *labelDueHrs;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewChallenger;
@property (nonatomic, strong) IBOutlet UIImageView *giftIconImgView;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewMissionStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dueConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rewardConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *challengerConstraint;
@property (strong, nonatomic) IBOutlet DACircularProgressView *dueProgressView;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewDividerForCompletedMission;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewDivider;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewMissionExpired;

@end
