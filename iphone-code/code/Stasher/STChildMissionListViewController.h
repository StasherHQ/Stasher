//
//  STChildMissionListViewController.h
//  Stasher
//
//  Created by bhushan on 27/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STChildMissionCustomTableViewCell.h"
#import "STChildMissionCompleteCustomTableViewCell.h"

@protocol ChildMissionListDelegate <NSObject>

@optional

- (void) childCellCompleteMissionButtonPressedWithMissionDict:(NSDictionary*)dict;
- (void) childCellAcceptMissionButtonPressedWithMissionDict:(NSDictionary*)dict;
- (void) childCellCancelMissionButtonPressedWithMissionDict:(NSDictionary*)dict;
- (void) childMissionListCellDidSelectWithDict:(NSDictionary*)dict;

@end

@interface STChildMissionListViewController : UIViewController <ChildMissionCustomTableCellDelegate,STChildMissionCompletedCellDelegate,BOABHttpReqDelegate>
{
    BOABHttpReq *httpReq;
}

@property (weak) id <ChildMissionListDelegate> delegate;
@property (nonatomic, strong) IBOutlet UITableView *tableViewChildMissionList;
@property (nonatomic, strong) NSString *missionsListType;
@property (nonatomic, strong) NSMutableArray *arrayMissionList;


- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil missionListType:(NSString*)missionsListKind andMissionListArray:(NSMutableArray*)array;
@end
