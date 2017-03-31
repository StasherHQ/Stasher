//
//  STParentMissionsListViewController.m
//  Stasher
//
//  Created by bhushan on 25/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STParentMissionsListViewController.h"

@interface STParentMissionsListViewController ()

@end

@implementation STParentMissionsListViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil missionListType:(NSString*)missionsListKind andMissionListArray:(NSMutableArray*)array
{
    self = [super initWithNibName:@"STParentMissionsListViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.missionsListType = missionsListKind;
        if (!self.arrayMissionList) {
            self.arrayMissionList = [[NSMutableArray alloc] initWithArray:array];
        }
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
    [self.missionListTableView setContentInset:UIEdgeInsetsMake(10.0f,0,0,0)];
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




#pragma mark ----- Table Mission List

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.missionsListType isEqualToString:kMissionBarCompletedMission])
        return 170.0;
    return 200.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayMissionList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if ([self.missionsListType isEqualToString:kMissionBarCompletedMission])
    {
        static NSString *parentCompletedMissionCustomTableViewCellIdentifier = @"STParentCompletedMissionCustomTableViewCell";
        
        STParentCompletedMissionCustomTableViewCell *missionCompleteCell = [tableView dequeueReusableCellWithIdentifier:parentCompletedMissionCustomTableViewCellIdentifier];
        
        if (missionCompleteCell == nil) {
            missionCompleteCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([STParentCompletedMissionCustomTableViewCell class]) owner:self options:0] objectAtIndex:0];
        }
        if ([self.arrayMissionList count] > indexPath.row) {
            if ([self.arrayMissionList objectAtIndex:indexPath.row]) {
                missionCompleteCell.labelMissionTitle.text = [[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:@"title"];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *theDate = [dateFormat dateFromString:[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:@"totaltime"]];
                NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                [dateFormat2 setDateFormat:@"MMMM d, YYYY"];
                NSString *dateStr = [dateFormat2 stringFromDate:theDate];
                
                missionCompleteCell.labelMissionInfo.text = [NSString stringWithFormat:@"Mission %d for %@ - %@",[[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:@"missionId"] intValue], [[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kParamKeyChild] objectForKey:kParamKeyFirstname],dateStr];
                
                if(![[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kAddMissionParamKeyRewardType] isEqualToString:@"gift"]){
                    [missionCompleteCell.labelRewardAmount setHidden:NO];
                    UIFont *font1 = [UIFont FontGothamRoundedBoldWithSize:9.6f];
                    NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
                    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"$"] attributes: arialDict];
                    
                    UIFont *font2 = [UIFont FontGothamRoundedBoldWithSize:15.6f];
                    NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
                    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kAddMissionParamKeyRewards] attributes: arialDict2];
                    [aAttrString1 appendAttributedString:aAttrString2];
                    [missionCompleteCell.labelRewardAmount setAttributedText:aAttrString1];
                    [missionCompleteCell.giftIconImgView setHidden:YES];
                    
                }
                else{
                    [missionCompleteCell.labelRewardAmount setHidden:YES];
                    [missionCompleteCell.giftIconImgView setHidden:NO];
                }
             }
            [missionCompleteCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return missionCompleteCell;
        }
    }
    */
    static NSString *simpleTableIdentifier = @"STParentMissionCustomTableViewCell";
    
    STParentMissionCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([STParentMissionCustomTableViewCell class]) owner:self options:0] objectAtIndex:0];
    }
    if ([self.arrayMissionList count] > indexPath.row) {
        if ([self.arrayMissionList objectAtIndex:indexPath.row]) {
            cell.labelMissionCount.text = [NSString stringWithFormat:@"Mission %d:",(int) (indexPath.row + 1)];
            cell.labelMissionTitle.text = [[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:@"title"];
            NSUInteger totalMissionHrs, leftMissionHrs;
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *theDateOfInsertion = [dateFormat dateFromString:[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:@"inserted_date"]];
            NSDate *theDate = [dateFormat dateFromString:[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:@"totaltime"]];
            if (theDateOfInsertion != nil && theDate != nil) {
                NSCalendar *c = [NSCalendar currentCalendar];
                NSDateComponents *components = [c components:NSCalendarUnitHour fromDate:theDateOfInsertion toDate:theDate options:kNilOptions];
                NSUInteger diff = components.hour;
                totalMissionHrs = diff;
            }
            if ( theDate != nil ) {
                NSCalendar *c = [NSCalendar currentCalendar];
                NSDateComponents *components = [c components:NSCalendarUnitHour fromDate:[NSDate date] toDate:theDate options:kNilOptions];
                NSUInteger diff = components.hour;
                leftMissionHrs = diff;
            }
            float prog =[[NSNumber numberWithUnsignedInteger:leftMissionHrs] floatValue]/[[NSNumber numberWithUnsignedInteger:totalMissionHrs] floatValue];
            NSLog(@"prog %f at ind %d",prog, (int)indexPath.row);
            if (totalMissionHrs < 8760) //A year's hours
            {
                if(prog == 1.0f){
                    [cell.imgViewMissionExpired setHidden:YES];
                    if (leftMissionHrs<=24) {
                        UIFont *font4 = [UIFont FontGothamRoundedMediumWithSize:11.5f];
                        NSDictionary *arialDict4 = [NSDictionary dictionaryWithObject: font4 forKey:NSFontAttributeName];
                        NSMutableAttributedString *aAttrString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  ", [NSString stringWithFormat:@"%lu",(unsigned long)leftMissionHrs]] attributes: arialDict4];
                        
                        UIFont *font5 = [UIFont FontGothamRoundedBoldWithSize:5.0f];
                        NSDictionary *arialDict5 = [NSDictionary dictionaryWithObject: font5 forKey:NSFontAttributeName];
                        NSMutableAttributedString *aAttrString5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",@"HOURS"] attributes: arialDict5];
                        [aAttrString4 appendAttributedString:aAttrString5];
                        [cell.labelDueHrs setAttributedText:aAttrString4];
                    }else{
                        NSUInteger day, hr;
                        day = leftMissionHrs / 24;
                        hr = leftMissionHrs % 24;
                        
                        UIFont *font4 = [UIFont FontGothamRoundedMediumWithSize:11.5f];
                        NSDictionary *arialDict4 = [NSDictionary dictionaryWithObject: font4 forKey:NSFontAttributeName];
                        NSMutableAttributedString *aAttrString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@d %@h", [NSString stringWithFormat:@"%lu",(unsigned long)day],[NSString stringWithFormat:@"%lu",(unsigned long)hr]] attributes: arialDict4];
                        [cell.labelDueHrs setAttributedText:aAttrString4];
                    }
                    [cell.dueProgressView setProgress:1.0f - prog];
                }
                else if (prog >1.0f) {
                    [cell.imgViewMissionExpired setHidden:NO];
                }else if (prog >=0.1 && prog < 1.0){
                    [cell.imgViewMissionExpired setHidden:YES];
                    
                    if (leftMissionHrs<=24) {
                        UIFont *font4 = [UIFont FontGothamRoundedMediumWithSize:11.5f];
                        NSDictionary *arialDict4 = [NSDictionary dictionaryWithObject: font4 forKey:NSFontAttributeName];
                        NSMutableAttributedString *aAttrString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  ", [NSString stringWithFormat:@"%lu",(unsigned long)leftMissionHrs]] attributes: arialDict4];
                        
                        UIFont *font5 = [UIFont FontGothamRoundedBoldWithSize:5.0f];
                        NSDictionary *arialDict5 = [NSDictionary dictionaryWithObject: font5 forKey:NSFontAttributeName];
                        NSMutableAttributedString *aAttrString5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",@"HOURS"] attributes: arialDict5];
                        [aAttrString4 appendAttributedString:aAttrString5];
                        [cell.labelDueHrs setAttributedText:aAttrString4];
                    }else{
                        NSUInteger day, hr;
                        day = leftMissionHrs / 24;
                        hr = leftMissionHrs % 24;
                        
                        UIFont *font4 = [UIFont FontGothamRoundedMediumWithSize:11.5f];
                        NSDictionary *arialDict4 = [NSDictionary dictionaryWithObject: font4 forKey:NSFontAttributeName];
                        NSMutableAttributedString *aAttrString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@d %@h", [NSString stringWithFormat:@"%lu",(unsigned long)day],[NSString stringWithFormat:@"%lu",(unsigned long)hr]] attributes: arialDict4];
                        [cell.labelDueHrs setAttributedText:aAttrString4];
                    }
                    
                    [cell.dueProgressView setProgress:1.0f - prog];
                }else{
                    [cell.imgViewMissionExpired setHidden:NO];
                }
            }else{
                [cell.imgViewMissionExpired setHidden:NO];
            }
            
            if(![[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kAddMissionParamKeyRewardType] isEqualToString:@"gift"]){
                [cell.labelRewardAmount setHidden:NO];
                UIFont *font1 = [UIFont FontGothamRoundedBoldWithSize:9.6f];
                NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"$"] attributes: arialDict];
                
                UIFont *font2 = [UIFont FontGothamRoundedBoldWithSize:9.6f];
                NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
                NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kAddMissionParamKeyRewards] attributes: arialDict2];
                [aAttrString1 appendAttributedString:aAttrString2];
                [cell.labelRewardAmount setAttributedText:aAttrString1];
                [cell.labelRewardAmount sizeToFit];
                [cell.giftIconImgView setHidden:YES];
            }
            else{
                [cell.labelRewardAmount setHidden:YES];
                [cell.giftIconImgView setHidden:NO];
            }
            
            
            cell.missionDictionary = [self.arrayMissionList objectAtIndex:indexPath.row];
            cell.delegate = self;
            cell.cellMissionTypeString = self.missionsListType;
            
            if ([cell.cellMissionTypeString isEqualToString:kMissionBarCompletedMission]) {
                [cell.imgViewMissionExpired setHidden:YES];
                [cell.dueProgressView setProgress:1.0f]; //set full progress for completed mission
            }

            
            if ([cell.cellMissionTypeString isEqualToString:kMissionBarCompletedMission]) {
                [cell.imgViewDividerForCompletedMission setHidden:NO];
                [cell.buttonComplete setHidden:YES];
                [cell.buttonEdit setHidden:YES];
                [cell.imgViewDivider setHidden:YES];
            }else{
                [cell.imgViewDividerForCompletedMission setHidden:YES];
                [cell.buttonComplete setHidden:NO];
                [cell.buttonEdit setHidden:NO];
                [cell.imgViewDivider setHidden:NO];
            }
            
            if ([cell.cellMissionTypeString isEqualToString:kMissionBarCompletedMission]) {
                [cell.imgViewMissionStatus setImage:[UIImage imageNamed:@"Stasher_StatusCheckmark"]];
            }
            else if ([cell.cellMissionTypeString isEqualToString:kMissionBarPendingMission]){
                [cell.imgViewMissionStatus setImage:[UIImage imageNamed:@"Stasher_StatusCrossmark"]];
            }
            else if ([cell.cellMissionTypeString isEqualToString:kMissionBarActiveMission]){
                [cell.imgViewMissionStatus setImage:[UIImage imageNamed:@"Stasher_StatusCrossmark"]];
            }
            else
            {
                if ([[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kParamKeyMissionStatus] intValue] == 3) {
                    [cell.imgViewMissionStatus setImage:[UIImage imageNamed:@"Stasher_StatusCheckmark"]];
                }else{
                    [cell.imgViewMissionStatus setImage:nil];
                }
            }
            
            if ([[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kParamKeyChild]) {
                    [cell.imgViewChallenger setImageWithURL:[NSURL URLWithString:[[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kParamKeyChild] objectForKey:kParamKeyAvatar]]];
            }
            if ([self.missionsListType isEqualToString:kMissionBarPendingMission]) {
                [cell.buttonComplete setTitle:@"Remind" forState:UIControlStateNormal];
            }
            else if ([self.missionsListType isEqualToString:kMissionBarActiveMission]){
                [cell.buttonComplete setTitle:@"Complete" forState:UIControlStateNormal];
            }
            if (![[[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kParamKeyChild] objectForKey:kParamKeyAvatar] isKindOfClass:[NSNull class]]) {
                 [cell.imgViewChallenger setImageWithURL:[NSURL URLWithString:[[[self.arrayMissionList objectAtIndex:indexPath.row] objectForKey:kParamKeyChild] objectForKey:kParamKeyAvatar]]];
            }
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self.delegate respondsToSelector:@selector(parentMissionListCellDidSelectWithDict:)]) {
        [self.delegate parentMissionListCellDidSelectWithDict:[self.arrayMissionList objectAtIndex:indexPath.row]];
    }
}


- (void)completeMissionButtonPressedWithMissionDictionary:(NSDictionary*)dict
{
    if ([self.delegate respondsToSelector:@selector(parentCellCompleteMissionButtonPressedWithMissionDict:)]) {
        [self.delegate parentCellCompleteMissionButtonPressedWithMissionDict:dict];
    }
}

- (void)remindButtonPressedWithMissionDictionary:(NSDictionary *)dict
{
    if ([self.delegate respondsToSelector:@selector(parentCellRemindMissionButtonPressedWithMissionDict:)]) {
        [self.delegate parentCellRemindMissionButtonPressedWithMissionDict:dict];
    }
}

- (void)editMissionButtonPressedWithMissionDictionary:(NSDictionary*)dict
{
    if ([self.delegate respondsToSelector:@selector(parentCellEditMissionButtonPressedWithMissionDict:)]) {
        [self.delegate parentCellEditMissionButtonPressedWithMissionDict:dict];
    }
}



@end
