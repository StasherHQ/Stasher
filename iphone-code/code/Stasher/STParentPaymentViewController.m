//
//  STParentPaymentViewController.m
//  Stasher
//
//  Created by bhushan on 02/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STParentPaymentViewController.h"

@interface STParentPaymentViewController ()

@end

@implementation STParentPaymentViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andChildNamesArray:(NSMutableArray*)thisChildsArray
{
    self = [super initWithNibName:@"STParentPaymentViewController" bundle:[NSBundle mainBundle]];
    
    if (self) {
        self.childrenArray = [[NSMutableArray alloc] initWithArray:thisChildsArray];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.headerlabel setFont:[UIFont FontForHeader]];
    [self.addChildButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.addBankAccountButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.myCardsLabel setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    [self.myChildrenLabel setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    [self.labelHeadingMyCards setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    [self.labelHeadingMyChildren setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    [self.labelHeadingMyCards setTextColor:[UIColor stasherTextColor]];
    [self.labelHeadingMyChildren setTextColor:[UIColor stasherTextColor]];
    
    [self.labelNoBankAccTitle setFont:[UIFont FontGothamRoundedBookWithSize:10.88f]];
    [self.labelNoBankAcc setFont:[UIFont FontGothamRoundedBookWithSize:9.83f]];
    [self.labelNoBankAccTitle sizeToFit];
    [self.labelNoBankAcc sizeToFit];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if ([[STUserIdentity sharedInstance] userKnoxFirstTransactionID] != nil && ![[[STUserIdentity sharedInstance] userKnoxFirstTransactionID] isEqualToString:@""])
    {
        if (httpReq) {
            httpReq.delegate = nil;
            httpReq = nil;
        }
        httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
        NSString *userIdString, *apiActionString;
        userIdString = kParamKeyParentID;
        apiActionString = kAPIActionAddBankAccount;
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[[STUserIdentity sharedInstance] userId] intValue]], userIdString,apiActionString,kParamKeyAction,[[STUserIdentity sharedInstance] userKnoxFirstTransactionID],kParamKeyTransactionID,nil] json:YES];
    }
    [self refreshViewOnLinkedAccount];
    if ([self.childrenArray count] == 0) {
        [self.myChildrenLabel setHidden:YES];
    }else{
        [self.myChildrenLabel setHidden:NO];
    }
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self adjustHeightOfTableview];
}

- (void)refreshViewOnLinkedAccount
{
    if ([[STUserIdentity sharedInstance] userKnoxFirstTransactionID] != nil && ![[[STUserIdentity sharedInstance] userKnoxFirstTransactionID] isEqualToString:@""]) {
        [self.labelHeadingMyCards setHidden:NO];
        [self.tableViewBankAccounts setHidden:NO];
        [self.tableViewBankAccounts reloadData];
        
        [self.ImgViewNoBankAcc setHidden:YES];
        [self.labelNoBankAccTitle setHidden:YES];
        [self.labelNoBankAcc setHidden:YES];
        [self.addBankAccountButton setHidden:NO];
    }else{
        [self.ImgViewNoBankAcc setHidden:NO];
        [self.labelNoBankAccTitle setHidden:NO];
        [self.labelNoBankAcc setHidden:NO];
        [self.addBankAccountButton setHidden:NO];
        
        [self.labelHeadingMyCards setHidden:YES];
        [self.tableViewBankAccounts setHidden:YES];
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

- (void)adjustHeightOfTableview
{
    CGFloat height = self.childNamesListTableView.contentSize.height;
    CGFloat maxHeight = self.childNamesListTableView.superview.frame.size.height - self.childNamesListTableView.frame.origin.y;
    
    // if the height of the content is greater than the maxHeight of
    // total space on the screen, limit the height to the size of the
    // superview.
    
    if (height > maxHeight)
        height = maxHeight;
    
    // now set the frame accordingly

    CGRect frame = self.childNamesListTableView.frame;
    frame.size.height = height;
    self.childNamesListTableView.frame = frame;
    // if you have other controls that should be resized/moved to accommodate
    // the resized tableview, do that here, too
    self.tableHeightConstraint.constant = self.childNamesListTableView.contentSize.height;
    CGRect addChildButtonFrame = self.addChildButton.frame;
    addChildButtonFrame.origin.y = self.childNamesListTableView.frame.origin.y + self.childNamesListTableView.contentSize.height + 12.0f;
    [self.addChildButton setFrame:addChildButtonFrame];
    self.constraintHeightControlContainerView.constant = self.addChildButton.frame.origin.y + self.addChildButton.frame.size.height + 12.0f;
}


- (IBAction)addChildButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(addChildButtonPressed)]) {
        [self.delegate addChildButtonPressed];
    }
}

- (IBAction)addBankAccountPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(addBankAccountButtonPressed)]) {
        [self.delegate addBankAccountButtonPressed];
    }
}

#pragma mark ----- Table Child Names

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableViewBankAccounts)
        return 1;
    return [self.childrenArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableViewBankAccounts) {
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        [cell.textLabel setTextColor:[UIColor stasherTextColor]];
        [cell.textLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
        if (![self.dictBankAccountInfo isKindOfClass:[NSNull class]]) {
            if (![[[self.dictBankAccountInfo objectForKey:@"transaction"] objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
                [cell.textLabel setText:[[self.dictBankAccountInfo objectForKey:@"transaction"] objectForKey:@"name"]];
            }
        }
        return cell;
    }
    static NSString *stUserCellIdentifier = @"STUserCustomTableViewCell";
    STUserCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stUserCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([STUserCustomTableViewCell class]) owner:self options:0] objectAtIndex:0];
    }
    if (self.childrenArray!= nil) {
        if ([self.childrenArray count] > indexPath.row) {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.LabelName.text = [NSString stringWithFormat:@"%@ %@",[[self.childrenArray objectAtIndex:indexPath.row] objectForKey:kParamKeyFirstname],[[self.childrenArray objectAtIndex:indexPath.row] objectForKey:kParamKeyLastname]];
            [cell.LabelName setTextColor:[UIColor stasherTextColor]];
            [cell.imgViewDivider setHidden:YES];
            [cell.LabelName setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
            if (![[[self.childrenArray objectAtIndex:indexPath.row] objectForKey:kParamKeyAvatar] isKindOfClass:[NSNull class]]) {
                [cell.imgViewProfilePic setImageWithURL:[NSURL URLWithString:[[self.childrenArray objectAtIndex:indexPath.row] objectForKey:kParamKeyAvatar]] placeholderImage:[UIImage imageNamed:@"Stasher_FacePlaceHolder"]];
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView == self.childNamesListTableView){
        if ([self.delegate respondsToSelector:@selector(childNameSelectedWithDictionary:)]) {
            [self.delegate childNameSelectedWithDictionary:[self.childrenArray objectAtIndex:indexPath.row]];
        }
    }
}

#pragma mark ----- BOABHttpReqDelegates

- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if (responseDictionary) {
            if (![responseDictionary isKindOfClass:[NSNull class]]) {
                if ([[responseDictionary objectForKey:@"transaction"] objectForKey:@"name"]) {
                    self.dictBankAccountInfo = [NSMutableDictionary dictionaryWithDictionary:[responseDictionary mutableCopy]];
                    [self refreshViewOnLinkedAccount];
                }
            }
        }
    }
}


@end
