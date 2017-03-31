//
//  STActivityViewController.m
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STActivityViewController.h"
#import "STActivityDetailsViewController.h"

@interface STActivityViewController ()

@end

@implementation STActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
        if (parentActivityVC) {
            [parentActivityVC.view removeFromSuperview];
            parentActivityVC = nil;
        }
        parentActivityVC = [[STParentActivityViewController alloc] initWithNibName:@"STParentActivityViewController" bundle:[NSBundle mainBundle]];
        parentActivityVC.delegate = self;
        [parentActivityVC.view setFrame:self.containerView.frame];
        [self.containerView addSubview:parentActivityVC.view withAnimation:YES];
        [parentActivityVC performSelector:@selector(requestActivity) withObject:self afterDelay:0.01];
    }
    else if ([[STUserIdentity sharedInstance] userIdentity] == CHILDUSER){
        if (childActivityVC) {
            [childActivityVC.view removeFromSuperview];
            childActivityVC = nil;
        }
        childActivityVC = [[STChildActivityViewController alloc] initWithNibName:@"STChildActivityViewController" bundle:[NSBundle mainBundle]];
        childActivityVC.delegate = self;
        [childActivityVC.view setFrame:self.containerView.frame];
        [self.containerView addSubview:childActivityVC.view withAnimation:YES];
        [childActivityVC performSelector:@selector(requestActivity) withObject:self afterDelay:0.01];

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

#pragma mark ------ Parent Methods

-(void)parentActivityCellDidSelectWithDict:(NSDictionary *)dict
{
    /*
    STActivityDetailsViewController *activityDetailVC = [[STActivityDetailsViewController alloc] initWithNibName:@"STActivityDetailsViewController" bundle:[NSBundle mainBundle] detailsDict:dict];
    [self.navigationController pushViewController:activityDetailVC animated:YES];
     */
    NSLog(@"activity dict %@",dict);
    if ([dict objectForKey:@"activity_type"]) {
        switch ([[dict objectForKey:@"activity_type"] intValue]) {
            case 2:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 3:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 4:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 5:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 6:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 7:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 8:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 9:
                [self.tabBarController setSelectedIndex:3];
                break;
            default:
                break;
        }
    }
}

#pragma mark ------ Child Methods

- (void)ChildActivityCellDidSelectWithDict:(NSDictionary *)dict
{
    NSLog(@"activity dict %@",dict);
    /*
    STActivityDetailsViewController *activityDetailVC = [[STActivityDetailsViewController alloc] initWithNibName:@"STActivityDetailsViewController" bundle:[NSBundle mainBundle] detailsDict:dict];
    [self.navigationController pushViewController:activityDetailVC animated:YES];
    */
    if ([dict objectForKey:@"activity_type"]) {
        switch ([[dict objectForKey:@"activity_type"] intValue]) {
            case 2:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 3:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 4:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 5:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 6:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 7:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 8:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 9:
                [self.tabBarController setSelectedIndex:3];
                break;
            case 10:{
                STActivityDetailsViewController *activityDetailVC = [[STActivityDetailsViewController alloc] initWithNibName:@"STActivityDetailsViewController" bundle:[NSBundle mainBundle] detailsDict:dict];
                [self.navigationController pushViewController:activityDetailVC animated:YES];
            }
                break;
            case 11:{
                STActivityDetailsViewController *activityDetailVC = [[STActivityDetailsViewController alloc] initWithNibName:@"STActivityDetailsViewController" bundle:[NSBundle mainBundle] detailsDict:dict];
                [self.navigationController pushViewController:activityDetailVC animated:YES];
                }
                break;
            default:
                break;
        }
    }
    
    //[self.tabBarController setSelectedIndex:3];
}

@end
