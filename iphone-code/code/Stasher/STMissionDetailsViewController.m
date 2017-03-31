//
//  STMissionDetailsViewController.m
//  Stasher
//
//  Created by Bhushan on 24/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import "STMissionDetailsViewController.h"

@interface STMissionDetailsViewController ()

@end

@implementation STMissionDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil detailsDict:(NSDictionary*)dict
{
    self = [super initWithNibName:@"STMissionDetailsViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.missionDetailsDict = [dict mutableCopy];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
        [self.labelChallengerNameTitle setText:@"Child Name"];
        [self.labelChallengerName setText:[NSString stringWithFormat:@"%@ %@",[[self.missionDetailsDict objectForKey:kParamKeyChild] objectForKey:kParamKeyFirstname],[[self.missionDetailsDict objectForKey:kParamKeyChild] objectForKey:kParamKeyLastname]]];
        if (![[[self.missionDetailsDict objectForKey:kParamKeyChild] objectForKey:kParamKeyAvatar] isKindOfClass:[NSNull class]]) {
            [self.imgViewProfilePic setImageWithURL:[NSURL URLWithString:[[self.missionDetailsDict objectForKey:kParamKeyChild] objectForKey:kParamKeyAvatar]]];
        }
    }else{
        [self.labelChallengerNameTitle setText:@"Parent Name"];
        [self.labelChallengerName setText:[NSString stringWithFormat:@"%@ %@",[[self.missionDetailsDict objectForKey:kParamKeyParent] objectForKey:kParamKeyFirstname],[[self.missionDetailsDict objectForKey:kParamKeyParent] objectForKey:kParamKeyLastname]]];
        
        if (![[[self.missionDetailsDict objectForKey:kParamKeyParent] objectForKey:kParamKeyAvatar] isKindOfClass:[NSNull class]]) {
            [self.imgViewProfilePic setImageWithURL:[NSURL URLWithString:[[self.missionDetailsDict objectForKey:kParamKeyParent] objectForKey:kParamKeyAvatar]]];
        }
    }
    
    [self.labelMissionName setText:[self.missionDetailsDict objectForKey:@"title"]];
    if ([[self.missionDetailsDict objectForKey:@"description"] validateNotEmpty]) {
         [self.txtViewMissionDescription setText:[self.missionDetailsDict objectForKey:@"description"]];
        [self.txtViewMissionDescription setHidden:NO];
        [self.labelMissionDescriptionTitle setHidden:NO];
        [self.imgViewTxtBG setHidden:NO];
    }else{
        [self.txtViewMissionDescription setHidden:YES];
        [self.labelMissionDescriptionTitle setHidden:YES];
        [self.imgViewTxtBG setHidden:YES];
    }
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.headerLabel setFont:[UIFont FontForHeader]];
    [self.labelChallengerNameTitle setFont:[UIFont FontGothamRoundedBookWithSize:8.0f]];
    [self.labelMissionNameTitle setFont:[UIFont FontGothamRoundedBookWithSize:8.0f]];
    [self.labelMissionDescriptionTitle setFont:[UIFont FontGothamRoundedBookWithSize:8.0f]];
    [self.labelMissionNameTitle sizeToFit];
        
    [self.labelChallengerName setFont:[UIFont FontGothamRoundedBoldWithSize:11.0f]];
    [self.labelMissionName setFont:[UIFont FontGothamRoundedBoldWithSize:11.0f]];
    [self.txtViewMissionDescription setFont:[UIFont FontGothamRoundedBoldWithSize:11.0f]];
    
    [self.labelChallengerNameTitle setTextColor:[UIColor stasherTextColor]];
    [self.labelMissionNameTitle setTextColor:[UIColor stasherTextColor]];
    [self.labelMissionDescriptionTitle setTextColor:[UIColor stasherTextColor]];
    [self.labelChallengerName setTextColor:[UIColor stasherTextColor]];
    [self.labelMissionName setTextColor:[UIColor stasherTextColor]];
    [self.txtViewMissionDescription setTextColor:[UIColor stasherTextColor]];
    
    [self.labelMissionName sizeToFit];

    self.imgViewProfilePic.clipsToBounds = YES;
    self.imgViewProfilePic.layer.cornerRadius = self.imgViewProfilePic.frame.size.width/2.0f;
    self.imgViewProfilePic.layer.borderColor=[UIColor clearColor].CGColor;
    self.imgViewProfilePic.layer.borderWidth=0.5f;
    self.imgViewProfilePic.contentMode = UIViewContentModeScaleAspectFill;
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

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
