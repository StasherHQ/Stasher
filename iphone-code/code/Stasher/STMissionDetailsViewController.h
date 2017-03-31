//
//  STMissionDetailsViewController.h
//  Stasher
//
//  Created by Bhushan on 24/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STMissionDetailsViewController : UIViewController
{

}


@property (nonatomic, strong) NSDictionary *missionDetailsDict;
@property (nonatomic, strong) IBOutlet UILabel *labelChallengerNameTitle;
@property (nonatomic, strong) IBOutlet UILabel *labelChallengerName;
@property (nonatomic, strong) IBOutlet UILabel *labelMissionDescriptionTitle;
@property (nonatomic, strong) IBOutlet UITextView *txtViewMissionDescription;
@property (nonatomic, strong) IBOutlet UILabel *labelMissionNameTitle;
@property (nonatomic, strong) IBOutlet UILabel *labelMissionName;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewTxtBG;
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewProfilePic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailsDict:(NSDictionary*)dict;
@end
