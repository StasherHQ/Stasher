//
//  STParentAddMissionViewController.h
//  Stasher
//
//  Created by bhushan on 24/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ParentAddMissionDelegate <NSObject>

@optional

- (void)missionUpdatedAdded;

@end


@interface STParentAddMissionViewController : UIViewController <UINavigationControllerDelegate>
{
    BOABHttpReq *httpReq;
    NSMutableArray *childIdsArray;
    NSMutableArray *childBUttonArray;
}
@property (weak) id <ParentAddMissionDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *requestParamsDictionary;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollViewChildrens;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollViewContainer;
@property (nonatomic, strong) IBOutlet UITextField *missionTitleTextField;
@property (nonatomic, strong) IBOutlet UITextView *missionDescriptionTextView;
@property (nonatomic, strong) IBOutlet UIDatePicker *missionDateTimePicker;
@property (nonatomic, strong) IBOutlet UIButton *missionSetDateButton;
@property (nonatomic, strong) IBOutlet UISwitch *switchRewardType;
@property (nonatomic, strong) IBOutlet UITextField *rewardTextField;
@property (nonatomic, strong) IBOutlet UIButton *assignMissionButton;
@property (nonatomic, strong) IBOutlet UIButton *saveDraftMissionButton;
@property (nonatomic, strong) IBOutlet UISwitch *switchTimeBased;
@property (nonatomic, strong) IBOutlet UISwitch *switchMissionScope;
@property (nonatomic, strong) IBOutlet UIView *dateTimePickerContainerView;
@property (nonatomic, assign) BOOL isEditMode;
@property (nonatomic, assign) BOOL isMissionDetailMode;
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UIImageView *transparentImageView;
@property (nonatomic, strong) IBOutlet UIButton *buttonClosePopUp;
@property (nonatomic, strong) IBOutlet UILabel *labelMissionDescCharLimit;
@property (nonatomic, strong) IBOutlet UILabel *labelMissionNameCharLimit;
@property (nonatomic, strong) IBOutlet UIView *controlsContainerView;
@property (nonatomic, strong) IBOutlet UILabel *labelHeadingSelectChild;
@property (nonatomic, strong) IBOutlet UILabel *labelHeadingIsTimeBased;
@property (nonatomic, strong) IBOutlet UILabel *labelHeadingReward;
@property (nonatomic, strong) IBOutlet UILabel *labelHeadingMissionScope;
@property (nonatomic, strong) IBOutlet UIButton *buttonDatePickerOk;
@property (nonatomic, strong) IBOutlet UIButton *buttonDatePickerCancel;
@property (nonatomic, strong) IBOutlet UILabel *labelSelectMissionDate;
@property (nonatomic, strong) IBOutlet UILabel *labelSelectDueDateTime;

@property (nonatomic, strong) IBOutlet UIView *rewardCustomSwitch;
@property (nonatomic, strong) IBOutlet UIButton *buttonSwitchCash;
@property (nonatomic, strong) IBOutlet UIButton *buttonSwitchGift;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewGreen;

@property (nonatomic, strong) IBOutlet UIView *timeBasedCustomSwitchView;
@property (nonatomic, strong) IBOutlet UIButton *buttonSwitchYes;
@property (nonatomic, strong) IBOutlet UIButton *buttonSwitchNo;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewGreenTimeSwitch;

@property (nonatomic, strong) IBOutlet UIView *scopeCustomSwitchView;
@property (nonatomic, strong) IBOutlet UIButton *buttonSwitchPublic;
@property (nonatomic, strong) IBOutlet UIButton *buttonSwitchPrivate;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewGreenScopeSwitch;


- (void) editMissionRefreshViewWithDictionary:(NSDictionary*)dict;
@end
