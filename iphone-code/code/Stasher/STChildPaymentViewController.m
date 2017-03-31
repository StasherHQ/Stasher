//
//  STChildPaymentViewController.m
//  Stasher
//
//  Created by bhushan on 02/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STChildPaymentViewController.h"

@interface STChildPaymentViewController ()

@end

@implementation STChildPaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andParentnamesArray:(NSMutableArray*)thisParentsArray
{
    self = [super initWithNibName:@"STChildPaymentViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.parentArray = [[NSMutableArray alloc] initWithArray:thisParentsArray];
        //[self performSelector:@selector(adjustHeightOfTableview) withObject:self afterDelay:1.01];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.headerLabel setFont:[UIFont FontGothamRoundedBookWithSize:20.0f]];
    UIFont *font1 = [UIFont FontForHeader];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"My " attributes: arialDict];
    
    UIFont *font2 = [UIFont FontGothamRoundedBoldWithSize:20.0f];
    NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:@"Savings" attributes: arialDict2];
    
    [aAttrString1 appendAttributedString:aAttrString2];
    self.mySavingsLabel.attributedText = aAttrString1;
    
    [self.mySavingsLabel setTextColor:[UIColor stasherTextColor]];
    [self.requestFromLabel setTextColor:[UIColor stasherTextColor]];
    
    [self.requestFromLabel setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    
    
    UIFont *font4 = [UIFont FontGothamRoundedMediumWithSize:11.5f];
    NSDictionary *arialDict4 = [NSDictionary dictionaryWithObject: font4 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", @"$"] attributes: arialDict4];
    
    UIFont *font5 = [UIFont FontGothamRoundedBoldWithSize:21.21f];
    NSDictionary *arialDict5 = [NSDictionary dictionaryWithObject: font5 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[STUserIdentity sharedInstance] savingsAmount]]] attributes: arialDict5];
    [aAttrString4 appendAttributedString:aAttrString5];
    
    [self.savingsAmountLabel setAttributedText:aAttrString4];
    [self.myHistoryLabel.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self adjustHeightOfTableview];
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
    CGFloat height = self.parentNamesTable.contentSize.height;
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
    self.tableHeightConstraint.constant = self.parentNamesTable.contentSize.height+100.0f;
    self.constraintHeightControlContainerView.constant = self.parentNamesTable.frame.origin.y + self.parentNamesTable.contentSize.height + 8.0f+100.0f;
}

# pragma mark ----- Actions
-(IBAction)myHistoryButtonPressed:(id)sender
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
            [cell.LabelName setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
            [cell.imgViewDivider setHidden:YES];
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
    if ([self.delegate respondsToSelector:@selector(childPaymentRequestPaymentParentSelectedWithDictionary:)]) {
        [self.delegate childPaymentRequestPaymentParentSelectedWithDictionary:[self.parentArray objectAtIndex:indexPath.row]];
    }
}


@end
