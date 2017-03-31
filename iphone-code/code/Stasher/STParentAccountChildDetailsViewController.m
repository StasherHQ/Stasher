//
//  STParentAccountChildDetailsViewController.m
//  Stasher
//
//  Created by bhushan on 02/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STParentAccountChildDetailsViewController.h"
#import "STParentMakePaymentViewController.h"

@interface STParentAccountChildDetailsViewController ()

@end

@implementation STParentAccountChildDetailsViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withChildDetailsDictionary:(NSDictionary*)thisChildsDictionary
{
    self = [super initWithNibName:@"STParentAccountChildDetailsViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        if (thisChildsDictionary) {
            self.childDetailsDictionary = [NSMutableDictionary dictionaryWithDictionary:thisChildsDictionary];
            [self requestChildDetails];
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if([self.childDetailsDictionary objectForKey:kParamKeyUsername])
        [self.labelUsername setText:[self.childDetailsDictionary objectForKey:kParamKeyUsername]];
    
    if([self.childDetailsDictionary objectForKey:kParamKeyFirstname] && [self.childDetailsDictionary objectForKey:kParamKeyLastname])
        [self.labelCompleteName setText:[NSString stringWithFormat:@"%@ %@",[self.childDetailsDictionary objectForKey:kParamKeyFirstname],[self.childDetailsDictionary objectForKey:kParamKeyLastname]]];
    
    if([self.childDetailsDictionary objectForKey:kParamKeyDateOfBirth]){
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *theDate = [dateFormat dateFromString:[self.childDetailsDictionary objectForKey:kParamKeyDateOfBirth]];
        if ([self ageFromBirthday:theDate] > 0) {
            [self.labelAge setText:[NSString stringWithFormat:@"%d years old", (int)[self ageFromBirthday:theDate]]];
        }
        else{
            [self.labelAge setText:@""];
        }
    }
    if (![[self.childDetailsDictionary objectForKey:kParamKeyAvatar] isKindOfClass:[NSNull class]]&& ![[self.childDetailsDictionary objectForKey:kParamKeyAvatar] isEqualToString:@""]) {
        [self.childProfilePicImgView setImageWithURL:[NSURL URLWithString:[self.childDetailsDictionary objectForKey:kParamKeyAvatar]]placeholderImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }else{
        [self.childProfilePicImgView setImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.headerLabel setFont:[UIFont FontForHeader]];
    [self.labelAge setFont:[UIFont FontGothamRoundedMediumWithSize:9.0f]];
    [self.labelCompleteName setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    [self.labelUsername setFont:[UIFont FontGothamRoundedMediumWithSize:18.0f]];
    [self.otherChallengersLabel setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    [self.otherChallengersLabel setTextColor:[UIColor stasherTextColor]];
    [self.childSavingsLabel setFont:[UIFont FontGothamRoundedMediumWithSize:11.0f]];
    [self.childSavingsLabel setTextColor:[UIColor stasherTextColor]];
    [self.labelAge setTextColor:[UIColor stasherTextColor]];
    [self.labelCompleteName setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
    [self.labelUsername setTextColor:[UIColor stasherTextColor]];
    [self.historyButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.transferButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    self.childProfilePicImgView.clipsToBounds = YES;
    self.childProfilePicImgView.layer.cornerRadius = 80/2.0f;
    self.childProfilePicImgView.layer.borderColor=[UIColor clearColor].CGColor;
    self.childProfilePicImgView.layer.borderWidth=0.5f;
    self.childProfilePicImgView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[STSharedCustoms sharedAddGestureInstanceWithDelegate:self] addRightSwipeGestureRecognizerToMe];
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

#pragma mark ----- Custom Methods

- (void)adjustHeightOfTableview
{
    CGFloat height = self.tableOtherCommanders.contentSize.height;
    CGFloat maxHeight = self.tableOtherCommanders.superview.frame.size.height - self.tableOtherCommanders.frame.origin.y;
    
    // if the height of the content is greater than the maxHeight of
    // total space on the screen, limit the height to the size of the
    // superview.
    
    if (height > maxHeight)
        height = maxHeight;
    
    // now set the frame accordingly
    
    CGRect frame = self.tableOtherCommanders.frame;
    frame.size.height = height;
    self.tableOtherCommanders.frame = frame;
    // if you have other controls that should be resized/moved to accommodate
    // the resized tableview, do that here, too
    self.tableHeightConstraint.constant = self.tableOtherCommanders.contentSize.height;
    self.constraintHeightControlContainerView.constant = self.tableOtherCommanders.frame.origin.y + self.tableOtherCommanders.contentSize.height + 8.0f;
}


- (void) requestChildDetails
{
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:NO];
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    if ([self.childDetailsDictionary objectForKey:kParamKeyUserID] != nil) {
        [paramDict setObject:[self.childDetailsDictionary objectForKey:kParamKeyUserID] forKey:kParamKeyUserID];
        [paramDict setObject:kAPIActionProfile forKey:kParamKeyAction];
        [paramDict setObject:@"no" forKey:kParamKeySaveResponseLocally];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
        paramDict = nil;
    }
}

- (NSInteger)ageFromBirthday:(NSDate *)birthdate {
    if (birthdate != nil) {
        NSDate *today = [NSDate date];
        NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                           components:NSCalendarUnitYear
                                           fromDate:birthdate
                                           toDate:today
                                           options:0];
        return ageComponents.year;
    }
    return 0;
}

#pragma mark ----- Actions

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)transferFundsButtonPressed:(id)sender
{
    
    if ([self.childDetailsDictionary objectForKey:kParamKeyUserFirstKnoxTID] != nil && ![[self.childDetailsDictionary objectForKey:kParamKeyUserFirstKnoxTID] isEqualToString:@""]) {
    }else{
        [UIAlertView showWithTitle:@""
                           message:@"You must link the Child's savings account before transferring funds. Would you like to link one now?"
                 cancelButtonTitle:@"No"
                 otherButtonTitles:[NSArray arrayWithObjects:@"Yes", nil]
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex != [alertView cancelButtonIndex]) {
                                  [self addBankAccountButtonPressedForBankAccountType:2 andUserInfoDict:self.childDetailsDictionary];
                              }
                          }];
        return;
    }
    
    if ([[STUserIdentity sharedInstance] userKnoxFirstTransactionID] != nil && ![[[STUserIdentity sharedInstance] userKnoxFirstTransactionID] isEqualToString:@""]) {
        if ([self.childDetailsDictionary objectForKey:kParamKeyUserFirstKnoxTID] != nil && ![[self.childDetailsDictionary objectForKey:kParamKeyUserFirstKnoxTID] isEqualToString:@""]) {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            STParentMakePaymentViewController *parentMakePaymentVC = [storyboard instantiateViewControllerWithIdentifier:@"STParentMakePaymentViewController"];
            parentMakePaymentVC.childDictionary = [self.childDetailsDictionary mutableCopy];
            [self.navigationController pushViewController:parentMakePaymentVC animated:YES];
        }else{
            [UIAlertView showWithTitle:@""
                               message:@"You must link the Child's savings account before transferring funds. Would you like to link one now?"
                     cancelButtonTitle:@"No"
                     otherButtonTitles:[NSArray arrayWithObjects:@"Yes", nil]
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  if (buttonIndex != [alertView cancelButtonIndex]) {
                                      [self addBankAccountButtonPressedForBankAccountType:2 andUserInfoDict:self.childDetailsDictionary];
                                  }
                              }];
        }
    }else{
        [UIAlertView showWithTitle:@""
                           message:@"You must link your bank account before transfering funds to child. Would you like to link one now?"
                 cancelButtonTitle:@"No"
                 otherButtonTitles:[NSArray arrayWithObjects:@"Yes", nil]
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex != [alertView cancelButtonIndex]) {
                                  [self addBankAccountButtonPressedForBankAccountType:1 andUserInfoDict:self.childDetailsDictionary];
                              }
                          }];
    }
}

