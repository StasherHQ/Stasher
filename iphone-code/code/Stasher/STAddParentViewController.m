//
//  STAddParentViewController.m
//  Stasher
//
//  Created by bhushan on 20/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STAddParentViewController.h"

@interface STAddParentViewController ()

@end

@implementation STAddParentViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.addParentSelectRelationView setHidden:YES];
    self.relationshipEnum = PARENT;
     [[STSharedCustoms sharedAddGestureInstanceWithDelegate:self] addRightSwipeGestureRecognizerToMe];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.headerlabel setFont:[UIFont FontForHeader]];
    
    for (id txtFields in [self.view subviews]){
        if ([txtFields isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*) txtFields;
            [textField setFont:[UIFont FontGothamRoundedBookWithSize:9.0f]];
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder
                                                                              attributes:@{
                                                                                           NSForegroundColorAttributeName:[UIColor colorWithRed:125.0f/255 green:125.0f/255 blue:125.0f/255 alpha:1.0f],
                                                                                           NSFontAttributeName : [UIFont FontGothamRoundedBookWithSize:9.0f]
                                                                                           }
                                               ];
            textField.textColor = [UIColor stasherTextColor];
        }
    }
    [self.inviteParentMailIdTxtField setFont:[UIFont FontGothamRoundedBookWithSize:9.0f]];
    self.inviteParentMailIdTxtField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.inviteParentMailIdTxtField.placeholder
                                                                      attributes:@{
                                                                                   NSForegroundColorAttributeName:[UIColor colorWithRed:125.0f/255 green:125.0f/255 blue:125.0f/255 alpha:1.0f],
                                                                                   NSFontAttributeName : [UIFont FontGothamRoundedBookWithSize:9.0f]
                                                                                   }
                                       ];
    self.inviteParentMailIdTxtField.textColor = [UIColor stasherTextColor];
    self.relationControlContainerView.clipsToBounds = YES;
    self.relationControlContainerView.layer.cornerRadius = 10.0f;
    self.relationControlContainerView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.relationControlContainerView.layer.borderWidth=2.0f;
    [self.relationControlContainerView setBackgroundColor:[UIColor stasherPopUpBGColor]];
    [self.labelHeadingChooseRelation setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    [self.labelHeadingChooseRelation setTextColor:[UIColor stasherTextColor]];
    [self.parentRelationButton setTitleColor:[UIColor stasherTextColor] forState:UIControlStateNormal];
    [self.friendRelationButton setTitleColor:[UIColor stasherTextColor] forState:UIControlStateNormal];
    [self.familyRelationButton setTitleColor:[UIColor stasherTextColor] forState:UIControlStateNormal];
    [self.addChildButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.parentRelationButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.familyRelationButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.friendRelationButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.sendInvitationButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.inviteParentButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.labelInviteParent setFont:[UIFont FontForGothamLightItalic:10.0f]];
    [self.relationPopUpCancelBtn.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.labelInviteParent setTextColor:[UIColor stasherTextColor]];
    [self.txtFieldSearch setAutocorrectionType:UITextAutocorrectionTypeNo];
   
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

#pragma mark ----- Actions

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)rightGestureHandle
{
    [self.navigationController popViewControllerAnimated:YES];
    [STSharedCustoms sharedAddGestureInstanceWithDelegate:nil];
}


