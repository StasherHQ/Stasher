//
//  STChildMyActivityCustomCell.h
//  Stasher
//
//  Created by bhushan on 12/01/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STChildMyActivityCustomCell : UITableViewCell
{

}
@property (nonatomic, strong) IBOutlet UILabel *labelDescription;
@property (nonatomic, strong) IBOutlet UILabel *labelActivityTitle;
@property (nonatomic, strong) IBOutlet UIImageView *activityTypeImgView;
@property (nonatomic, strong) IBOutlet UILabel *labelActivityTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLabelDescriptionHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellHeightConstraint;
@end
