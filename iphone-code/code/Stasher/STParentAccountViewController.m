//
//  STParentAccountViewController.m
//  Stasher
//
//  Created by bhushan on 18/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STParentAccountViewController.h"

@interface STParentAccountViewController ()

@end

@implementation STParentAccountViewController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withChildArray:(NSMutableArray*)thisChildArray
{
    self = [super initWithNibName:@"STParentAccountViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.childArray = [[NSMutableArray alloc] initWithArray:thisChildArray];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self refreshViewOnForNewChilds];
    [self refreshViewForEditedProfile];
    
    if (![[[STUserIdentity sharedInstance] avatarUrlString] isKindOfClass:[NSNull class]]&&![[[STUserIdentity sharedInstance] avatarUrlString] isEqualToString:@""]) {
        [self.profilePicImageView setImageWithURL:[NSURL URLWithString:[[STUserIdentity sharedInstance] avatarUrlString]] placeholderImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }else{
        [self.profilePicImageView setImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self adjustHeightOfTableview];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    // Do any additional setup after loading the view from its nib.
   
    // Do any additional setup after loading the view.
   
    self.profilePicButton.clipsToBounds = YES;
    self.profilePicButton.layer.cornerRadius = 80/2.0f;
    self.profilePicButton.layer.borderColor=[UIColor clearColor].CGColor;
    self.profilePicButton.layer.borderWidth=0.5f;
    
    self.profilePicImageView.clipsToBounds = YES;
    self.profilePicImageView.layer.cornerRadius = 80/2.0f;
    self.profilePicImageView.layer.borderColor=[UIColor clearColor].CGColor;
    self.profilePicImageView.layer.borderWidth=2.0f;
    self.profilePicImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.labelUsername setFont:[UIFont FontGothamRoundedMediumWithSize:18.0f]];
    [self.labelFullname setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
    [self.labelUsername setTextColor:[UIColor stasherTextColor]];
    [self.myChildrenslabel setTextColor:[UIColor stasherTextColor]];
    [self.labelFullname setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    [self.editProfileButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.addChildButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.addChildButtonNoTable.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.myChildrenslabel setFont:[UIFont FontGothamRoundedMediumWithSize:11.0f]];
    [self.createChildButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.editProfileButton setTitleColor:[UIColor stasherTextFieldPlaceHolderColor] forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----- Actions

- (IBAction)editMyProfileButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(editProfileButtonPressed:)]) {
        [self.delegate editProfileButtonPressed:sender];
    }
}

- (IBAction)addChildButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(addChildButtonPressed:)]) {
        [self.delegate addChildButtonPressed:sender];
    }
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
    CGFloat height = self.childNamesTable.contentSize.height;
    self.constraintHeightParentTableView.constant = self.childNamesTable.contentSize.height;
    CGFloat maxHeight = self.childNamesTable.superview.frame.size.height - self.childNamesTable.frame.origin.y;
    
    // if the height of the content is greater than the maxHeight of
    // total space on the screen, limit the height to the size of the
    // superview.
    
    if (height > maxHeight)
        height = maxHeight;
    
    // now set the frame accordingly
    
    CGRect frame = self.childNamesTable.frame;
    frame.size.height = height;
    self.childNamesTable.frame = frame;
    
    // if you have other controls that should be resized/moved to accommodate
    // the resized tableview, do that here, too
    
    CGRect addChildButtonFrame = self.addChildButton.frame;
    addChildButtonFrame.origin.y = self.childNamesTable.frame.origin.y + self.childNamesTable.contentSize.height + 8;
    //[self.addChildButton setFrame:addChildButtonFrame];
    self.constraintHeightControlContainerView.constant = addChildButtonFrame.origin.y + addChildButtonFrame.size.height + 8;
}

- (void)refreshViewOnForNewChilds
{
    if ([self.childArray count] == 0) {
        [self.childNamesTable setHidden:YES];
        [self.addChildButtonNoTable setHidden:NO];
        [self.myChildrenslabel setHidden:YES];
    }
    else{
        [self.childNamesTable setHidden:NO];
        [self.addChildButtonNoTable setHidden:YES];
        [self.myChildrenslabel setHidden:NO];
    }
    [self adjustHeightOfTableview];
}

- (void)refreshViewForEditedProfile
{
    [self.labelFullname setText:[NSString stringWithFormat:@"%@ %@", [[STUserIdentity sharedInstance] firstName], [[STUserIdentity sharedInstance] lastName]]];
    [self.labelUsername setText:[[STUserIdentity sharedInstance] username]];
    if (![[[STUserIdentity sharedInstance] avatarUrlString] isKindOfClass:[NSNull class]]&&![[[STUserIdentity sharedInstance] avatarUrlString] isEqualToString:@""]) {
        [self.profilePicImageView setImageWithURL:[NSURL URLWithString:[[STUserIdentity sharedInstance] avatarUrlString]] placeholderImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }else{
        [self.profilePicImageView setImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }
}

- (IBAction)createChildButtonPressed:(id)sender
{
    if([self.delegate respondsToSelector:@selector(createChildButtonPressed)]){
        [self.delegate createChildButtonPressed];
    }
}

#pragma mark ----- Table Child Names

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.childArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *stUserCellIdentifier = @"STUserCustomTableViewCell";
    STUserCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stUserCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([STUserCustomTableViewCell class]) owner:self options:0] objectAtIndex:0];
    }
    if (self.childArray!= nil) {
        if ([self.childArray count] > indexPath.row) {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.LabelName.text = [NSString stringWithFormat:@"%@ %@",[[self.childArray objectAtIndex:indexPath.row] objectForKey:kParamKeyFirstname],[[self.childArray objectAtIndex:indexPath.row] objectForKey:kParamKeyLastname]];
            [cell.LabelName setTextColor:[UIColor stasherTextColor]];
            [cell.imgViewDivider setHidden:YES];
            [cell.LabelName setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
            if (![[[self.childArray objectAtIndex:indexPath.row] objectForKey:kParamKeyAvatar] isKindOfClass:[NSNull class]]) {
                [cell.imgViewProfilePic setImageWithURL:[NSURL URLWithString:[[self.childArray objectAtIndex:indexPath.row] objectForKey:kParamKeyAvatar]] placeholderImage:[UIImage imageNamed:@"Stasher_FacePlaceHolder"]];
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self.delegate respondsToSelector:@selector(childDetailsSelectedWithDict:)]) {
        [self.delegate childDetailsSelectedWithDict:[self.childArray objectAtIndex:indexPath.row]];
    }
}

@end
