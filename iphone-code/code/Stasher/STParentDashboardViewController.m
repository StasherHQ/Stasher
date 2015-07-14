//
//  STParentDashboardViewController.m
//  Stasher
//
//  Created by bhushan on 24/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STParentDashboardViewController.h"

@interface STParentDashboardViewController ()

@end

@implementation STParentDashboardViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithDashboardChildArray:(NSMutableArray*)thisChildArray
{
    self = [super initWithNibName:@"STParentDashboardViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.childrenArray = [[NSMutableArray alloc] initWithArray:thisChildArray];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.childNamesListTableView.delegate = self;
    self.childNamesListTableView.dataSource = self;
    //[self.graphContainerView addSubview:[self getGraphViewForParent] withAnimation:YES];
    
    UIFont *font1 = [UIFont FontGothamRoundedMediumWithSize:10.0f];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", @"Total"] attributes: arialDict];
    
    UIFont *font2 = [UIFont FontGothamRoundedBoldWithSize:10.0f];
    NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",@"Deposits"] attributes: arialDict2];
    [aAttrString1 appendAttributedString:aAttrString2];
    
    UIFont *font3 = [UIFont FontGothamRoundedMediumWithSize:10.0f];
    NSDictionary *arialDict3 = [NSDictionary dictionaryWithObject: font3 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", @"in a Week"] attributes: arialDict3];
    [aAttrString1 appendAttributedString:aAttrString3];
    self.labelDepositesInAWeek.attributedText = aAttrString1;
    
    
    UIFont *font4 = [UIFont FontGothamRoundedMediumWithSize:11.5f];
    NSDictionary *arialDict4 = [NSDictionary dictionaryWithObject: font4 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", @"$"] attributes: arialDict4];
    
    UIFont *font5 = [UIFont FontGothamRoundedBoldWithSize:21.21f];
    NSDictionary *arialDict5 = [NSDictionary dictionaryWithObject: font5 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[STUserIdentity sharedInstance] depositsAmount]]] attributes: arialDict5];
    [aAttrString4 appendAttributedString:aAttrString5];
    
    [self.labelDeposites setAttributedText:aAttrString4];
    
    self.labelDepositesInAWeek.attributedText = aAttrString1;
    
    [self.labelPendingMissions setText:[NSString stringWithFormat:@"%@",[[STUserIdentity sharedInstance] pendingMissionsCount]]];
    [self.labelActiveMissions setText:[NSString stringWithFormat:@"%@",[[STUserIdentity sharedInstance] activeMissionsCount]]];
    
    [self.labelActiveMissions setFont:[UIFont FontGothamRoundedMediumWithSize:12.0f]];
    [self.labelPendingMissions setFont:[UIFont FontGothamRoundedMediumWithSize:12.0f]];
   
    [self.labelMyChildren setFont:[UIFont FontGothamRoundedMediumWithSize:11.0f]];
    [self.labelMyChildren setTextColor:[UIColor stasherTextColor]];
    
    [self.labelActiveMissions setTextColor:[UIColor whiteColor]];
    [self.labelPendingMissions setTextColor:[UIColor whiteColor]];
    [self.labelDepositesInAWeek setTextColor:[UIColor stasherTextColor]];
    [self.labelDeposites setTextColor:[UIColor whiteColor]];
    
    [self.labelHeadingActiveMission setFont:[UIFont FontGothamRoundedMediumWithSize:5.0f]];
    [self.labelHeadingActiveMission setTextColor:[UIColor colorWithRed:140.0f/255 green:140.0f/255 blue:140.0f/255 alpha:1.0f]];
    
    [self.labelHeadingPendingMission setFont:[UIFont FontGothamRoundedMediumWithSize:5.0f]];
    [self.labelHeadingPendingMission setTextColor:[UIColor colorWithRed:140.0f/255 green:140.0f/255 blue:140.0f/255 alpha:1.0f]];
    [self.labelHeadingPendingMission sizeToFit];
    [self.labelHeadingActiveMission sizeToFit];
    
    [self.labelActiveMissions sizeToFit];
    [self.labelPendingMissions sizeToFit];
    [self.labelDepositesInAWeek sizeToFit];
    [self.labelDeposites sizeToFit];
    [self.labelNoGraphData sizeToFit];
    [self.labelNoGraphData setFont:[UIFont FontGothamRoundedMediumWithSize:11.0f]];
    [self.labelNoGraphData setTextColor:[UIColor stasherTextColor]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self adjustHeightOfTableview];
    if ([self.childrenArray count] == 0) {
        [self.labelMyChildren setHidden:YES];
    }else{
        [self.labelMyChildren setHidden:NO];
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
#pragma mark - Custom

- (void)requestParentGraphData
{
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:NO];
    if ([httpReq reachable]) {
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        if ([[STUserIdentity sharedInstance] userId] != nil) {
            [paramDict setObject:kAPIActionParentGraph forKey:kParamKeyAction];
            [paramDict setObject:[[STUserIdentity sharedInstance] userId] forKey:kParamKeyParentID];
            [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
            paramDict = nil;
        }
    }
}

-(UIView*)getGraphViewForParent {
    // Generating some dummy data
    NSMutableArray* chartData = [NSMutableArray arrayWithCapacity:7];
    
    for(int i=1;i < 8;i++) {
        //[chartData addObject:[NSNumber numberWithInt:arc4random()%30]];
        [chartData addObject:[NSNumber numberWithInt:0]];
    }
    
    // Creating the line chart
    STGraphView* graphView = [[STGraphView alloc] initWithFrame:CGRectMake(18, 16, [UIScreen mainScreen].bounds.size.width - 54, 124)];
    UIView *contView = [[UIView alloc] initWithFrame:CGRectMake(0,0, graphView.frame.size.width+30, graphView.frame.size.height+40)];
    [contView addSubview:graphView];
    contView.layer.cornerRadius = 15;
    graphView.gridStep = 3;
    
    graphView.labelForIndex = ^(NSUInteger item) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)item];
    };
    
    graphView.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.f", value];
    };
    [graphView setChartData:chartData];
    [contView setBackgroundColor:[UIColor colorWithRed:230.0f/255 green:230.0f/255 blue:230.0f/255 alpha:1.0]];
    return contView;
}

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
    self.constraintHeightControlContainerView.constant = self.childNamesListTableView.frame.origin.y + self.childNamesListTableView.contentSize.height + 8.0f;
}


#pragma mark ----- Table Child Names

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.childrenArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    if ([self.delegate respondsToSelector:@selector(parentDashboardChildDetailsSelectedWithDictionary:)]) {
        [self.delegate parentDashboardChildDetailsSelectedWithDictionary:[self.childrenArray objectAtIndex:indexPath.row]];
    }
}


#pragma mark ----- BOABHttpReq Delegate

- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if (responseDict) {
            NSLog(@"parent graph response %@",responseDict);
        }
    }
}

- (void)BOABHttpReqFailedWithError:(NSError*)error
{
    if (error) {
        
    }
}

@end
