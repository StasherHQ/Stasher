//
//  STParentCompletedMissionCustomTableViewCell.h
//  Stasher
//
//  Created by bhushan on 26/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STParentCompletedMissionCustomTableViewCell : UITableViewCell
{

}

@property (nonatomic, strong) IBOutlet UILabel *labelMissionInfo;
@property (nonatomic, strong) IBOutlet UILabel *labelMissionTitle;
@property (nonatomic, strong) IBOutlet UIButton *buttonReward;
@property (nonatomic, strong) IBOutlet UIButton *buttonSendReward;
@property (nonatomic, strong) IBOutlet UILabel *labelRewardAmount;
@property (nonatomic, strong) IBOutlet UIImageView *giftIconImgView;
@end