- (IBAction)viewHistoryButtonPressed:(id)sender
{
    [UIAlertView showWithTitle:@""
                       message:@"Under Development!"
             cancelButtonTitle:@"OK"
             otherButtonTitles:nil
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                          }
                      }];

}

- (void)addBankAccountButtonPressedForBankAccountType:(int)bankAccType andUserInfoDict:(NSDictionary*)dict
{
    if (bankAccType == 1) {
        /*
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        STParentPaymentFlowViewController *parentPaymentFlowVC = [storyboard instantiateViewControllerWithIdentifier:@"STParentPaymentFlowViewController"];
        parentPaymentFlowVC.paymentParamsDict  = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0.01",@"amount",@"Add parent bank account",@"description", nil];
        parentPaymentFlowVC.delegate = self;
        parentPaymentFlowVC.bankAccountTypeInt = 1;
        [self.navigationController pushViewController:parentPaymentFlowVC animated:YES];
         */
        if (linkBankAccountVC) {
            linkBankAccountVC = nil;
        }
        linkBankAccountVC = [[STPaymentLinkBankViewController alloc] initWithNibName:@"STPaymentLinkBankViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:linkBankAccountVC animated:YES];
    }else if (bankAccType == 2){
        /*
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        STParentPaymentFlowViewController *parentPaymentFlowVC = [storyboard instantiateViewControllerWithIdentifier:@"STParentPaymentFlowViewController"];
        parentPaymentFlowVC.paymentParamsDict  = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0.01",@"amount",@"Add child bank account",@"description", dict,@"childInfoDict",nil];
        parentPaymentFlowVC.delegate = self;
        parentPaymentFlowVC.bankAccountTypeInt = 2;
        [self.navigationController pushViewController:parentPaymentFlowVC animated:YES];
         */
        if (linkBankAccountVC) {
            linkBankAccountVC = nil;
        }
        linkBankAccountVC = [[STPaymentLinkBankViewController alloc] initWithNibName:@"STPaymentLinkBankViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:linkBankAccountVC animated:YES];
    }
}

- (void)addAccountSuccessFullWithDict:(NSDictionary*)dict andBankAccountUserType:(int)bankAccType
{
    //NSLog(@"Add account successful %@",dict);
    if (bankAccType == 1) {
        [UIAlertView showWithTitle:@""
                           message:@"Parent's Account linked!"
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                              }
                          }];
    }else if (bankAccType ==2){
        [UIAlertView showWithTitle:@""
                           message:@"Child's Account linked!"
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == [alertView cancelButtonIndex]) {
                              }
                          }];
    }
}

