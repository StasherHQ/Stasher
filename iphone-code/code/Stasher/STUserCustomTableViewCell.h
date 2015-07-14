//
//  STUserCustomTableViewCell.h
//  Stasher
//
//  Created by bhushan on 19/01/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STUserCustomTableViewCell : UITableViewCell
{

}

@property (nonatomic, strong) IBOutlet UIImageView *imgViewProfilePic;
@property (nonatomic, strong) IBOutlet UILabel *LabelName;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewDivider;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewCellDetail;
@end
