//
//  STChildAccountViewController.m
//  Stasher
//
//  Created by bhushan on 18/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STChildAccountViewController.h"

@interface STChildAccountViewController ()

@end

@implementation STChildAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withParentArray:(NSMutableArray*)thisParentArray
{
    self = [super initWithNibName:@"STChildAccountViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.parentArray = [[NSMutableArray alloc] initWithArray:thisParentArray];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self adjustHeightOfTableview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self refreshViewForNewParents];
    [self refreshViewLabelsOnEditProfile];
    if (![[[STUserIdentity sharedInstance] avatarUrlString] isKindOfClass:[NSNull class]]&&![[[STUserIdentity sharedInstance] avatarUrlString] isEqualToString:@""]) {
        [self.profilePicImageView setImageWithURL:[NSURL URLWithString:[[STUserIdentity sharedInstance] avatarUrlString]] placeholderImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }else{
        [self.profilePicImageView setImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
       
    self.profilePicImageView.clipsToBounds = YES;
    self.profilePicImageView.layer.cornerRadius = 80/2.0f;
    self.profilePicImageView.layer.borderColor=[UIColor clearColor].CGColor;
    self.profilePicImageView.layer.borderWidth=2.0f;
    self.profilePicImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.profilePicButton.clipsToBounds = YES;
    self.profilePicButton.layer.cornerRadius = 80/2.0f;
    self.profilePicButton.layer.borderColor=[UIColor clearColor].CGColor;
    self.profilePicButton.layer.borderWidth=0.5f;
    
    [self.labelUsername setFont:[UIFont FontGothamRoundedMediumWithSize:18.0f]];
    [self.labelFullname setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    [self.editProfileButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.addCommandersButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.addCommandersNoTableButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.noCommandersLabel setFont:[UIFont FontGothamRoundedWithSize:10.0f]];
    [self.labelMyCommanders setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    [self.labelMySavings setFont:[UIFont FontGothamRoundedMediumWithSize:16.0f]];
    [self.labelMyCommanders setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    
    [self.labelUsername setTextColor:[UIColor stasherTextColor]];
    [self.labelFullname setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
    [self.labelMyCommanders setTextColor:[UIColor stasherTextColor]];
    [self.labelMySavings setTextColor:[UIColor stasherTextColor]];
    [self.editProfileButton setTitleColor:[UIColor stasherTextFieldPlaceHolderColor] forState:UIControlStateNormal];
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

- (IBAction)editMyProfileButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(childAccountEditProfileButtonPressed:)]) {
        [self.delegate childAccountEditProfileButtonPressed:sender];
    }
}

- (IBAction)addCommanderButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(childAccountAddParentButtonPressed:)]) {
        [self.delegate childAccountAddParentButtonPressed:sender];
    }
}


#pragma mark ----- Custom Methods

- (void)adjustHeightOfTableview
{
    CGFloat height = self.parentNamesTable.contentSize.height;
    self.constraintHeightParentTableView.constant = self.parentNamesTable.contentSize.height;
    CGFloat maxHeight = self.parentNamesTable.superview.frame.size.height - self.parentNamesTable.frame.origin.y;
    
    // if the height of the content is greater than the maxHeight of
    // total space on the screen, limit the height to the size of the
    // superview.
    
    if (height > maxHeight)
        height = maxHeight;
    
    // now set the frame accordingly
    
    CGRect frame = self.parentNamesTable.frame;
    frame.size.height = height;
    self.parentNamesTable.frame = frame;
    
    // if you have other controls that should be resized/moved to accommodate
    // the resized tableview, do that here, too
    CGRect addCommanderButtonFrame = self.addCommandersButton.frame;
    addCommanderButtonFrame.origin.y = self.parentNamesTable.frame.origin.y + self.parentNamesTable.contentSize.height + 8;
    //[self.addCommandersButton setFrame:addCommanderButtonFrame];
    self.constraintHeightControlContainerView.constant = addCommanderButtonFrame.origin.y + addCommanderButtonFrame.size.height + 8;
}

- (void)refreshViewForNewParents
{
    if ([self.parentArray count] == 0) {
        [self.parentNamesTable setHidden:YES];
        [self.addCommandersNoTableButton setHidden:NO];
        [self.noCommandersLabel setHidden:NO];
    }
    else{
        [self.parentNamesTable setHidden:NO];
        [self.addCommandersNoTableButton setHidden:YES];
        [self.noCommandersLabel setHidden:YES];
    }
    [self adjustHeightOfTableview];
}

- (void)refreshViewLabelsOnEditProfile
{
    [self.labelFullname setText:[NSString stringWithFormat:@"%@ %@", [[STUserIdentity sharedInstance] firstName], [[STUserIdentity sharedInstance] lastName]]];
    [self.labelUsername setText:[[STUserIdentity sharedInstance] username]];
    [self.labelMySavings setText:[NSString stringWithFormat:@"My Savings : $%@",[[STUserIdentity sharedInstance] savingsAmount]]];
    if (![[[STUserIdentity sharedInstance] avatarUrlString] isKindOfClass:[NSNull class]]&&![[[STUserIdentity sharedInstance] avatarUrlString] isEqualToString:@""]) {
        [self.profilePicImageView setImageWithURL:[NSURL URLWithString:[[STUserIdentity sharedInstance] avatarUrlString]] placeholderImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }else{
        [self.profilePicImageView setImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }
}

#pragma mark ----- Table Parent names

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.parentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *stUserCellIdentifier = @"STUserCustomTableViewCell";
    STUserCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stUserCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([STUserCustomTableViewCell class]) owner:self options:0] objectAtIndex:0];
    }
    if (self.parentArray!= nil) {
        if ([self.parentArray count] > indexPath.row) {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.LabelName.text = [NSString stringWithFormat:@"%@ %@",[[self.parentArray objectAtIndex:indexPath.row] objectForKey:kParamKeyFirstname],[[self.parentArray objectAtIndex:indexPath.row] objectForKey:kParamKeyLastname]];
            [cell.LabelName setTextColor:[UIColor stasherTextColor]];
            [cell.imgViewDivider setHidden:YES];
            [cell.LabelName setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
            if (![[[self.parentArray objectAtIndex:indexPath.row] objectForKey:kParamKeyAvatar] isKindOfClass:[NSNull class]]) {
                [cell.imgViewProfilePic setImageWithURL:[NSURL URLWithString:[[self.parentArray objectAtIndex:indexPath.row] objectForKey:kParamKeyAvatar]] placeholderImage:[UIImage imageNamed:@"Stasher_FacePlaceHolder"]];
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self.delegate respondsToSelector:@selector(childAccountParentDetailsSelectedWithDictionary:)]) {
        [self.delegate childAccountParentDetailsSelectedWithDictionary:[self.parentArray objectAtIndex:indexPath.row]];
    }
}

@end
