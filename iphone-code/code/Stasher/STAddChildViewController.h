//
//  STAddChildViewController.h
//  Stasher
//
//  Created by bhushan on 18/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STUserCustomTableViewCell.h"

@protocol AddChildDelegate <NSObject>

- (void)childAddedWithUserDetailsDictionary:(NSDictionary*)infoDict;

@end



@interface STAddChildViewController : UIViewController <STSharedCustomsDelegate>
{
    BOABHttpReq *httpReq;
    NSMutableArray *searchResultsArray;
    NSIndexPath *selectedIndexPath;
    
    BOOL isSearchContainsAt;
}
@property (weak) id <AddChildDelegate> delegate;
@property (nonatomic, assign) RelationShipToChild relationshipEnum;
@property (nonatomic, strong) IBOutlet UIView *addChildSelectRelationView;
@property (nonatomic, strong) IBOutlet UIButton *createChildAccountButton;
@property (nonatomic, strong) IBOutlet UILabel *labelNoChildFound;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldSearch;
@property (nonatomic, strong) IBOutlet UITableView *searchResultsTableView;
@property (nonatomic, strong) IBOutlet UIButton *parentRelationButton;
@property (nonatomic, strong) IBOutlet UIButton *familyRelationButton;
@property (nonatomic, strong) IBOutlet UIButton *friendRelationButton;
@property (nonatomic, strong) IBOutlet UILabel *headerlabel;
@property (nonatomic, strong) IBOutlet UIView *relationControlContainerView;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewparentBullet;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewFamilyBullet;
@property (nonatomic, strong) IBOutlet UIImageView *imgViewFriendBullet;
@property (nonatomic, strong) IBOutlet UILabel *labelHeadingChooseRelation;
@property (nonatomic, strong) IBOutlet UIButton *addChildButton;
@property (nonatomic, strong) IBOutlet UIButton *relationPopUpCancelBtn;

@end
