//
//  STMissionsViewController.m
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STMissionsViewController.h"
#import "STMissionDetailsViewController.h"

@interface STMissionsViewController ()

@end

@implementation STMissionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
        [self.addMissionButton setHidden:NO];
        [self.addMissionSmallBtn setHidden:NO];
    }
    else{
        [self.addMissionButton setHidden:YES];
        [self.addMissionSmallBtn setHidden:YES];
    }
    [self setUpMissionNamesScrollView];
    self.remindViewPopUpView.clipsToBounds = YES;
    self.remindViewPopUpView.layer.cornerRadius = 10.0f;
    self.remindViewPopUpView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.remindViewPopUpView.layer.borderWidth=2.0f;
    [self.remindViewPopUpView setBackgroundColor:[UIColor stasherPopUpBGColor]];
    [self.btnSendRemind.titleLabel setFont:[UIFont FontForButtonsWithSize:13.0f]];
    [self.btnSkipRemind.titleLabel setFont:[UIFont FontForButtonsWithSize:13.0f]];
    [self.notesTextView setFont:[UIFont FontForTextFields]];
    
    [self.labelNoMissionTitle setFont:[UIFont FontGothamRoundedBookWithSize:19.88f]];
    [self.labelNoMission setFont:[UIFont FontGothamRoundedBookWithSize:8.83f]];
    [self.labelNoMissionTitle sizeToFit];
    [self.labelNoMission sizeToFit];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.ImgViewNoMission setHidden:YES];
    [self.labelNoMission setHidden:YES];
    [self.labelNoMissionTitle setHidden:YES];
    
    [self setHeaderLabelText];
    
    for (UIView *view in [self.scrollViewMissions subviews]){
        [view removeFromSuperview];
    }
    
    if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
        if ([self.missionTypeString isEqualToString:kMissionBarActiveMission]) {
            if(!parentMissionListVC1){
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            }else{
                [parentMissionListVC1.view removeFromSuperview];
                parentMissionListVC1 = nil;
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            }
        }
        else if ([self.missionTypeString isEqualToString:kMissionBarPendingMission]){
            if(!parentMissionListVC2)
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            else{
                [parentMissionListVC2.view removeFromSuperview];
                parentMissionListVC2 = nil;
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            }
        }
        else if ([self.missionTypeString isEqualToString:kMissionBarCompletedMission]) {
            if(!parentMissionListVC3)
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            else{
                [parentMissionListVC3.view removeFromSuperview];
                parentMissionListVC3 = nil;
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            }
        }else{
            if(!parentMissionListVC1)
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            else{
                [parentMissionListVC1.view removeFromSuperview];
                parentMissionListVC1 = nil;
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            }
        }
    }
    else{
        if ([self.missionTypeString isEqualToString:kMissionBarActiveMission]) {
            if(!childMissionListVC1){
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            }else{
                [childMissionListVC1.view removeFromSuperview];
                childMissionListVC1 = nil;
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            }
        }
        else if ([self.missionTypeString isEqualToString:kMissionBarPendingMission]){
            if(!childMissionListVC2)
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            else{
                [childMissionListVC2.view removeFromSuperview];
                childMissionListVC2 = nil;
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            }
        }
        else if ([self.missionTypeString isEqualToString:kMissionBarCompletedMission]) {
            if(!childMissionListVC3)
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            else{
                [childMissionListVC3.view removeFromSuperview];
                childMissionListVC3 = nil;
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            }
        }else{
            if(!childMissionListVC1)
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            else{
                [childMissionListVC1.view removeFromSuperview];
                childMissionListVC1 = nil;
                [self addMissionsListViewWithMissionType:self.missionTypeString];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

# pragma mark -----------------Common---------------------

#pragma mark ----- Custom Methods

- (void) setUpMissionNamesScrollView
{
    NSArray *namesArray = [NSArray arrayWithObjects:@"Active Missions",@"Pending Missions",@"Completed Missions", nil];
    CGRect missionNameButtonFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.containerView.frame.size.height);
    for (int c = 0; c < 3; c++) {
        UIButton *missionNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        switch (c) {
            case 0:
                
                break;
            case 1:
                    [missionNameButton setTitle:[NSString stringWithFormat:@"%@ (%@)",[namesArray objectAtIndex:c],[[STUserIdentity sharedInstance] pendingMissionsCount]] forState:UIControlStateNormal];
                break;
            case 2:
                [missionNameButton setTitle:[NSString stringWithFormat:@"%@ (%@)",[namesArray objectAtIndex:c],[[STUserIdentity sharedInstance] completedMissionsCount]] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        [missionNameButton.titleLabel setTextColor:[UIColor stasherTextColor]];
        [missionNameButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [missionNameButton setFrame:missionNameButtonFrame];
        [missionNameButton addTarget:self action:@selector(missionNameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollViewMissions addSubview:missionNameButton];
        missionNameButtonFrame.origin.x+=missionNameButtonFrame.size.width;
    }
    CGSize contentSize = self.scrollViewMissions.frame.size;
    contentSize.width = missionNameButtonFrame.origin.x;
    contentSize.height = 0.0f;
    [self.scrollViewMissions setContentSize:contentSize];
    [self.pageControlMissions setNumberOfPages:3];
}

- (void) missionNameButtonPressed:(id)sender
{
    
}

- (void)addMissionsListViewWithMissionType:(NSString*)typeString
{
    if (typeString == nil) {
        self.missionTypeString = kMissionBarActiveMission;
        [self.scrollViewMissions setContentOffset:CGPointZero animated:YES];
        [self.pageControlMissions setCurrentPage:0];
    }
    int currentIndex = (int)self.pageControlMissions.currentPage;
    if (currentIndex == 0) {
        [self.pageControlMissions setCurrentPage:0];
        self.missionTypeString = kMissionBarActiveMission;
    }
    else if (currentIndex == 1) {
        [self.pageControlMissions setCurrentPage:1];
        self.missionTypeString = kMissionBarPendingMission;
    }
    else {
        [self.pageControlMissions setCurrentPage:2];
        self.missionTypeString = kMissionBarCompletedMission;
    }
    [self requestMissionListOfType:self.missionTypeString];
}

- (void) requestMissionListOfType:(NSString*)thisMissionTypeString
{
    NSString *typeString;
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    NSString *userIdString ;
    if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
        userIdString = kParamKeyParentID;
        if ([thisMissionTypeString isEqualToString:kMissionBarActiveMission]) {
            typeString = kAPIActionParentActiveMissions;
        }
        else if ([thisMissionTypeString isEqualToString:kMissionBarCompletedMission]) {
            typeString = kAPIActionParentCompletedMissions;
        }
        else{
            typeString = kAPIActionParentPendingMissions;
        }
    }
    else if ([[STUserIdentity sharedInstance] userIdentity] == CHILDUSER){
        userIdString = kParamKeyChildID;
        if ([thisMissionTypeString isEqualToString:kMissionBarActiveMission]) {
            typeString = kAPIActionChildActiveMissions;
        }
        else if ([thisMissionTypeString isEqualToString:kMissionBarCompletedMission]) {
            typeString = kAPIActionChildCompletedMissions;
        }
        else{
            typeString = kAPIActionChildPendingMissions;
        }
    }
    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[[STUserIdentity sharedInstance] userId] intValue]], userIdString,typeString,kParamKeyAction,nil] json:YES];
}

-  (void) setHeaderLabelText
{
    
    if ([self.missionTypeString isEqualToString:kMissionBarActiveMission]) {
        UIFont *font1 = [UIFont FontForHeader];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Active " attributes: arialDict];
        
        UIFont *font2 = [UIFont FontForHeaderNoBold];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%@)",@"Missions",[[STUserIdentity sharedInstance] activeMissionsCount]] attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        self.headingMissions.attributedText = aAttrString1;
    }
    else if ([self.missionTypeString isEqualToString:kMissionBarPendingMission]){
        UIFont *font1 = [UIFont FontForHeader];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Pending " attributes: arialDict];
        
        UIFont *font2 = [UIFont FontForHeaderNoBold];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%@)",@"Missions",[[STUserIdentity sharedInstance] pendingMissionsCount]] attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        self.headingMissions.attributedText = aAttrString1;
    }
    else if ([self.missionTypeString isEqualToString:kMissionBarCompletedMission]) {
        UIFont *font1 = [UIFont FontForHeader];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Completed " attributes: arialDict];
        
        UIFont *font2 = [UIFont FontForHeaderNoBold];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%@)",@"Missions",[[STUserIdentity sharedInstance] completedMissionsCount]] attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        self.headingMissions.attributedText = aAttrString1;
    }else{
        UIFont *font1 = [UIFont FontForHeader];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Active " attributes: arialDict];
        
        UIFont *font2 = [UIFont FontForHeaderNoBold];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%@)",@"Missions",[[STUserIdentity sharedInstance] activeMissionsCount]] attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        self.headingMissions.attributedText = aAttrString1;
    }
}

