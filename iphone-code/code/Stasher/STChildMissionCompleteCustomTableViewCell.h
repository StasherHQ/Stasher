//
//  STChildMissionCompleteCustomTableViewCell.h
//  Stasher
//
//  Created by bhushan on 27/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STChildMissionCompletedCellDelegate <NSObject>

@optional

- (void)ChildMissionCompletedCellRequestRewardButtonPressedWithDict:(NSDictionary*)dict;

@end

@interface STChildMissionCompleteCustomTableViewCell : UITableViewCell
{

}

@property (weak) id <STChildMissionCompletedCellDelegate> delegate;
@property (nonatomic, strong) IBOutlet UILabel *labelMissionInfo;
@property (nonatomic, strong) IBOutlet UILabel *labelMissionTitle;
@property (nonatomic, strong) IBOutlet UIButton *buttonReward;
@property (nonatomic, strong) IBOutlet UIButton *buttonSendReward;
@property (nonatomic, strong) IBOutlet UILabel *labelRewardAmount;
@property (nonatomic, strong) IBOutlet UIImageView *giftIconImgView;
@property (nonatomic, strong) NSDictionary *missionDict;
@end
