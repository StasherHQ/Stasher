//
//  STUserCustomTableViewCell.m
//  Stasher
//
//  Created by bhushan on 19/01/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import "STUserCustomTableViewCell.h"

@implementation STUserCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.imgViewProfilePic.clipsToBounds = YES;
    self.imgViewProfilePic.layer.cornerRadius = self.imgViewProfilePic.frame.size.width/2.0f;
    self.imgViewProfilePic.layer.borderColor=[UIColor clearColor].CGColor;
    self.imgViewProfilePic.layer.borderWidth=1.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