-  (void) setHeaderLabelTextWithCount:(int)missionCount
{
    
    if ([self.missionTypeString isEqualToString:kMissionBarActiveMission]) {
        UIFont *font1 = [UIFont FontForHeader];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Active " attributes: arialDict];
        
        UIFont *font2 = [UIFont FontForHeaderNoBold];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%d)",@"Missions",missionCount] attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        self.headingMissions.attributedText = aAttrString1;
    }
    else if ([self.missionTypeString isEqualToString:kMissionBarPendingMission]){
        UIFont *font1 = [UIFont FontForHeader];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Pending " attributes: arialDict];
        
        UIFont *font2 = [UIFont FontForHeaderNoBold];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%d)",@"Missions",missionCount] attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        self.headingMissions.attributedText = aAttrString1;
    }
    else if ([self.missionTypeString isEqualToString:kMissionBarCompletedMission]) {
        UIFont *font1 = [UIFont FontForHeader];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Completed " attributes: arialDict];
        
        UIFont *font2 = [UIFont FontForHeaderNoBold];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%d)",@"Missions",missionCount] attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        self.headingMissions.attributedText = aAttrString1;
    }else{
        UIFont *font1 = [UIFont FontForHeader];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Active " attributes: arialDict];
        
        UIFont *font2 = [UIFont FontForHeaderNoBold];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%@)",@"Missions",[[STUserIdentity sharedInstance] activeMissionsCount]] attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        self.headingMissions.attributedText = aAttrString1;
    }
}


