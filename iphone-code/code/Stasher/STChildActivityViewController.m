//
//  STChildActivityViewController.m
//  Stasher
//
//  Created by bhushan on 03/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STChildActivityViewController.h"

@interface STChildActivityViewController ()

@end

@implementation STChildActivityViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.labelNoActivityTitle setFont:[UIFont FontGothamRoundedBookWithSize:19.88f]];
    [self.labelNoRecentActivity setFont:[UIFont FontGothamRoundedBookWithSize:8.83f]];
    [self.labelNoActivityTitle sizeToFit];
    [self.labelNoRecentActivity sizeToFit];
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

- (void)requestActivity
{
    [self.activityPageControl setNumberOfPages:2];
    CGRect activityButtonFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.activityHeaderScrollview.frame.size.height);
    for (int c = 0; c < 2; c++) {
        if(c == 0){
            [self.activityHeaderScrollview addSubview:self.myActivityView];
            [self.myActivityView setFrame:activityButtonFrame];
        }
        if(c == 1){
            [self.activityHeaderScrollview addSubview:self.globalActivityView];
            [self.globalActivityView setFrame:activityButtonFrame];
        }
        
        activityButtonFrame.origin.x+=activityButtonFrame.size.width;
    }
    CGSize contentSize = self.activityHeaderScrollview.frame.size;
    contentSize.width = activityButtonFrame.origin.x;
    contentSize.height = 0;
    [self.activityHeaderScrollview setContentSize:contentSize];
    [self.headerLabel setFont:[UIFont FontForHeader]];
    if (self.activityPageControl.currentPage == 0) {
        UIFont *font1 = [UIFont FontForHeader];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"My " attributes: arialDict];
        
        UIFont *font2 = [UIFont FontForHeaderNoBold];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:@"Activity" attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        self.headerLabel.attributedText = aAttrString1;
    }else{
        UIFont *font1 = [UIFont FontForHeader];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Global " attributes: arialDict];
        
        UIFont *font2 = [UIFont FontForHeaderNoBold];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:@"Activity" attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        self.headerLabel.attributedText = aAttrString1;
    }
    
    [self.myActivityTableView setContentInset:UIEdgeInsetsMake(10.0f,0,0,0)];
    [self.globalActivityTableView setContentInset:UIEdgeInsetsMake(20.0f,0,0,0)];
    self.myActivityTableView.tag = 1000;
    self.globalActivityTableView.tag = 1000;
    [self requestActivityWithActivityType:kParamKeyMyActivities];
}

- (void) requestActivityWithActivityType:(NSString*)activityType
{
    if (httpReq) {
        httpReq.delegate=nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:[NSDictionary dictionaryWithObjectsAndKeys:activityType,kParamKeyAction,[[STUserIdentity sharedInstance] userId],kParamKeyUserID, nil] json:YES];
}

#pragma mark ----- BOABHttpReqDelegates
- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if ([responseArray isKindOfClass:[NSArray class]]) {
            if (responseArray) {
                [self.globalActivityTableView setHidden:NO];
                [self.myActivityTableView setHidden:NO];
                if ([[[conn.userInfo objectForKey:@"params"] objectForKey:kParamKeyAction] isEqualToString:kParamKeyMyActivities]) {
                    if (self.myActivityArray) {
                        self.myActivityArray = nil;
                    }
                    self.myActivityArray = [responseArray mutableCopy];
                    [self.myActivityTableView reloadData];
                }else{
                    if (self.globalActivityArray) {
                        self.globalActivityArray = nil;
                    }
                    self.globalActivityArray = [responseArray mutableCopy];
                    [self.globalActivityTableView reloadData];
                }
            }else{
                [self.globalActivityTableView setHidden:YES];
                [self.myActivityTableView setHidden:YES];
            }
        }else if ([responseArray isKindOfClass:[NSDictionary class]]){
            if ([(NSDictionary*)responseArray objectForKey:@"error"]) {
            }
            [self.myActivityTableView reloadData];
            [self.globalActivityTableView reloadData];
            [self.globalActivityTableView setHidden:YES];
            [self.myActivityTableView setHidden:YES];
            
        }else{
            [self.globalActivityTableView setHidden:YES];
            [self.myActivityTableView setHidden:YES];
        }
        
    }else{
        [self.globalActivityTableView setHidden:YES];
        [self.myActivityTableView setHidden:YES];
    }
}

