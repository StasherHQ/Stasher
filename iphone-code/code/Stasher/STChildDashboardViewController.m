//
//  STChildDashboardViewController.m
//  Stasher
//
//  Created by bhushan on 21/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STChildDashboardViewController.h"

@interface STChildDashboardViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *workaholicConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hardLabourConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *speedWorkerConstraint;
@end

@implementation STChildDashboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithDashboardParentArray:(NSMutableArray *)thisParentArray
{
    self = [super initWithNibName:@"STChildDashboardViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.parentsArray = [[NSMutableArray alloc] initWithArray:thisParentArray];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    actualMyBadgesHeaderViewCenter = self.myBadgesHeaderView.center;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.profilePicImgView.clipsToBounds = YES;
    self.profilePicImgView.layer.cornerRadius = self.profilePicButton.frame.size.width/2.0f;
    self.profilePicImgView.layer.borderColor=[UIColor clearColor].CGColor;
    self.profilePicImgView.layer.borderWidth=0.5f;
    self.profilePicImgView.contentMode = UIViewContentModeScaleAspectFill;
    
    if (![[[STUserIdentity sharedInstance] avatarUrlString] isKindOfClass:[NSNull class]]&&![[[STUserIdentity sharedInstance] avatarUrlString] isEqualToString:@""]) {
        [self.profilePicImgView setImageWithURL:[NSURL URLWithString:[[STUserIdentity sharedInstance] avatarUrlString]] placeholderImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }else{
        [self.profilePicImgView setImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }
    
    //[self.graphContainerView addSubview:[self getGraphViewForChildren] withAnimation:YES];
    
    [self.lblFirstName setTextColor:[UIColor stasherTextColor]];
    [self.lblLastName setTextColor:[UIColor stasherTextColor]];
    
    UIFont *font1 = [UIFont FontGothamRoundedMediumWithSize:14.0f];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",[[STUserIdentity sharedInstance] firstName]] attributes: arialDict];
    
    UIFont *font2 = [UIFont FontGothamRoundedBookWithSize:14.0f];
    NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[STUserIdentity sharedInstance] lastName]] attributes: arialDict2];
    
    [aAttrString1 appendAttributedString:aAttrString2];
    self.lblFirstName.attributedText = aAttrString1;
    
    [self.lblActiveMissionsHeading setFont:[UIFont FontGothamRoundedMediumWithSize:5.0f]];
    [self.lblActiveMissionsHeading setTextColor:[UIColor colorWithRed:140.0f/255 green:140.0f/255 blue:140.0f/255 alpha:1.0f]];
    
    [self.lblPendingMissionsHeading setFont:[UIFont FontGothamRoundedMediumWithSize:5.0f]];
    [self.lblPendingMissionsHeading setTextColor:[UIColor colorWithRed:140.0f/255 green:140.0f/255 blue:140.0f/255 alpha:1.0f]];
    
    [self.lblCompletedMissionsHeading setFont:[UIFont FontGothamRoundedMediumWithSize:5.0f]];
    [self.lblCompletedMissionsHeading setTextColor:[UIColor colorWithRed:140.0f/255 green:140.0f/255 blue:140.0f/255 alpha:1.0f]];
    
    [self.lblTotal setFont:[UIFont FontGothamRoundedBookWithSize:12.0f]];
    [self.lblSaved setFont:[UIFont FontGothamRoundedMediumWithSize:12.0f]];
    [self.lblInAWeek setFont:[UIFont FontGothamRoundedBookWithSize:12.0f]];
    [self.lblTotal setTextColor:[UIColor stasherTextColor]];
    [self.lblSaved setTextColor:[UIColor stasherTextColor]];
    [self.lblInAWeek setTextColor:[UIColor stasherTextColor]];
    
    [self.lblDollar setFont:[UIFont FontGothamRoundedMediumWithSize:13.5f]];
    [self.lblSavingsAmount setFont:[UIFont FontGothamRoundedBoldWithSize:21.21f]];
    
    [self.myBadgesButton.titleLabel setFont:[UIFont FontGothamRoundedBoldWithSize:8.0f]];
    [self.activityButton.titleLabel setFont:[UIFont FontGothamRoundedMediumWithSize:8.0f]];
    
    [self.activityButton.titleLabel setTextColor:[UIColor colorWithRed:194.0f/255 green:194.0f/255 blue:194.0f/255 alpha:1.0f]];
    
    [self.lblActiveMissionsCount setFont:[UIFont FontGothamRoundedBoldWithSize:17.21f]];
    [self.lblPendingMissionsCount setFont:[UIFont FontGothamRoundedBoldWithSize:17.21f]];
    [self.lblCompletedMissionsCount setFont:[UIFont FontGothamRoundedBoldWithSize:17.21f]];
    
    [self.lblActiveMissionsCount setText:[NSString stringWithFormat:@"%@",[[STUserIdentity sharedInstance] activeMissionsCount]]];
    [self.lblPendingMissionsCount setText:[NSString stringWithFormat:@"%@",[[STUserIdentity sharedInstance] pendingMissionsCount]]];
    [self.lblCompletedMissionsCount setText:[NSString stringWithFormat:@"%@",[[STUserIdentity sharedInstance] completedMissionsCount]]];
    
    UIFont *font4 = [UIFont FontGothamRoundedMediumWithSize:11.5f];
    NSDictionary *arialDict4 = [NSDictionary dictionaryWithObject: font4 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", @"$"] attributes: arialDict4];
    
    UIFont *font5 = [UIFont FontGothamRoundedBoldWithSize:21.21f];
    NSDictionary *arialDict5 = [NSDictionary dictionaryWithObject: font5 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[STUserIdentity sharedInstance] savingsAmount]] attributes: arialDict5];
    [aAttrString4 appendAttributedString:aAttrString5];
    
    [self.lblSavingsAmount setAttributedText:aAttrString4];
    
    [self.lblSavingsAmount sizeToFit];
    [self.lblFirstName sizeToFit];
    [self.lblLastName sizeToFit];
    
    if (IS_STANDARD_IPHONE_6) {
        self.workaholicConstraint.constant = 48.0f;
        self.hardLabourConstraint.constant = 48.0f;
        self.speedWorkerConstraint.constant = 48.0f;
    }
    else if (IS_STANDARD_IPHONE_6_PLUS){
        self.workaholicConstraint.constant = 58.0f;
        self.hardLabourConstraint.constant = 58.0f;
        self.speedWorkerConstraint.constant = 58.0f;
    }
    else{
        self.workaholicConstraint.constant = 28.0f;
        self.hardLabourConstraint.constant = 28.0f;
        self.speedWorkerConstraint.constant = 28.0f;
    }
    
    [self.labelBadge1 setTextColor:[UIColor stasherTextColor]];
    [self.labelBadge2 setTextColor:[UIColor stasherTextColor]];
    [self.labelBadge3 setTextColor:[UIColor stasherTextColor]];
    [self.labelBadge4 setTextColor:[UIColor stasherTextColor]];
    [self.labelBadge5 setTextColor:[UIColor stasherTextColor]];
    
    [self.labelBadge1 setFont:[UIFont FontGothamRoundedBookWithSize:9.0f]];
    [self.labelBadge2 setFont:[UIFont FontGothamRoundedBookWithSize:9.0f]];
    [self.labelBadge3 setFont:[UIFont FontGothamRoundedBookWithSize:9.0f]];
    [self.labelBadge4 setFont:[UIFont FontGothamRoundedBookWithSize:9.0f]];
    [self.labelBadge5 setFont:[UIFont FontGothamRoundedBookWithSize:9.0f]];
    
    if ([[STUserIdentity sharedInstance] childBadgeDetailsArray]!=nil) {
        for(NSDictionary *dict in [[STUserIdentity sharedInstance] childBadgeDetailsArray]){
            if ([dict objectForKey:@"title"]) {
                if ([[dict objectForKey:@"title"] isEqualToString:kBadgeJuniorAgent]) {
                    [self.badge1ImgView setHiddenAnimated:NO];
                    [self.badge1ImgView setAlpha:1.0f];
                }else{
                    [self.badge1ImgView setAlpha:1.0f];
                }
                if ([[dict objectForKey:@"title"] isEqualToString:kBadgeTrainingDay]) {
                    [self.badge2ImgView setHiddenAnimated:NO];
                    [self.badge2ImgView setAlpha:1.0f];
                }else{
                    [self.badge2ImgView setAlpha:0.3f];
                }
                if ([[dict objectForKey:@"title"] isEqualToString:kBadgeFirstMission]) {
                    [self.badge3ImgView setHiddenAnimated:NO];
                    [self.badge3ImgView setAlpha:1.0f];
                }else{
                    [self.badge3ImgView setAlpha:0.3f];
                }
                if ([[dict objectForKey:@"title"] isEqualToString:kBadgeBusyBee]) {
                    [self.badge4ImgView setHiddenAnimated:NO];
                    [self.badge4ImgView setAlpha:1.0f];
                }else{
                    [self.badge4ImgView setAlpha:0.3f];
                }
                if ([[dict objectForKey:@"title"] isEqualToString:kBadgeMasterStasher]) {
                    [self.badge5ImgView setHiddenAnimated:NO];
                    [self.badge5ImgView setAlpha:1.0f];
                }else{
                    [self.badge5ImgView setAlpha:0.3f];
                }
            }
        }
    }
    
    [self.labelNoGraphData sizeToFit];
    [self.labelNoGraphData setFont:[UIFont FontGothamRoundedMediumWithSize:11.0f]];
    [self.labelNoGraphData setTextColor:[UIColor stasherTextColor]];
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