#pragma mark ----- Actions

- (IBAction)searchMissionButtonPressed:(id)sender
{
    if (searchMissionVC) {
        searchMissionVC = nil;
    }
    searchMissionVC = [[STSearchMissionViewController alloc] initWithNibName:@"STSearchMissionViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:searchMissionVC animated:YES];
}

#pragma mark ----- Scrollview Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.ImgViewNoMission setHidden:YES];
    [self.labelNoMission setHidden:YES];
    [self.labelNoMissionTitle setHidden:YES];
    int currentIndex = (int) (self.scrollViewMissions.contentOffset.x / self.scrollViewMissions.frame.size.width) ;
    [self.pageControlMissions setCurrentPage:currentIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentIndex = (int)self.pageControlMissions.currentPage;
    if ([[STUserIdentity sharedInstance] userIdentity] ==PARENTUSER) {
        if (currentIndex == 0) {
            self.missionTypeString = kMissionBarActiveMission;
            if (parentMissionListVC1!=nil) {
                [parentMissionListVC1.view removeFromSuperview];
                parentMissionListVC1 = nil;
            }
            [self addMissionsListViewWithMissionType:self.missionTypeString];
        }
        else if (currentIndex == 1) {
            self.missionTypeString = kMissionBarPendingMission;
            if (parentMissionListVC2!=nil) {
                [parentMissionListVC2.view removeFromSuperview];
                parentMissionListVC2 = nil;
            }
            [self addMissionsListViewWithMissionType:self.missionTypeString];
        }
        else {
            
            self.missionTypeString = kMissionBarCompletedMission;
            if (parentMissionListVC3!=nil) {
                [parentMissionListVC3.view removeFromSuperview];
                parentMissionListVC3 = nil;
            }
            [self addMissionsListViewWithMissionType:self.missionTypeString];
        }
    }else{
        if (currentIndex == 0) {
            self.missionTypeString = kMissionBarActiveMission;
            if (childMissionListVC1!=nil) {
                [childMissionListVC1.view removeFromSuperview];
                childMissionListVC1 = nil;
            }
            [self addMissionsListViewWithMissionType:self.missionTypeString];
        }
        else if (currentIndex == 1) {
            self.missionTypeString = kMissionBarPendingMission;
            if (childMissionListVC2!=nil) {
                [childMissionListVC2.view removeFromSuperview];
                childMissionListVC2 = nil;
            }
            [self addMissionsListViewWithMissionType:self.missionTypeString];
        }
        else {
            
            self.missionTypeString = kMissionBarCompletedMission;
            if (childMissionListVC3!=nil) {
                [childMissionListVC3.view removeFromSuperview];
                childMissionListVC3 = nil;
            }
            [self addMissionsListViewWithMissionType:self.missionTypeString];
        }
    }
   
    [self setHeaderLabelText];
}

# pragma mark ------------------ PARENT -------------------

- (IBAction)addMissionButtonPressed:(id)sender
{
    if (addMissionParentVC) {
        addMissionParentVC = nil;
    }
    addMissionParentVC = [[STParentAddMissionViewController alloc] initWithNibName:@"STParentAddMissionViewController" bundle:[NSBundle mainBundle]];
    addMissionParentVC.isEditMode = FALSE;
    addMissionParentVC.isMissionDetailMode = FALSE;
    addMissionParentVC.delegate = self;
    [self.navigationController pushViewController:addMissionParentVC animated:YES];
}

- (void) parentCellEditMissionButtonPressedWithMissionDict:(NSDictionary*)dict
{
    if (addMissionParentVC) {
        addMissionParentVC = nil;
    }
    addMissionParentVC = [[STParentAddMissionViewController alloc] initWithNibName:@"STParentAddMissionViewController" bundle:[NSBundle mainBundle]];
    addMissionParentVC.isEditMode = TRUE;
    addMissionParentVC.isMissionDetailMode = FALSE;
    addMissionParentVC.delegate = self;
    [addMissionParentVC editMissionRefreshViewWithDictionary:dict];
    [self.navigationController pushViewController:addMissionParentVC animated:YES];
}

- (void) parentCellCompleteMissionButtonPressedWithMissionDict:(NSDictionary*)dict
{
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    NSString *userIdString, *apiActionString;
    if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
        userIdString = kParamKeyParentID;
        apiActionString = kAPIActionParentCompleteMission;
    }
    else if ([[STUserIdentity sharedInstance] userIdentity] == CHILDUSER){
        userIdString = kParamKeyChildID;
        apiActionString = kAPIActionChildCompleteMission;
    }
    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[[STUserIdentity sharedInstance] userId] intValue]], userIdString,apiActionString,kParamKeyAction,[dict objectForKey:kParamKeyMissionId],kParamKeyMissionId,nil] json:YES];
}

