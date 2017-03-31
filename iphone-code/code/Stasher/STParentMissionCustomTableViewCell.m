//
//  STParentMissionCustomTableViewCell.m
//  Stasher
//
//  Created by bhushan on 25/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STParentMissionCustomTableViewCell.h"

@implementation STParentMissionCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.labelMissionCount setTextColor:[UIColor stasherTextColor]];
    [self.labelMissionCount setFont:[UIFont FontGothamRoundedBookWithSize:9.0f]];
    [self.labelMissionTitle setTextColor:[UIColor stasherTextColor]];
    [self.labelMissionTitle setFont:[UIFont FontGothamRoundedBoldWithSize:12.0f]];
    [self.buttonComplete.titleLabel setFont:[UIFont FontGothamRoundedMediumWithSize:11.0f]];
    [self.buttonEdit.titleLabel setFont:[UIFont FontGothamRoundedMediumWithSize:11.0f]];
    self.imgViewChallenger.clipsToBounds = YES;
    self.imgViewChallenger.layer.cornerRadius = self.imgViewChallenger.frame.size.width/2.0f;
    self.imgViewChallenger.layer.borderColor=[UIColor clearColor].CGColor;
    self.imgViewChallenger.layer.borderWidth=1.0f;
    if (IS_STANDARD_IPHONE_6) {
        self.challengerConstraint.constant= 35.0f;
        self.dueConstraint.constant = 35.0f;
        self.rewardConstraint.constant = 35.0f;
        self.statusConstraint.constant = 35.0f;
    }
    else if (IS_STANDARD_IPHONE_6_PLUS){
        self.challengerConstraint.constant= 45.0f;
        self.dueConstraint.constant = 45.0f;
        self.rewardConstraint.constant = 45.0f;
        self.statusConstraint.constant = 45.0f;
    }
    
    self.dueProgressView.trackTintColor = [UIColor clearColor];
    self.dueProgressView.progressTintColor = [UIColor stasherMissionDueProgressColor];
    self.dueProgressView.thicknessRatio = 1.0f;
    self.dueProgressView.clockwiseProgress = YES;
    
    [self.labelDueHrs setTextColor:[UIColor stasherTextColor]];
    [self.labelDueHrs setTextAlignment:NSTextAlignmentCenter];
    [self.labelDueHrs sizeToFit];    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)editMissionButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(editMissionButtonPressedWithMissionDictionary:)]) {
        [self.delegate editMissionButtonPressedWithMissionDictionary:self.missionDictionary];
    }
}

- (IBAction)completeMissionButtonPressed:(id)sender
{
    if ([self.cellMissionTypeString isEqualToString:kMissionBarPendingMission]) {
        if ([self.delegate respondsToSelector:@selector(remindButtonPressedWithMissionDictionary:)]) {
            [self.delegate remindButtonPressedWithMissionDictionary:self.missionDictionary];
        }
    }
    else{
        if ([self.delegate respondsToSelector:@selector(completeMissionButtonPressedWithMissionDictionary:)]) {
            [self.delegate completeMissionButtonPressedWithMissionDictionary:self.missionDictionary];
        }
    }
}

@end
