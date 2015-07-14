//
//  STActivityDetailsViewController.m
//  Stasher
//
//  Created by Bhushan on 24/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import "STActivityDetailsViewController.h"

@interface STActivityDetailsViewController ()

@end

@implementation STActivityDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailsDict:(NSDictionary*)dict
{
    self = [super initWithNibName:@"STActivityDetailsViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.detailsDict = [dict mutableCopy];
        NSLog(@"activity details dict %@",self.detailsDict);
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    switch ([[self.detailsDict objectForKey:@"activity_type"] intValue]) {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
        case 7:
            
            break;
        case 8:
            
            break;
        case 9:
            
            break;
        case 10:
            [self.atView11 setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.atView11.frame.size.height)];
            [self.atContainerView addSubview:self.atView11 withAnimation:YES];
            [self.labelActivityTitleView11 setText:[self.detailsDict objectForKey:@"description"]];
            [self.imgViewProfilePicView11 setImageWithURL:[NSURL URLWithString:[self.detailsDict objectForKey:kParamKeyAvatar]]];
            break;
        case 11:
            [self.atView11 setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.atView11.frame.size.height)];
            [self.atContainerView addSubview:self.atView11 withAnimation:YES];
            [self.labelActivityTitleView11 setText:[self.detailsDict objectForKey:@"description"]];
            [self.imgViewProfilePicView11 setImageWithURL:[NSURL URLWithString:[self.detailsDict objectForKey:kParamKeyAvatar]]];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.headerLabel setFont:[UIFont FontForHeader]];
    [self.labelActivityDescription sizeToFit];
    [self.labelActivityDescription setFont:[UIFont FontGothamRoundedBoldWithSize:11.0f]];
    [self.labelActivityDescription setTextColor:[UIColor stasherTextColor]];
    
    [self.labelActivityTitleView11 sizeToFit];
    [self.labelActivityTitleView11 setFont:[UIFont FontGothamRoundedBoldWithSize:11.0f]];
    [self.labelActivityTitleView11 setTextColor:[UIColor stasherTextColor]];
    
    [self.buttonAcceptATView11.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.buttonCancelATView11.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    
    self.imgViewProfilePicView11.clipsToBounds = YES;
    self.imgViewProfilePicView11.layer.cornerRadius = 49.0f/2.0f;
    self.imgViewProfilePicView11.layer.borderColor=[UIColor clearColor].CGColor;
    self.imgViewProfilePicView11.layer.borderWidth=2.0f;
    self.imgViewProfilePicView11.contentMode = UIViewContentModeScaleAspectFill;
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

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----- ATView11

- (IBAction)cancelAtView11ButtonPressed:(id)sender
{
    [self requestRelationWithStatus:0];
}

- (IBAction)acceptAtView11ButtonPressed:(id)sender
{
    [self requestRelationWithStatus:2];
}

- (void) requestRelationWithStatus:(int)status
{
    if (httpReq) {
        httpReq.delegate = nil;
        httpReq = nil;
    }
    httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
    if ([httpReq reachable]) {
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
            [paramDict setObject:kAPIActionAddRelation forKey:kParamKeyAction];
            [paramDict setObject:[[STUserIdentity sharedInstance] userId] forKey:kParamKeyChildID];
            [paramDict setObject:[self.detailsDict objectForKey:@"requestfrom"] forKey:kParamKeyParentID];
            [paramDict setObject:[NSString stringWithFormat:@"%d",status] forKey:@"status"];
          if([self.detailsDict objectForKey:@"activityId"])
            [paramDict setObject:[self.detailsDict objectForKey:@"activityId"] forKey:@"activityId"];
            [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:paramDict json:YES];
            paramDict = nil;
        }
}



#pragma mark - BOABHttpReqDelegates
- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        if ([[[conn.userInfo objectForKey:@"params"] objectForKey:@"action"] isEqualToString:kAPIActionAddRelation]) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
            if ([[responseDict objectForKey:@"success"] objectForKey:@"message"]) {
                [UIAlertView showWithTitle:@""
                                   message:[[responseDict objectForKey:@"success"] objectForKey:@"message"]
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      if (buttonIndex == [alertView cancelButtonIndex]) {
                                          [self.navigationController popViewControllerAnimated:YES];
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

@end