- (void)rightGestureHandle
{
    [self.navigationController popViewControllerAnimated:YES];
    [STSharedCustoms sharedAddGestureInstanceWithDelegate:nil];
}

#pragma mark ----- Table Parent names

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.otherCommandersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *stUserCellIdentifier = @"STUserCustomTableViewCell";
    STUserCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stUserCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([STUserCustomTableViewCell class]) owner:self options:0] objectAtIndex:0];
    }
    if (self.otherCommandersArray!= nil) {
        if ([self.otherCommandersArray count] > indexPath.row) {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.LabelName.text = [NSString stringWithFormat:@"%@ %@",[[self.otherCommandersArray objectAtIndex:indexPath.row] objectForKey:kParamKeyFirstname],[[self.otherCommandersArray objectAtIndex:indexPath.row] objectForKey:kParamKeyLastname]];
            [cell.LabelName setTextColor:[UIColor stasherTextColor]];
            [cell.imgViewDivider setHidden:YES];
            [cell.LabelName setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
            if (![[[self.otherCommandersArray objectAtIndex:indexPath.row] objectForKey:kParamKeyAvatar] isKindOfClass:[NSNull class]]) {
                [cell.imgViewProfilePic setImageWithURL:[NSURL URLWithString:[[self.otherCommandersArray objectAtIndex:indexPath.row] objectForKey:kParamKeyAvatar]] placeholderImage:[UIImage imageNamed:@"Stasher_FacePlaceHolder"]];
            }
            [cell.imgViewCellDetail setHidden:YES];
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"selected parent %@",[NSString stringWithFormat:@"%@ %@",[[self.otherCommandersArray objectAtIndex:indexPath.row] objectForKey:kParamKeyFirstname],[[self.otherCommandersArray objectAtIndex:indexPath.row] objectForKey:kParamKeyLastname]]);
}

#pragma mark ----- BOABHttpReqDelegates
- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if (responseDictionary) {
            if ([responseDictionary objectForKey:@"usedetails"] && [[responseDictionary objectForKey:@"usedetails"] isKindOfClass:[NSDictionary class]]) {
                if ([responseDictionary objectForKey:kParamKeyParent]) {
                    if ([[responseDictionary objectForKey:kParamKeyParent] isKindOfClass:[NSArray class]]) {
                        self.otherCommandersArray = [[responseDictionary objectForKey:kParamKeyParent] mutableCopy];
                        for (NSDictionary *dict in [self.otherCommandersArray copy]){
                            if ([[dict objectForKey:kParamKeyUserID] isEqualToString:[[STUserIdentity sharedInstance] userId]]) {
                                [self.otherCommandersArray removeObject:dict];
                            }
                        }
                        if ([self.otherCommandersArray count] < 1) {
                            [self.otherChallengersLabel setHidden:YES];
                        }else{
                            [self.otherChallengersLabel setHidden:NO];
                        }
                        [self.tableOtherCommanders reloadData];
                        [self adjustHeightOfTableview];
                    }
                }
            }
        }
    }
}

@end
