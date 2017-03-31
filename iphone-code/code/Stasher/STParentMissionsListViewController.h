//
//  STParentMissionsListViewController.h
//  Stasher
//
//  Created by bhushan on 25/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParentMissionCustomTableViewCell.h"
#import "STParentCompletedMissionCustomTableViewCell.h"

@protocol ParentMissionListDelegate <NSObject>

@optional

- (void) parentCellEditMissionButtonPressedWithMissionDict:(NSDictionary*)dict;
- (void) parentCellCompleteMissionButtonPressedWithMissionDict:(NSDictionary*)dict;
- (void) parentCellRemindMissionButtonPressedWithMissionDict:(NSDictionary*)dict;
- (void) parentMissionListCellDidSelectWithDict:(NSDictionary*)dict;

@end



@interface STParentMissionsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ParentMissionCustomTableCellDelegate>
{
    
}
@property (weak) id <ParentMissionListDelegate> delegate;
@property (nonatomic, strong) IBOutlet UITableView *missionListTableView;
@property (nonatomic, strong) NSString *missionsListType;
@property (nonatomic, strong) NSMutableArray *arrayMissionList;


- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil missionListType:(NSString*)missionsListKind andMissionListArray:(NSMutableArray*)array;
@end
