//
//  STParentMissionCustomTableViewCell.h
//  Stasher
//
//  Created by bhushan on 25/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACircularProgressView.h"

@protocol ParentMissionCustomTableCellDelegate <NSObject>

@optional

- (void)completeMissionButtonPressedWithMissionDictionary:(NSDictionary*)dict;
- (void)remindButtonPressedWithMissionDictionary:(NSDictionary*)dict;
- (void)editMissionButtonPressedWithMissionDictionary:(NSDictionary*)dict;

@end


@interface STParentMissionCustomTableViewCell : UITableViewCell
{

}
@property (weak) id <ParentMissionCustomTableCellDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIButton *buttonComplete;
@property (nonatomic, strong) IBOutlet UIButton *buttonEdit;
@property (nonatomic, strong) IBOutlet UILabel *labelMissionCount;
@property (nonatomic, strong) IBOutlet UILabel *labelMissionTitle;
@property (nonatomic, strong) NSDictionary *missionDictionary;
@property (nonatomic, strong) NSString *cellMissionTypeString;
@property (nonatomic, strong) IBOutlet UIButton *buttonAgent;
@property (nonatomic, strong) IBOutlet UIButton *buttonTimeLeft;
@property (nonatomic, strong) IBOutlet UIButton *buttonReward;
@property (nonatomic, strong) IBOutlet UIButton *buttonStatus;
@property (nonatomic, strong) IBOutlet UILabel *labelRewardAmount;
@property (nonatomic, strong) IBOutlet UILabel *labelDueHrs;
@property (nonatomic, strong) IBOutlet UIImageView *giftIconImgView;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewChallenger;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewMissionStatus;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewDividerForCompletedMission;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewDivider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dueConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rewardConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *challengerConstraint;
@property (strong, nonatomic) IBOutlet DACircularProgressView *dueProgressView;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewMissionExpired;

@end