#pragma mark - Create the graph
- (void)requestChildGraphDetails
{
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:NO];
    if ([httpReq reachable]) {
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        if ([[STUserIdentity sharedInstance] userId] != nil) {
            [paramDict setObject:kAPIActionChildGraph forKey:kParamKeyAction];
            [paramDict setObject:[[STUserIdentity sharedInstance] userId] forKey:kParamKeyChildID];
            [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
            paramDict = nil;
        }
    }
}


-(UIView*)getGraphViewForChildren {
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

- (void) requestMyActivities
{
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[[STUserIdentity sharedInstance] userId] intValue]],kParamKeyUserID,kParamKeyMyActivities,kParamKeyAction,nil] json:YES];
}


- (void)adjustHeightOfTableview
{
    CGFloat height = self.myActivityTableView.contentSize.height;
    self.constraintHeightmyActivityTableView.constant = self.myActivityTableView.contentSize.height;
    CGFloat maxHeight = self.myActivityTableView.superview.frame.size.height - self.myActivityTableView.frame.origin.y;
    
    // if the height of the content is greater than the maxHeight of
    // total space on the screen, limit the height to the size of the
    // superview.
    
    if (height > maxHeight)
        height = maxHeight;
    
    // now set the frame accordingly
    
    CGRect frame = self.myActivityTableView.frame;
    frame.size.height = height;
    self.myActivityTableView.frame = frame;
    
    // if you have other controls that should be resized/moved to accommodate
    // the resized tableview, do that here, too
    self.constraintHeightMyActivityTableViewContainerView.constant = self.myActivityTableView.contentSize.height;
    self.constraintHeightControlsContView.constant = self.activityContainerView.frame.origin.y + self.myActivityTableView.contentSize.height;
}

