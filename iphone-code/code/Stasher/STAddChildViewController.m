//
//  STAddChildViewController.m
//  Stasher
//
//  Created by bhushan on 18/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STAddChildViewController.h"
#import "STCreateChildViewController.h"

@interface STAddChildViewController ()

@end

@implementation STAddChildViewController
@synthesize delegate;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.addChildSelectRelationView setHidden:YES];
    [self.labelNoChildFound setText:@""];
    [self.labelNoChildFound setHidden:YES];
    [self.createChildAccountButton setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.txtFieldSearch becomeFirstResponder];
    self.relationshipEnum = PARENT ;
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
    // Do any additional setup after loading the view from its nib.
    [self.headerlabel setFont:[UIFont FontForHeader]];
    [self.createChildAccountButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.labelNoChildFound setTextColor:[UIColor stasherTextColor]];
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
    [self.labelNoChildFound setFont:[UIFont FontForGothamLightItalic:10.0f]];
    [self.labelNoChildFound setTextColor:[UIColor stasherTextColor]];
    self.relationControlContainerView.clipsToBounds = YES;
    self.relationControlContainerView.layer.cornerRadius = 10.0f;
    self.relationControlContainerView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.relationControlContainerView.layer.borderWidth=2.0f;
    [self.relationControlContainerView setBackgroundColor:[UIColor stasherPopUpBGColor]];
    [self.labelHeadingChooseRelation setFont:[UIFont FontGothamRoundedMediumWithSize:13.0f]];
    [self.labelHeadingChooseRelation setTextColor:[UIColor stasherTextColor]];
    [self.parentRelationButton setTitleColor:[UIColor stasherTextColor] forState:UIControlStateNormal];
    [self.friendRelationButton setTitleColor:[UIColor stasherTextColor] forState:UIControlStateNormal];
    [self.familyRelationButton setTitleColor:[UIColor stasherTextColor] forState:UIControlStateNormal];
    [self.addChildButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.parentRelationButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.familyRelationButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.friendRelationButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.relationPopUpCancelBtn.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.txtFieldSearch setAutocorrectionType:UITextAutocorrectionTypeNo];
    
}

- (void)rightGestureHandle
{
    [self.navigationController popViewControllerAnimated:YES];
    [STSharedCustoms sharedAddGestureInstanceWithDelegate:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ----- Actions

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addChildRelationViewButtonPressed:(id)sender
{
    [self.addChildSelectRelationView setHiddenAnimated:YES];
    /*
    if ([self.delegate respondsToSelector:@selector(childAddedWithUserDetailsDictionary:)]) {
        if ([searchResultsArray count] > selectedIndexPath.row) {
             [self.delegate childAddedWithUserDetailsDictionary:[searchResultsArray objectAtIndex:selectedIndexPath.row]];
        }
    }
     */
    if ([searchResultsArray count] > selectedIndexPath.row) {
        if (httpReq) {
            httpReq.delegate = nil;
            httpReq = nil;
        }
        httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        [paramDict setObject:[[searchResultsArray objectAtIndex:selectedIndexPath.row] objectForKey:kParamKeyUserID] forKey:@"childId"];
        [paramDict setObject:[[STUserIdentity sharedInstance] userId] forKey:@"parentId"];
        [paramDict setObject:[NSNumber numberWithInt:self.relationshipEnum] forKey:@"relation_type"];
        [paramDict setObject:kAPIActionAddChild forKey:kParamKeyAction];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
        paramDict = nil;
    }
}

- (IBAction)closeRelationshippopUpContainerView:(id)sender
{
    [self.addChildSelectRelationView setHiddenAnimated:YES];
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

- (IBAction)createChildAccountButtonPressed:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STCreateChildViewController *editProfileVC = [storyboard instantiateViewControllerWithIdentifier:@"STCreateChildViewController"];
    [self.navigationController pushViewController:editProfileVC animated:YES];
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

- (void)initiateSearching:(UITextField*)textField
{
    if ([textField.text length] > 0) {
        [self.labelNoChildFound setText:[NSString stringWithFormat:@"Can't find %@? Create your child account to use stasher now.", textField.text]];
        [self.labelNoChildFound setHidden:NO];
        [self.createChildAccountButton setHidden:NO];
        
        if (httpReq) {
            httpReq.delegate = nil;
            httpReq = nil;
        }
        httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        [paramDict setObject:textField.text forKey:@"q"];
        [paramDict setObject:kAPIActionSearchChild forKey:kParamKeyAction];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
        paramDict = nil;
    }
    else{
        [self.labelNoChildFound setText:@""];
        [self.labelNoChildFound setHidden:YES];
        [self.createChildAccountButton setHidden:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
            NSLog(@"searching for %@ ", searchString);
            [paramDict setObject:kAPIActionSearchChild forKey:kParamKeyAction];
            [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
            paramDict = nil;
             */
        }
        else{
            shouldChange = FALSE;
        }
    }
    else{
        shouldChange = TRUE;
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
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
    [self.addChildSelectRelationView setHiddenAnimated:NO];
    [self.imgViewparentBullet setImage:[UIImage imageNamed:@"buletbutton_Active"]];
    [self.imgViewFamilyBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
    [self.imgViewFriendBullet setImage:[UIImage imageNamed:@"buletbutton_Inactive"]];
}

#pragma mark - BOABHttpReqDelegates
- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        if ([[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionSearchChild]) {
            if (searchResultsArray) {
                [searchResultsArray removeAllObjects];
                searchResultsArray = nil;
            }
            searchResultsArray = [[NSMutableArray alloc] init];
            NSArray *thisSearchResultsArray = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
            if ([thisSearchResultsArray isKindOfClass:[NSArray class]]) {
                if (thisSearchResultsArray != nil && [thisSearchResultsArray count] > 0) {
                    for (NSDictionary *dict in thisSearchResultsArray){
                        if ([[dict objectForKey:kParamKeyUserType] intValue] == CHILDUSER) {
                            [searchResultsArray addObject:dict];
                        }
                    }
                    [self.searchResultsTableView reloadData];
                }
            }
            else{
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
                if ([responseDict objectForKey:@"error"]){
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
                }
                 [self.searchResultsTableView reloadData];
            }
        }
        else if ([[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionAddChild]) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
            if ([responseDict objectForKey:@"success"]) {
                [UIAlertView showWithTitle:@""
                                   message:[[responseDict objectForKey:@"success"] objectForKey:@"message"]
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex]) {
                                          if ([self.delegate respondsToSelector:@selector(childAddedWithUserDetailsDictionary:)]) {
                                              if ([searchResultsArray count] > selectedIndexPath.row) {
                                                  [self.delegate childAddedWithUserDetailsDictionary:[searchResultsArray objectAtIndex:selectedIndexPath.row]];
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
