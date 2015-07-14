//
//  STChildAccountParentDetailsViewController.m
//  Stasher
//
//  Created by bhushan on 03/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STChildAccountParentDetailsViewController.h"

@interface STChildAccountParentDetailsViewController ()

@end

@implementation STChildAccountParentDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andParentDetailsDictionary:(NSDictionary*)thisDetailsDict
{
    self = [super initWithNibName:@"STChildAccountParentDetailsViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.parentDetailsDictionary = [NSMutableDictionary dictionaryWithDictionary:thisDetailsDict];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.labelCompleteName.text = [NSString stringWithFormat:@"%@ %@",[self.parentDetailsDictionary objectForKey:kParamKeyFirstname],[self.parentDetailsDictionary objectForKey:kParamKeyLastname]];
    self.labelUsername.text = [self.parentDetailsDictionary objectForKey:kParamKeyUsername];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.headerLabel setFont:[UIFont FontForHeader]];
    [self.labelCompleteName setFont:[UIFont FontGothamRoundedMediumWithSize:10.0f]];
    [self.labelCompleteName setTextColor:[UIColor stasherTextFieldPlaceHolderColor]];
    [self.labelUsername setFont:[UIFont FontGothamRoundedMediumWithSize:18.0f]];
    [self.labelUsername setTextColor:[UIColor stasherTextColor]];
    self.parentProfilePictureImgView.clipsToBounds = YES;
    self.parentProfilePictureImgView.layer.cornerRadius = 80/2.0f;
    self.parentProfilePictureImgView.layer.borderColor=[UIColor clearColor].CGColor;
    self.parentProfilePictureImgView.layer.borderWidth=0.5f;
    self.parentProfilePictureImgView.contentMode = UIViewContentModeScaleAspectFill;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[STSharedCustoms sharedAddGestureInstanceWithDelegate:self] addRightSwipeGestureRecognizerToMe];
    if (![[self.parentDetailsDictionary objectForKey:kParamKeyAvatar] isKindOfClass:[NSNull class]] && ![[self.parentDetailsDictionary objectForKey:kParamKeyAvatar] isEqualToString:@""]) {
        [self.parentProfilePictureImgView setImageWithURL:[NSURL URLWithString:[self.parentDetailsDictionary objectForKey:kParamKeyAvatar]]placeholderImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }else{
        [self.parentProfilePictureImgView setImage:[UIImage imageNamed:@"account_face_placeholder"]];
    }
}

- (void)rightGestureHandle
{
    [self.navigationController popViewControllerAnimated:YES];
    [STSharedCustoms sharedAddGestureInstanceWithDelegate:nil];
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

- (IBAction)backBUttonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