- (void)BOABHttpReqFailedWithError:(NSError*)error
{
    if (error) {
    }
}

#pragma mark ----- Scrollview Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentIndex = (int) (self.activityHeaderScrollview.contentOffset.x / self.activityHeaderScrollview.frame.size.width) ;
    [self.activityPageControl setCurrentPage:currentIndex];
    if (self.activityPageControl.currentPage == 0) {
        UIFont *font1 = [UIFont FontForHeader];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"My " attributes: arialDict];
        
        UIFont *font2 = [UIFont FontForHeaderNoBold];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:@"Activity" attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        self.headerLabel.attributedText = aAttrString1;
    }else{
        UIFont *font1 = [UIFont FontForHeader];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Global " attributes: arialDict];
        
        UIFont *font2 = [UIFont FontForHeaderNoBold];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:@"Activity" attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        self.headerLabel.attributedText = aAttrString1;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1000)
        return;
    if (self.activityPageControl.currentPage == 0) {
        [self requestActivityWithActivityType:kParamKeyMyActivities];
    }else{
        [self requestActivityWithActivityType:kParamKeyGlobalActivities];
    }
}

#pragma mark ----- ActivityTableView Delegtes
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = 100;
    if ([self.myActivityArray count]>0) {
        rowHeight += [self getDynamicLabelSize:[UIFont FontGothamRoundedBoldWithSize:10.0f] maxWidth:247.0f maxHeight:CGFLOAT_MAX myText:[[self.myActivityArray objectAtIndex:indexPath.row] objectForKey:@"description"]].height-37;
    }
    return rowHeight;
}