- (void) parentCellRemindMissionButtonPressedWithMissionDict:(NSDictionary *)dict
{
    [self.btnRemindClosePopUp setHiddenAnimated:NO];
    [self.popUpBagImgView setHiddenAnimated:NO];
    [self.remindViewPopUpView setHiddenAnimated:NO];
    [self.notesTextView becomeFirstResponder];
    if (self.remindDict) {
        self.remindDict = nil;
    }
    self.remindDict = [NSMutableDictionary dictionaryWithDictionary:[dict mutableCopy]];
}

- (void)parentMissionListCellDidSelectWithDict:(NSDictionary *)dict
{
    /*
    STMissionDetailsViewController *missionDetailsVC = [[STMissionDetailsViewController alloc] initWithNibName:@"STMissionDetailsViewController" bundle:[NSBundle mainBundle] detailsDict:dict];
    [self.navigationController pushViewController:missionDetailsVC animated:YES];
     */
    
    if (addMissionParentVC) {
        addMissionParentVC = nil;
    }
    addMissionParentVC = [[STParentAddMissionViewController alloc] initWithNibName:@"STParentAddMissionViewController" bundle:[NSBundle mainBundle]];
    addMissionParentVC.isEditMode = FALSE;
    addMissionParentVC.isMissionDetailMode = TRUE;
    addMissionParentVC.delegate = self;
    [addMissionParentVC editMissionRefreshViewWithDictionary:dict];
    [self.navigationController pushViewController:addMissionParentVC animated:YES];
}

