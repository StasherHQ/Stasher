//
//  STAddParentViewController.h
//  Stasher
//
//  Created by bhushan on 20/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STUserCustomTableViewCell.h"

@protocol AddParentDelegate <NSObject>

@optional

- (void)parentAddedWithUserDetailsDictionary:(NSDictionary*)infoDict;

@end



@interface STAddParentViewController : UIViewController <STSharedCustomsDelegate>
{
    BOABHttpReq *httpReq;
    NSMutableArray *searchResultsArray;
    NSIndexPath *selectedIndexPath;
    
    BOOL isSearchContainsAt;
}
@property (weak) id <AddParentDelegate> delegate;
@property (nonatomic, assign) RelationShipToChild relationshipEnum;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldSearch;
@property (nonatomic, strong) IBOutlet UITableView *searchResultsTableView;
@property (nonatomic, strong) IBOutlet UIView *addParentSelectRelationView;
@property (nonatomic, strong) IBOutlet UILabel *labelInviteParent;
@property (nonatomic, strong) IBOutlet UIButton *inviteParentButton;
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
@property (nonatomic, strong) IBOutlet UIView *inviteParentView;
@property (nonatomic, strong) IBOutlet UIImageView *inviteParentPopUpImgView;
@property (nonatomic, strong) IBOutlet UITextField *inviteParentMailIdTxtField;
@property (nonatomic, strong) IBOutlet UIButton *sendInvitationButton;
@property (nonatomic, strong) IBOutlet UIButton *relationPopUpCancelBtn;
@end