-(CGSize) getDynamicLabelSize:(UIFont *)font maxWidth:(CGFloat) maxWidth maxHeight:(CGFloat) maxHeight myText:(NSString *) myText
{
    CGSize expectedLabelSize;
    
    NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:font forKey: NSFontAttributeName];
    expectedLabelSize = [myText boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                             options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                          attributes:stringAttributes context:nil].size;
    
    return expectedLabelSize;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount = 0;
    if (self.activityPageControl.currentPage == 0) {
        rowCount = (int)[self.myActivityArray count];
    }else{
        rowCount = (int)[self.globalActivityArray count];
    }
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.myActivityTableView) {
        static NSString *simpleTableIdentifier = @"STChildMyActivityCustomCell";
        STChildMyActivityCustomCell *myActivityCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (myActivityCell == nil) {
            myActivityCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([STChildMyActivityCustomCell class]) owner:self options:0] objectAtIndex:0];
        }
        if ([self.myActivityArray count] > indexPath.row) {
            if ([self.myActivityArray objectAtIndex:indexPath.row]) {
                
                [myActivityCell.labelDescription setAttributedText:[[NSAttributedString alloc] initWithString:[[self.myActivityArray objectAtIndex:indexPath.row] objectForKey:@"description"]
                                                                                                   attributes:@{
                                                                                                                NSForegroundColorAttributeName:[UIColor stasherTextColor],
                                                                                                                NSFontAttributeName : [UIFont FontGothamRoundedBoldWithSize:10.0f]
                                                                                                                }
                                                                    ]];
                CGRect paragraphRect = [myActivityCell.labelDescription.attributedText boundingRectWithSize:CGSizeMake(myActivityCell.labelDescription.frame.size.width, CGFLOAT_MAX)
                                                                                                    options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                                                                    context:nil];
                myActivityCell.constraintLabelDescriptionHeight.constant = paragraphRect.size.height;
                 
                [myActivityCell.labelDescription setTextColor:[UIColor stasherTextColor]];
                //[myActivityCell.labelDescription setFont:[UIFont FontGothamRoundedBoldWithSize:10.0f]];
                //[myActivityCell.labelDescription setText:[[self.myActivityArray objectAtIndex:indexPath.row] objectForKey:@"description"]];
                [myActivityCell.labelDescription sizeToFit];
                [myActivityCell.labelActivityTitle setFont:[UIFont FontGothamRoundedMediumWithSize:8.5f]];
                [myActivityCell.labelActivityTitle setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
                [myActivityCell.labelActivityTitle setText:[[self.myActivityArray objectAtIndex:indexPath.row] objectForKey:@"title"]];
                switch ([[[self.myActivityArray objectAtIndex:indexPath.row] objectForKey:@"activity_type"] intValue]) {
                    case 1:
                        [myActivityCell.activityTypeImgView setImage:[UIImage imageNamed:@"fund_request"]];
                        break;
                    case 2:
                        [myActivityCell.activityTypeImgView setImage:[UIImage imageNamed:@"mission_Accepted"]];
                        break;
                    case 3:
                        [myActivityCell.activityTypeImgView setImage:[UIImage imageNamed:@"mission_completed"]];
                        break;
                    default:
                        break;
                }
                [myActivityCell.labelActivityTime setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
                [myActivityCell.labelActivityTime setFont:[UIFont FontGothamRoundedMediumWithSize:6.5f]];
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
                //CGRect timeLabelFrame = myActivityCell.labelActivityTime.frame;
                //timeLabelFrame.origin.y = myActivityCell.constraintLabelDescriptionHeight.constant + myActivityCell.labelDescription.frame.origin.y + 8.0f;
                //[myActivityCell.labelActivityTime setFrame:timeLabelFrame];
            }
        }
        [myActivityCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return myActivityCell;
    }
    
    static NSString *simpleTableIdentifier = @"STChildGlobalActivityCustomCell";
    STChildGlobalActivityCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([STChildGlobalActivityCustomCell class]) owner:self options:0] objectAtIndex:0];
    }
    if ([self.globalActivityArray count] > indexPath.row) {
        if ([self.myActivityArray objectAtIndex:indexPath.row]) {
            [cell.labelDescription setAttributedText:[[NSAttributedString alloc] initWithString:[[self.globalActivityArray objectAtIndex:indexPath.row] objectForKey:@"description"]
                                                                                     attributes:@{
                                                                                                  NSForegroundColorAttributeName:[UIColor stasherTextColor],
                                                                                                  NSFontAttributeName : [UIFont FontGothamRoundedMediumWithSize:12.0f]
                                                                                                  }
                                                      ]];
            CGRect paragraphRect = [cell.labelDescription.attributedText boundingRectWithSize:CGSizeMake(200.f, CGFLOAT_MAX)
                                                                                      options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                                                      context:nil];
            cell.constraintLabelDescriptionHeight.constant = paragraphRect.size.height;
            
            [cell.labelActivityTitle setTextColor:[UIColor stasherTextColor]];
            [cell.labelActivityTitle setFont:[UIFont FontGothamRoundedBoldWithSize:13.0f]];
            [cell.labelActivityTitle setText:[NSString stringWithFormat:@"%@ %@",[[self.globalActivityArray objectAtIndex:indexPath.row] objectForKey:@"fname"],[[self.globalActivityArray objectAtIndex:indexPath.row] objectForKey:@"lname"]]];
            
            [cell.labelActivityTime setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
            [cell.labelActivityTime setFont:[UIFont FontGothamRoundedMediumWithSize:6.5f]];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *theDate = [dateFormat dateFromString:[[self.globalActivityArray objectAtIndex:indexPath.row] objectForKey:@"inserted_date"]];
            
            NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
            [dateFormat2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *theDate2 = [dateFormat2 stringFromDate:[NSDate date]];
            NSDate *dt = [dateFormat dateFromString:theDate2];
            int minutes = [dt timeIntervalSinceDate:theDate] / 60;
            if (minutes < 1) {
                [cell.labelActivityTime setText:@"Just now"];
            }else if (minutes > 1 && minutes < 60){
                [cell.labelActivityTime setText:[NSString stringWithFormat:@"%d Minutes Ago",minutes]];
            }else if (minutes >59 && minutes < 1440){
                [cell.labelActivityTime setText:[NSString stringWithFormat:@"%d Hours Ago",minutes/60]];
            }else if (minutes > 1439){
                [cell.labelActivityTime setText:[NSString stringWithFormat:@"%d Days Ago",minutes/1440]];
            }
            [cell.activityTypeImgView setImageWithURL:[NSURL URLWithString:[[self.globalActivityArray objectAtIndex:indexPath.row] objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"Stasher_FacePlaceHolder"]];
            
            CGRect timeLabelFrame = cell.labelActivityTime.frame;
            timeLabelFrame.origin.y = cell.constraintLabelDescriptionHeight.constant + cell.labelDescription.frame.origin.y + 8.0f;
            [cell.labelActivityTime setFrame:timeLabelFrame];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self.delegate respondsToSelector:@selector(ChildActivityCellDidSelectWithDict:)]) {
        [self.delegate ChildActivityCellDidSelectWithDict:[self.myActivityArray objectAtIndex:indexPath.row]];
    }
}


@end