- (IBAction)remindPopUpSkipButtonPressed:(id)sender
{
    [self.btnRemindClosePopUp setHiddenAnimated:YES];
    [self.popUpBagImgView setHiddenAnimated:YES];
    [self.remindViewPopUpView setHiddenAnimated:YES];
    [self.notesTextView resignFirstResponder];
}

- (IBAction)remindPopUpSendButtonPressed:(id)sender
{
    [self.notesTextView resignFirstResponder];
    [self.btnRemindClosePopUp setHiddenAnimated:YES];
    [self.popUpBagImgView setHiddenAnimated:YES];
    [self.remindViewPopUpView setHiddenAnimated:YES];
    
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[[STUserIdentity sharedInstance] userId] intValue]],kParamKeyParentID, [self.remindDict objectForKey:kParamKeyMissionId],kParamKeyMissionId,[[self.remindDict objectForKey:kParamKeyChild] objectForKey:kParamKeyUserID],kParamKeyChildID,kAPIActionRemindMission,kParamKeyAction,self.notesTextView.text,@"message",nil] json:YES];
}

- (void)missionUpdatedAdded
{
    [self addMissionsListViewWithMissionType:nil];
}


# pragma mark ------------------ CHILD --------------------

- (void)childMissionListCellDidSelectWithDict:(NSDictionary *)dict
{
    /*
    STMissionDetailsViewController *missionDetailsVC = [[STMissionDetailsViewController alloc] initWithNibName:@"STMissionDetailsViewController" bundle:[NSBundle mainBundle] detailsDict:dict];
    [self.navigationController pushViewController:missionDetailsVC animated:YES];
     */
    
    if (addMissionParentVC) {
        addMissionParentVC = nil;
    }
    addMissionParentVC = [[STParentAddMissionViewController alloc] initWithNibName:@"STParentAddMissionViewController" bundle:[NSBundle mainBundle]];
    addMissionParentVC.isEditMode = FALSE;
    addMissionParentVC.isMissionDetailMode = TRUE;
    addMissionParentVC.delegate = self;
    [addMissionParentVC editMissionRefreshViewWithDictionary:dict];
    [self.navigationController pushViewController:addMissionParentVC animated:YES];
}

- (void) childCellCompleteMissionButtonPressedWithMissionDict:(NSDictionary*)dict
{
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    NSString *userIdString, *apiActionString;
    userIdString = kParamKeyChildID;
    apiActionString = kAPIActionChildCompleteMission;
    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[[STUserIdentity sharedInstance] userId] intValue]], userIdString,apiActionString,kParamKeyAction,[dict objectForKey:kParamKeyMissionId],kParamKeyMissionId,nil] json:YES];
}

- (void)childCellAcceptMissionButtonPressedWithMissionDict:(NSDictionary *)dict
{
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    NSString *userIdString, *apiActionString;
    userIdString = kParamKeyChildID;
    apiActionString = kAPIActionChildAcceptMission;
    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[[STUserIdentity sharedInstance] userId] intValue]], userIdString,apiActionString,kParamKeyAction,[dict objectForKey:kParamKeyMissionId],kParamKeyMissionId,nil] json:YES];
}

- (void)childCellCancelMissionButtonPressedWithMissionDict:(NSDictionary *)dict
{
    NSLog(@"Canceled with dict %@",dict);
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[[STUserIdentity sharedInstance] userId] intValue]], kParamKeyChildID,kAPIActionDeleteMission,kParamKeyAction,[dict objectForKey:kParamKeyMissionId],kParamKeyMissionId,[[dict objectForKey:kParamKeyParent] objectForKey:kParamKeyUserID],kParamKeyParentID,nil] json:YES];
}

