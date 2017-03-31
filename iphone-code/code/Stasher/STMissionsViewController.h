//
//  STMissionsViewController.h
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParentAddMissionViewController.h"
#import "STParentMissionsListViewController.h"
#import "STChildMissionListViewController.h"
#import "STSearchMissionViewController.h"

@interface STMissionsViewController : UIViewController <ParentMissionListDelegate, ParentAddMissionDelegate, ChildMissionListDelegate>
{
    BOABHttpReq                                     *httpReq;
    STParentAddMissionViewController                *addMissionParentVC;
    STParentMissionsListViewController              *parentMissionListVC;
    STChildMissionListViewController                *childMissionListVC;
    STChildMissionListViewController                *childMissionListVC1;
    STChildMissionListViewController                *childMissionListVC2;
    STChildMissionListViewController                *childMissionListVC3;
    STSearchMissionViewController                   *searchMissionVC;
    STParentMissionsListViewController              *parentMissionListVC1;
    STParentMissionsListViewController              *parentMissionListVC2;
    STParentMissionsListViewController              *parentMissionListVC3;
}
@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutlet UIButton *addMissionButton;
@property (nonatomic, strong) IBOutlet UIButton *addMissionSmallBtn;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollViewMissions;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControlMissions;
@property (nonatomic, strong) NSString *missionTypeString;
@property (nonatomic, strong) IBOutlet UILabel *headingMissions;
@property (nonatomic, strong) IBOutlet UIView *remindViewPopUpView;
@property (nonatomic, strong) IBOutlet UIImageView *popUpBagImgView;
@property (nonatomic, strong) IBOutlet UIButton *btnRemindClosePopUp;
@property (nonatomic, strong) IBOutlet UIButton *btnSkipRemind;
@property (nonatomic, strong) IBOutlet UIButton *btnSendRemind;
@property (nonatomic, strong) IBOutlet UITextView *notesTextView;
@property (nonatomic, strong) NSMutableDictionary *remindDict;
@property (nonatomic, strong) IBOutlet UIImageView *ImgViewNoMission;
@property (nonatomic, strong) IBOutlet UILabel *labelNoMissionTitle;
@property (nonatomic, strong) IBOutlet UILabel *labelNoMission;
@end