- (IBAction)addParentOnRelationViewButtonPressed:(id)sender
{
    [self.addParentSelectRelationView setHidden:YES];
    if ([searchResultsArray count] > selectedIndexPath.row) {
        if (httpReq) {
            httpReq.delegate = nil;
            httpReq = nil;
        }
        httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        [paramDict setObject:[[searchResultsArray objectAtIndex:selectedIndexPath.row] objectForKey:kParamKeyUserID] forKey:@"parentId"];
        [paramDict setObject:[[STUserIdentity sharedInstance] userId] forKey:@"childId"];
        [paramDict setObject:[NSNumber numberWithInt:self.relationshipEnum] forKey:@"relation_type"];
        [paramDict setObject:kAPIActionAddParent forKey:kParamKeyAction];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
        paramDict = nil;
    }
}
- (IBAction)parentRelationButtonPressed:(id)sender
{
    self.relationshipEnum = PARENT;
    [self.imgViewparentBullet setImage:[UIImage imageNamed:@"buletbutton_Active"]];
    [self.imgViewFamilyBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
    [self.imgViewFriendBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
}


- (IBAction)familyRelationButtonPressed:(id)sender
{
    self.relationshipEnum = FAMILY;
    [self.imgViewparentBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
    [self.imgViewFamilyBullet setImage:[UIImage imageNamed:@"buletbutton_Active"]];
    [self.imgViewFriendBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
}

- (IBAction)friendRelationButtonPressed:(id)sender
{
    self.relationshipEnum = FRIEND;
    [self.imgViewparentBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
    [self.imgViewFamilyBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
    [self.imgViewFriendBullet setImage:[UIImage imageNamed:@"buletbutton_Active"]];
}

- (IBAction)closeRelationshippopUpContainerView:(id)sender
{
    [self.addParentSelectRelationView setHiddenAnimated:YES];
}

- (IBAction)inviteParentButtonPressed:(id)sender
{
    [self.txtFieldSearch resignFirstResponder];
    [self.inviteParentView setHiddenAnimated:NO];
}

- (IBAction)inviteParentClosePopUpButtonPressed:(id)sender
{
    [self.inviteParentMailIdTxtField resignFirstResponder];
    [self.inviteParentView setHiddenAnimated:YES];
}

- (IBAction)sendInvitationButtonPressed:(id)sender
{
    [self.inviteParentMailIdTxtField resignFirstResponder];
    if (![self.inviteParentMailIdTxtField.text validateEmail]) {
        [UIAlertView showWithTitle:@""
                           message:@"Please enter valid email address."
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              
                          }];
    }else{
        [self.inviteParentView setHiddenAnimated:YES];
        if (httpReq) {
            httpReq.delegate = nil;
            httpReq = nil;
        }
        httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        [paramDict setObject:self.inviteParentMailIdTxtField.text forKey:kParamKeyEmail];
        [paramDict setObject:[[STUserIdentity sharedInstance] userId] forKey:kParamKeyChildID];
        [paramDict setObject:kAPIActionInviteParent forKey:kParamKeyAction];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
        paramDict = nil;
    }
}

#pragma mark ----- Search Textfield

- (void)keyboardDidHide: (NSNotification *) notif{
    if ([self.txtFieldSearch.text containsString:@"@"]) {
        isSearchContainsAt = YES;
    }else{
        isSearchContainsAt = NO;
    }
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    if ([[self.txtFieldSearch.text stringByTrimmingCharactersInSet:characterSet] length] != 0) {
        [self initiateSearching:self.txtFieldSearch];
    }else{
        self.txtFieldSearch.text = @"";
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)initiateSearching:(UITextField *)textField
{
    if ([textField.text length] > 0) {
        if (httpReq) {
            httpReq.delegate = nil;
            httpReq = nil;
        }
        httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        [paramDict setObject:textField.text forKey:@"q"];
        [paramDict setObject:kAPIActionSearchParent forKey:kParamKeyAction];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
        paramDict = nil;
    }
    else{
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = TRUE;
    if (textField == self.txtFieldSearch) {
        if ([string validateAlphanumericSpaceAndAt]) {
            shouldChange = TRUE;
            NSString *searchString = @"";
            if ([string validateNotEmpty]) {
                searchString = [textField.text stringByAppendingString:string];
            }
            else{
                if (textField.text.length > 0) {
                    searchString = [textField.text substringToIndex:[textField.text length]-1];
                }
                else{
                    searchString = textField.text;
                }
            }
            /*
            if (httpReq) {
                httpReq.delegate = nil;
                httpReq = nil;
            }
            httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
            NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
            [paramDict setObject:searchString forKey:@"q"];
            [paramDict setObject:kAPIActionSearchParent forKey:kParamKeyAction];
            [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
            paramDict = nil;
             */
            
        }
        else{
            shouldChange = FALSE;
        }
    }
    else if (textField == self.inviteParentMailIdTxtField){
        if ([string validateEmail]) {
            shouldChange =TRUE;
        }
    }
    return shouldChange;
}

#pragma mark ----- Table Search Results

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchResultsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *stUserCellIdentifier = @"STUserCustomTableViewCell";
    STUserCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stUserCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([STUserCustomTableViewCell class]) owner:self options:0] objectAtIndex:0];
    }
    if (searchResultsArray!= nil) {
        if ([searchResultsArray count] > indexPath.row) {
            //cell.LabelName.text = [NSString stringWithFormat:@"%@ %@",[[searchResultsArray objectAtIndex:indexPath.row] objectForKey:kParamKeyFirstname],[[searchResultsArray objectAtIndex:indexPath.row] objectForKey:kParamKeyLastname]];
            if (isSearchContainsAt) {
                cell.LabelName.text = [[searchResultsArray objectAtIndex:indexPath.row] objectForKey:kParamKeyEmail];
            }else{
                cell.LabelName.text = [[searchResultsArray objectAtIndex:indexPath.row] objectForKey:kParamKeyUsername];
            }
            [cell.LabelName setTextColor:[UIColor stasherTextColor]];
            [cell.LabelName setFont:[UIFont FontGothamRoundedMediumWithSize:11.0f]];
            if (![[[searchResultsArray objectAtIndex:indexPath.row] objectForKey:kParamKeyAvatar] isKindOfClass:[NSNull class]]) {
                [cell.imgViewProfilePic setImageWithURL:[NSURL URLWithString:[[searchResultsArray objectAtIndex:indexPath.row] objectForKey:kParamKeyAvatar]] placeholderImage:[UIImage imageNamed:@"Stasher_FacePlaceHolder"]];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.imgViewCellDetail setHidden:YES];
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndexPath = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.txtFieldSearch resignFirstResponder];
    [self.addParentSelectRelationView setHiddenAnimated:NO];
}


#pragma mark - BOABHttpReqDelegates
- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        if ([[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionSearchParent]) {
            if (searchResultsArray) {
                [searchResultsArray removeAllObjects];
                searchResultsArray = nil;
            }
            searchResultsArray = [[NSMutableArray alloc] init];
            NSArray *thisSearchResultsArray = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
            if ([thisSearchResultsArray isKindOfClass:[NSArray class]]) {
                if (thisSearchResultsArray != nil && [thisSearchResultsArray count] > 0) {
                    for (NSDictionary *dict in thisSearchResultsArray){
                        if ([[dict objectForKey:kParamKeyUserType] intValue] == PARENTUSER) {
                            [searchResultsArray addObject:dict];
                        }
                    }
                    [self.searchResultsTableView reloadData];
                }
            }
            else{
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
                if (![[[responseDict objectForKey:@"error"] objectForKey:@"message"] containsString:@"compulsory"]) {
                    [UIAlertView showWithTitle:@""
                                       message:[[responseDict objectForKey:@"error"] objectForKey:@"message"]
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          if (buttonIndex == [alertView cancelButtonIndex]) {
                                          }
                                      }];
                }
                [self.searchResultsTableView reloadData];
            }
        }
        else if ([[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionAddParent]){
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
            if ([responseDict objectForKey:@"success"]) {
                [UIAlertView showWithTitle:@""
                                   message:[[responseDict objectForKey:@"success"] objectForKey:@"message"]
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex]) {
                                          if ([self.delegate respondsToSelector:@selector(parentAddedWithUserDetailsDictionary:)]) {
                                              if ([searchResultsArray count] > selectedIndexPath.row) {
                                                  [self.delegate parentAddedWithUserDetailsDictionary:[searchResultsArray objectAtIndex:selectedIndexPath.row]];
                                              }
                                          }
                                      }
                                  }];
            }
            else if ([responseDict objectForKey:@"error"]){
                [UIAlertView showWithTitle:@""
                                   message:[[responseDict objectForKey:@"error"] objectForKey:@"message"]
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex]) {
                                      }
                                  }];
            }
        }else if([[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionInviteParent]){
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
            if ([responseDict objectForKey:@"success"] && [[responseDict objectForKey:@"success"] objectForKey:@"message"]) {
                [UIAlertView showWithTitle:@""
                                   message:[[responseDict objectForKey:@"success"] objectForKey:@"message"]
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex]) {
                                          
                                      }
                                  }];
            }
            else if ([responseDict objectForKey:@"error"] && [[responseDict objectForKey:@"error"] objectForKey:@"message"]){
                [UIAlertView showWithTitle:@""
                                   message:[[responseDict objectForKey:@"error"] objectForKey:@"message"]
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex]) {
                                      }
                                  }];
            }
        }
    }
}

- (void)BOABHttpReqFailedWithError:(NSError*)error
{
    if (error) {
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.txtFieldSearch resignFirstResponder];
}


@end