# pragma mark ------ TextView Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL shouldChange = YES;
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    if (textView == self.notesTextView) {
        NSString *notesDescription = [textView.text stringByAppendingString:text];
        if (notesDescription.length > 250) {
            shouldChange = NO;
        }
    }
    return shouldChange;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == self.notesTextView) {
        if ([self.notesTextView.text isEqualToString:@"Add Note"]) {
            textView.text = @"";
        }
    }
    textView.textColor = [UIColor stasherTextColor];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == self.notesTextView) {
        if (![textView.text validateNotEmpty]) {
            textView.textColor = [UIColor stasherTextFieldPlaceHolderColor];
            textView.text = @"Add Note";
        }
    }
}


#pragma mark ----- BOABRequestDelegate Delegate

- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if (responseDict) {
            if ([[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionParentCompletedMissions]
                || [[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionParentActiveMissions]
                || [[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionParentPendingMissions]
                || [[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionChildActiveMissions]
                || [[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionChildPendingMissions]
                || [[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionChildCompletedMissions]) {
                if ([responseDict isKindOfClass:[NSArray class]]) {
                    if (![responseDict isKindOfClass:[NSNull class]]) {
                        [self setHeaderLabelTextWithCount:(int)[[responseDict mutableCopy] count]];
                    }
                    if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
                        CGRect missionNameButtonFrame;
                        if ([self.missionTypeString isEqualToString:kMissionBarActiveMission]) {
                            missionNameButtonFrame = CGRectMake(0, 0, self.view.frame.size.width, self.containerView.frame.size.height);
                            parentMissionListVC1 = [[STParentMissionsListViewController alloc] initWithNibName:@"STParentMissionsListViewController" bundle:[NSBundle mainBundle] missionListType:self.missionTypeString andMissionListArray:[responseDict mutableCopy]];
                            CGRect rect = parentMissionListVC1.view.frame;
                            rect.size.width = self.containerView.frame.size.width;
                            rect.size.height = self.containerView.frame.size.height;
                            [parentMissionListVC1.view setFrame:missionNameButtonFrame];
                            [self.scrollViewMissions addSubview:parentMissionListVC1.view withAnimation:YES];
                            [parentMissionListVC1.missionListTableView reloadData];
                            parentMissionListVC1.delegate = self;
                        }
                        else if ([self.missionTypeString isEqualToString:kMissionBarPendingMission]){
                            if (IS_STANDARD_IPHONE_6_PLUS) {
                                 missionNameButtonFrame = CGRectMake(self.view.frame.size.width-10, 0 , self.view.frame.size.width, self.containerView.frame.size.height);
                            }
                            else{
                                 missionNameButtonFrame = CGRectMake(self.view.frame.size.width, 0 , self.view.frame.size.width, self.containerView.frame.size.height);
                            }
                           
                            parentMissionListVC2 = [[STParentMissionsListViewController alloc] initWithNibName:@"STParentMissionsListViewController" bundle:[NSBundle mainBundle] missionListType:self.missionTypeString andMissionListArray:[responseDict mutableCopy]];
                            CGRect rect = parentMissionListVC2.view.frame;
                            rect.size.width = self.containerView.frame.size.width;
                            rect.size.height = self.containerView.frame.size.height;
                            [parentMissionListVC2.view setFrame:missionNameButtonFrame];
                            [self.scrollViewMissions addSubview:parentMissionListVC2.view withAnimation:YES];
                            [parentMissionListVC2.missionListTableView reloadData];
                            parentMissionListVC2.delegate = self;
                        }else{
                            if (IS_STANDARD_IPHONE_6_PLUS) {
                                 missionNameButtonFrame = CGRectMake(2 * self.view.frame.size.width-18, 0, self.view.frame.size.width, self.containerView.frame.size.height);
                            }
                            else{
                                 missionNameButtonFrame = CGRectMake(2 * self.view.frame.size.width, 0, self.view.frame.size.width, self.containerView.frame.size.height);
                            }
                           
                            parentMissionListVC3 = [[STParentMissionsListViewController alloc] initWithNibName:@"STParentMissionsListViewController" bundle:[NSBundle mainBundle] missionListType:self.missionTypeString andMissionListArray:[responseDict mutableCopy]];
                            CGRect rect = parentMissionListVC3.view.frame;
                            rect.size.width = self.containerView.frame.size.width;
                            rect.size.height = self.containerView.frame.size.height;
                            [parentMissionListVC3.view setFrame:missionNameButtonFrame];
                            [self.scrollViewMissions addSubview:parentMissionListVC3.view withAnimation:YES];
                            [parentMissionListVC3.missionListTableView reloadData];
                            parentMissionListVC3.delegate = self;
                        }
                    }
                    else if ([[STUserIdentity sharedInstance] userIdentity] == CHILDUSER){
                        CGRect missionNameButtonFrame;
                        if ([self.missionTypeString isEqualToString:kMissionBarActiveMission]) {
                            missionNameButtonFrame = CGRectMake(0, 0, self.view.frame.size.width, self.containerView.frame.size.height);
                            childMissionListVC1 = [[STChildMissionListViewController alloc] initWithNibName:@"STChildMissionListViewController" bundle:[NSBundle mainBundle] missionListType:self.missionTypeString andMissionListArray:[responseDict mutableCopy]];
                            CGRect rect = childMissionListVC1.view.frame;
                            rect.size.width = self.containerView.frame.size.width;
                            rect.size.height = self.containerView.frame.size.height;
                            [childMissionListVC1.view setFrame:missionNameButtonFrame];
                            [self.scrollViewMissions addSubview:childMissionListVC1.view withAnimation:YES];
                            [childMissionListVC1.tableViewChildMissionList reloadData];
                            childMissionListVC1.delegate = self;
                        }
                        else if ([self.missionTypeString isEqualToString:kMissionBarPendingMission]){
                            if (IS_STANDARD_IPHONE_6_PLUS) {
                                missionNameButtonFrame = CGRectMake(self.view.frame.size.width-10, 0 , self.view.frame.size.width, self.containerView.frame.size.height);
                            }
                            else{
                                missionNameButtonFrame = CGRectMake(self.view.frame.size.width, 0 , self.view.frame.size.width, self.containerView.frame.size.height);
                            }
                            childMissionListVC2 = [[STChildMissionListViewController alloc] initWithNibName:@"STChildMissionListViewController" bundle:[NSBundle mainBundle] missionListType:self.missionTypeString andMissionListArray:[responseDict mutableCopy]];
                            CGRect rect = childMissionListVC2.view.frame;
                            rect.size.width = self.containerView.frame.size.width;
                            rect.size.height = self.containerView.frame.size.height;
                            [childMissionListVC2.view setFrame:missionNameButtonFrame];
                            [self.scrollViewMissions addSubview:childMissionListVC2.view withAnimation:YES];
                            [childMissionListVC2.tableViewChildMissionList reloadData];
                            childMissionListVC2.delegate = self;
                        }else{
                            if (IS_STANDARD_IPHONE_6_PLUS) {
                                missionNameButtonFrame = CGRectMake(2 * self.view.frame.size.width-18, 0, self.view.frame.size.width, self.containerView.frame.size.height);
                            }
                            else{
                                missionNameButtonFrame = CGRectMake(2 * self.view.frame.size.width, 0, self.view.frame.size.width, self.containerView.frame.size.height);
                            }
                            childMissionListVC3 = [[STChildMissionListViewController alloc] initWithNibName:@"STChildMissionListViewController" bundle:[NSBundle mainBundle] missionListType:self.missionTypeString andMissionListArray:[responseDict mutableCopy]];
                            CGRect rect = childMissionListVC3.view.frame;
                            rect.size.width = self.containerView.frame.size.width;
                            rect.size.height = self.containerView.frame.size.height;
                            [childMissionListVC3.view setFrame:missionNameButtonFrame];
                            [self.scrollViewMissions addSubview:childMissionListVC3.view withAnimation:YES];
                            [childMissionListVC3.tableViewChildMissionList reloadData];
                            childMissionListVC3.delegate = self;
                        }
                    }
                }
                else{
                    if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
                        if ([self.missionTypeString isEqualToString:kMissionBarActiveMission]) {
                            [self.labelNoMissionTitle setText:[NSString stringWithFormat:@"No %@",kMissionBarActiveMission]];
                            [self.labelNoMission setText:@"Active Missions are tasks or goals that your child has accepted.\n\nClick the + sign above to create a new mission.\n\nSwipe right to view Pending and Completed missions."];
                        }else if ([self.missionTypeString isEqualToString:kMissionBarPendingMission]){
                            [self.labelNoMissionTitle setText:[NSString stringWithFormat:@"No %@",kMissionBarPendingMission]];
                            [self.labelNoMission setText:@"Pending Missions are tasks or goals that are waiting to be accepted by your child.\n\nSwipe right to view Completed missions, left to view Active Missions."];
                        }else if ([self.missionTypeString isEqualToString:kMissionBarCompletedMission]){
                            [self.labelNoMissionTitle setText:[NSString stringWithFormat:@"No %@",kMissionBarCompletedMission]];
                            [self.labelNoMission setText:@"Completed Missions are tasks that your child has completed.\n\nSwipe left to view Active and Pending missions."];
                        }
                    }
                    else if ([[STUserIdentity sharedInstance] userIdentity] == CHILDUSER){
                        if ([self.missionTypeString isEqualToString:kMissionBarActiveMission]) {
                            [self.labelNoMissionTitle setText:[NSString stringWithFormat:@"No %@",kMissionBarActiveMission]];
                            [self.labelNoMission setText:@"Active Missions are tasks or goals that you’ve accepted.\n\nSwipe right to view Pending and Completed missions."];
                        }else if ([self.missionTypeString isEqualToString:kMissionBarPendingMission]){
                            [self.labelNoMissionTitle setText:[NSString stringWithFormat:@"No %@",kMissionBarPendingMission]];
                            [self.labelNoMission setText:@"Pending Missions are tasks or goals that are waiting for you to accept!\n\nSwipe right to view Completed missions, left to view Active Missions."];
                        }else if ([self.missionTypeString isEqualToString:kMissionBarCompletedMission]){
                            [self.labelNoMissionTitle setText:[NSString stringWithFormat:@"No %@",kMissionBarCompletedMission]];
                            [self.labelNoMission setText:@"Completed Missions are tasks that you’ve completed completed.\n\nSwipe left to view Active and Pending missions."];
                        }
                    }
                    
                    
                    [self.labelNoMission sizeToFit];
                    [self.ImgViewNoMission setHidden:NO];
                    [self.labelNoMission setHidden:NO];
                    [self.labelNoMissionTitle setHidden:NO];
                }
            }
            else if ([[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionParentCompleteMission]
                     ||[[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionChildAcceptMission]
                     ||[[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionChildCompleteMission])
            {
                if ([responseDict objectForKey:@"success"]) {
                    [UIAlertView showWithTitle:@""
                                       message:[[responseDict objectForKey:@"success"] objectForKey:@"message"]
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          if (! [[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionChildAcceptMission]) {
                                              [self addMissionsListViewWithMissionType:nil];
                                          }
                                      }];
                }
                else if ([responseDict objectForKey:@"error"]) {
                    [UIAlertView showWithTitle:@""
                                       message:[[responseDict objectForKey:@"error"] objectForKey:@"message"]
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          
                                      }];
                }
            }
            else if ([[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionRemindMission]){
                if ([responseDict objectForKey:@"success"]) {
                    [UIAlertView showWithTitle:@""
                                       message:[[responseDict objectForKey:@"success"] objectForKey:@"message"]
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          
                                      }];
                }
                else if ([responseDict objectForKey:@"error"]) {
                    [UIAlertView showWithTitle:@""
                                       message:[[responseDict objectForKey:@"error"] objectForKey:@"message"]
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          
                                      }];
                }
            }else if ([[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionDeleteMission]){
                if ([responseDict objectForKey:@"success"]) {
                    [UIAlertView showWithTitle:@""
                                       message:[[responseDict objectForKey:@"success"] objectForKey:@"message"]
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          [[self.scrollViewMissions delegate] scrollViewDidEndDecelerating:self.scrollViewMissions];
                                      }];
                }
                else if ([responseDict objectForKey:@"error"]) {
                    [UIAlertView showWithTitle:@""
                                       message:[[responseDict objectForKey:@"error"] objectForKey:@"message"]
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          
                                      }];
                }
            }
        }
    }
}

- (void)BOABHttpReqFailedWithError:(NSError*)error
{
    if (error) {
        
    }
}
@end
