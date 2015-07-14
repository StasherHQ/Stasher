//
//  STChildGlobalActivityCustomCell.h
//  Stasher
//
//  Created by bhushan on 12/01/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STChildGlobalActivityCustomCell : UITableViewCell
{

}
@property (nonatomic, strong) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLabelDescriptionHeight;
@property (nonatomic, strong) IBOutlet UILabel *labelActivityTitle;
@property (nonatomic, strong) IBOutlet UILabel *labelActivityTime;
@property (nonatomic, strong) IBOutlet UIImageView *activityTypeImgView;
@end
