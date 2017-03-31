//
//  STParentCompletedMissionCustomTableViewCell.m
//  Stasher
//
//  Created by bhushan on 26/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STParentCompletedMissionCustomTableViewCell.h"

@implementation STParentCompletedMissionCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.labelMissionInfo setTextColor:[UIColor stasherTextColor]];
    [self.labelMissionInfo setFont:[UIFont FontGothamRoundedBookWithSize:9.0f]];
    [self.labelMissionTitle setTextColor:[UIColor stasherTextColor]];
    [self.labelMissionTitle setFont:[UIFont FontGothamRoundedBoldWithSize:12.0f]];
    [self.buttonSendReward.titleLabel setFont:[UIFont FontGothamRoundedMediumWithSize:13.0f]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}



- (IBAction)rewardButtonPressed:(id)sender
{

}


- (IBAction)sendRewardButtonPressed:(id)sender
{

}

@end
