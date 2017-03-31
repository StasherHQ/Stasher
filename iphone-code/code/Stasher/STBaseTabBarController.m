//
//  STBaseTabBarController.m
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STBaseTabBarController.h"
#import "STEntryViewController.h"
@interface STBaseTabBarController ()

@end

@implementation STBaseTabBarController

- (instancetype)init {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self = [storyboard instantiateViewControllerWithIdentifier:@"STBaseTabBarController"];
    if (self) {
        //Do initializations here...
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0) {
        [[[self.viewControllers objectAtIndex:0] tabBarItem] setBadgeValue:[NSString stringWithFormat:@"%d",(int)[UIApplication sharedApplication].applicationIconBadgeNumber]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont FontGothamRoundedBoldWithSize:7.0f] }
                                             forState:UIControlStateNormal];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [self setSelectedIndex:2];
    self.delegate = self;
    [[STLogInManager sharedInstance] setDelegate:self];
    
    // set the bar background color
    [[UITabBar appearance] setBackgroundImage:[self imageFromColor:[UIColor colorWithRed:140.0f/255.0 green:140.0f/255.0 blue:140.0f/255.0 alpha:1] forSize:CGSizeMake(self.view.frame.size.width, 49) withCornerRadius:0]];
    // set the selected icon color
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    // remove the shadow
    [[UITabBar appearance] setShadowImage:nil];
    
    // Set the dark color to selected tab (the dimmed background)
    if(IS_STANDARD_IPHONE_6)
        [[UITabBar appearance] setSelectionIndicatorImage:[self imageFromColor:[UIColor colorWithRed:255.0f/255.0 green:54.0f/255.0 blue:34.0f/255.0 alpha:1] forSize:CGSizeMake(76, 49) withCornerRadius:0]];
    else if (IS_STANDARD_IPHONE_6_PLUS)
        [[UITabBar appearance] setSelectionIndicatorImage:[self imageFromColor:[UIColor colorWithRed:255.0f/255.0 green:54.0f/255.0 blue:34.0f/255.0 alpha:1] forSize:CGSizeMake(78, 49) withCornerRadius:0]];
    else
        [[UITabBar appearance] setSelectionIndicatorImage:[self imageFromColor:[UIColor colorWithRed:255.0f/255.0 green:54.0f/255.0 blue:34.0f/255.0 alpha:1] forSize:CGSizeMake(64, 49) withCornerRadius:0]];
    
    for (UITabBarItem *tbi in self.tabBar.items) {
        tbi.image = [tbi.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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

- (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{    
    if ([[STLogInManager sharedInstance] isUserLoggedIn]) {
        return TRUE;
    }
    return FALSE;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
     NSLog(@"selected tab index %lu",(unsigned long)tabBarController.selectedIndex);
    if (tabBarController.selectedIndex == 0) {
        [[[self.viewControllers objectAtIndex:0] tabBarItem] setBadgeValue:nil];
    }
}

#pragma mark ----- LogInManager Delegate
- (void)userLoggedOutSuccessfully
{
    [self presentStasherEntry];
    /*
    [UIAlertView showWithTitle:@""
                       message:@"You are logged out of Stasher!"
             cancelButtonTitle:@"OK"
             otherButtonTitles:nil
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                          }
                      }];
     */
}

- (void)presentStasherEntry
{
    STEntryViewController *stEntryVC = [[STEntryViewController alloc] init];
    [self.navigationController pushViewController:stEntryVC animated:YES];
}


@end