# pragma mark ----- Actions

- (IBAction)badgesButtonPressed:(id)sender
{
    [self.myBadgesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.activityButton setTitleColor:[UIColor colorWithRed:194.0f/255 green:194.0f/255 blue:194.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    [self.myBadgesButton setBackgroundImage:[UIImage imageNamed:@"stasher_mybadgesButton"] forState:UIControlStateNormal];
    [self.activityButton setBackgroundImage:[UIImage imageNamed:@"stasher_activityButton"] forState:UIControlStateNormal];
    [self.badgesContainerView setHiddenAnimated:NO];
    [self.activityContainerView setHiddenAnimated:YES];
    [self.myBadgesButton.titleLabel setFont:[UIFont FontGothamRoundedBoldWithSize:8.0f]];
    [self.activityButton.titleLabel setFont:[UIFont FontGothamRoundedBookWithSize:8.0f]];
     self.constraintHeightControlsContView.constant = self.badgesContainerView.frame.origin.y + self.badgesContainerView.frame.size.height;
}

- (IBAction)activityButtonPressed:(id)sender
{
    [self.activityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.myBadgesButton setTitleColor:[UIColor colorWithRed:194.0f/255 green:194.0f/255 blue:194.0f/255 alpha:1.0f] forState:UIControlStateNormal];
     [self.activityButton setBackgroundImage:[UIImage imageNamed:@"stasher_mybadgesButton"] forState:UIControlStateNormal];
    [self.myBadgesButton setBackgroundImage:[UIImage imageNamed:@"stasher_activityButton"] forState:UIControlStateNormal];
    [self.badgesContainerView setHiddenAnimated:YES];
    [self.myBadgesButton.titleLabel setFont:[UIFont FontGothamRoundedBookWithSize:8.0f]];
    [self.activityButton.titleLabel setFont:[UIFont FontGothamRoundedBoldWithSize:8.0f]];
    [self requestMyActivities];
}



#pragma mark ----- MyActivity TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount = 0;
    rowCount = (int)[self.myActivityArray count];
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *simpleTableIdentifier = @"STParentMyActivityCustomCell";
    STParentMyActivityCustomCell *myActivityCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (myActivityCell == nil) {
        myActivityCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([STParentMyActivityCustomCell class]) owner:self options:0] objectAtIndex:0];
    }
    if ([self.myActivityArray count] > indexPath.row) {
        if ([self.myActivityArray objectAtIndex:indexPath.row]) {
            /*
            [myActivityCell.labelDescription setAttributedText:[[NSAttributedString alloc] initWithString:[[self.myActivityArray objectAtIndex:indexPath.row] objectForKey:@"description"]
                                                                                               attributes:@{
                                                                                                            NSForegroundColorAttributeName:[UIColor stasherTextColor],
                                                                                                            NSFontAttributeName : [UIFont FontGothamRoundedMediumWithSize:12.0f]
                                                                                                            }
                                                                ]];
            CGRect paragraphRect = [myActivityCell.labelDescription.attributedText boundingRectWithSize:CGSizeMake(200.f, CGFLOAT_MAX)
                                                                                                options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                                                                context:nil];
             
            myActivityCell.constraintLabelDescriptionHeight.constant = paragraphRect.size.height;
             */
            [myActivityCell.labelDescription setTextColor:[UIColor stasherTextColor]];
            [myActivityCell.labelDescription setFont:[UIFont FontGothamRoundedBoldWithSize:11.0f]];
            [myActivityCell.labelDescription setText:[[self.myActivityArray objectAtIndex:indexPath.row] objectForKey:@"description"]];
            [myActivityCell.labelDescription sizeToFit];
            [myActivityCell.labelActivityTitle setFont:[UIFont FontGothamRoundedMediumWithSize:12.0f]];
            [myActivityCell.labelActivityTitle setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
            switch ([[[self.myActivityArray objectAtIndex:indexPath.row] objectForKey:@"activity_type"] intValue]) {
                case 1:
                    [myActivityCell.activityTypeImgView setImage:[UIImage imageNamed:@"fund_request"]];
                    [myActivityCell.labelActivityTitle setText:@"Fund Request"];
                    break;
                case 2:
                    [myActivityCell.activityTypeImgView setImage:[UIImage imageNamed:@"mission_Accepted"]];
                    [myActivityCell.labelActivityTitle setText:@"Mission accepted"];
                    break;
                case 3:
                    [myActivityCell.activityTypeImgView setImage:[UIImage imageNamed:@"mission_completed"]];
                    [myActivityCell.labelActivityTitle setText:@"User Request"];
                    break;
                default:
                    break;
            }
            [myActivityCell.labelActivityTime setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
            [myActivityCell.labelActivityTime setFont:[UIFont FontGothamRoundedMediumWithSize:9.5f]];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *theDate = [dateFormat dateFromString:[[self.myActivityArray objectAtIndex:indexPath.row] objectForKey:@"inserted_date"]];
            
            NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
            [dateFormat2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *theDate2 = [dateFormat2 stringFromDate:[NSDate date]];
            NSDate *dt = [dateFormat dateFromString:theDate2];
            int minutes = [dt timeIntervalSinceDate:theDate] / 60;
            if (minutes < 1) {
                [myActivityCell.labelActivityTime setText:@"Just now"];
            }else if (minutes > 1 && minutes < 60){
                [myActivityCell.labelActivityTime setText:[NSString stringWithFormat:@"%d Minutes Ago",minutes]];
            }else if (minutes >59 && minutes < 1440){
                [myActivityCell.labelActivityTime setText:[NSString stringWithFormat:@"%d Hours Ago",minutes/60]];
            }else if (minutes > 1439){
                [myActivityCell.labelActivityTime setText:[NSString stringWithFormat:@"%d Days Ago",minutes/1440]];
            }
            CGRect timeLabelFrame = myActivityCell.labelActivityTime.frame;
            timeLabelFrame.origin.y = myActivityCell.constraintLabelDescriptionHeight.constant + myActivityCell.labelDescription.frame.origin.y + 8.0f;
            [myActivityCell.labelActivityTime setFrame:timeLabelFrame];
        }
    }
    [myActivityCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return myActivityCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark ----- BOABHttpReqDelegates
- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        if ([[[conn.userInfo objectForKey:@"params"] objectForKey:kParamKeyAction] isEqualToString:kParamKeyMyActivities]) {
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if ([responseArray isKindOfClass:[NSArray class]]) {
            if (responseArray) {
                if ([[[conn.userInfo objectForKey:@"params"] objectForKey:kParamKeyAction] isEqualToString:kParamKeyMyActivities]) {
                    if (self.myActivityArray) {
                        self.myActivityArray = nil;
                    }
                    [self.activityContainerView setHiddenAnimated:NO];
                    self.myActivityArray = [responseArray mutableCopy];
                    [self.myActivityTableView reloadData];
                    [self adjustHeightOfTableview];
                }
            }
        }else if ([responseArray isKindOfClass:[NSDictionary class]]){
            if ([(NSDictionary*)responseArray objectForKey:@"error"]) {
                [UIAlertView showWithTitle:@""
                                   message:[[(NSDictionary*)responseArray objectForKey:@"error"] objectForKey:@"message"]
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex]) {
                                      }
                                  }];
                }
        [self.myActivityTableView reloadData];
            }
        }else if ([[[conn.userInfo objectForKey:@"params"] objectForKey:kParamKeyAction] isEqualToString:kAPIActionChildGraph]) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
            if (responseDict) {
                NSLog(@"child graph response %@",responseDict);
            }
        }
    }
}

#pragma mark ----- Scrollview Delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pointNow = scrollView.contentOffset;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.containerScrollView) {
        if (scrollView.contentOffset.y<pointNow.y) {
            if (scrollView.contentOffset.y <= 400) {
                [self.myBadgesHeaderView setCenter:actualMyBadgesHeaderViewCenter];
            }else{
                [self.myBadgesHeaderView setCenter:CGPointMake(self.myBadgesHeaderView.center.x, scrollView.contentOffset.y+35)];
            }
        } else if (scrollView.contentOffset.y>pointNow.y) {
            if (scrollView.contentOffset.y > 400) {
                //[scrollView setContentOffset:CGPointMake(0,self.imgViewStickDivider.frame.origin.y-1) animated:YES];
                [self.myBadgesHeaderView setCenter:CGPointMake(self.myBadgesHeaderView.center.x, scrollView.contentOffset.y+35)];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

@end
