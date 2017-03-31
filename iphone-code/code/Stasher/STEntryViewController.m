//
//  STEntryViewController.m
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STEntryViewController.h"
#import "STBaseTabBarController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "STRegisterStepThreeViewController.h"
@interface STEntryViewController ()

@end

@implementation STEntryViewController


- (instancetype)init {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self = [storyboard instantiateViewControllerWithIdentifier:@"STEntryViewController"];
    if (self) {
        //Do initializations here...
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tabBarController.tabBar setHidden:YES];
    [self.userTypeContainerView setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorFromHexString:@"#3ab1f6"]];
    if (IS_STANDARD_IPHONE_6) {
        [self.registerButton.titleLabel setFont:[UIFont FontForButtonsWithSize:8.0f]];
    }else{
        [self.registerButton.titleLabel setFont:[UIFont FontForButtonsWithSize:10.0f]];
    }
    if (IS_STANDARD_IPHONE_6) {
        [self.registerWithFacebookButton.titleLabel setFont:[UIFont FontForButtonsWithSize:8.0f]];
    }else{
         [self.registerWithFacebookButton.titleLabel setFont:[UIFont FontForButtonsWithSize:10.0f]];
    }
    if (IS_STANDARD_IPHONE_6) {
        [self.logInButton.titleLabel setFont:[UIFont FontForButtonsWithSize:9.0f]];
    }else{
        [self.logInButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    }
    
    [self.orLabel setTextColor:[UIColor colorWithRed:248.0f/255 green:204.0f/255 blue:51.0f/255 alpha:1.0]];
    [self.orLabel setFont:[UIFont FontGothamRoundedBoldWithSize:9.0f]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setHidden:YES];
    
    
    self.userTypeContainerView.clipsToBounds = YES;
    self.userTypeContainerView.layer.cornerRadius = 10.0f;
    self.userTypeContainerView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.userTypeContainerView.layer.borderWidth=1.0f;
    
    [self.userTypeContainerView setHiddenAnimated:YES];
    [self.overlayView setHiddenAnimated:YES];
    [self.labelFBAreYouParent setFont:[UIFont FontGothamRoundedMediumWithSize:9.5f]];
    [self.buttonFBPopUpOk.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.buttonFBPopUpCancel.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    
    [self.customSwitchYesButton.titleLabel setFont:[UIFont FontForButtonsWithSize:6.5f]];
    [self.customSwitchNoButton.titleLabel setFont:[UIFont FontForButtonsWithSize:6.5f]];
    
    [self performSelector:@selector(setUpTutorialsScrollView) withObject:nil afterDelay:0.1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    CGRect userTypeSwitchFrame = self.userTypeSwitch.frame;
    userTypeSwitchFrame.origin.x = self.view.frame.size.width - self.parentCustomSwitchView.frame.size.width - 8.0f;
    userTypeSwitchFrame.size.width = self.parentCustomSwitchView.frame.size.width;
    userTypeSwitchFrame.size.height = self.parentCustomSwitchView.frame.size.height;
    [self.parentCustomSwitchView setFrame:userTypeSwitchFrame];
    [self.userTypeContainerView addSubview:self.parentCustomSwitchView];
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

#pragma mark ----- Actions

- (IBAction)custoSwitchFBOverlayButtonPressed:(id)sender
{
    if ([self.userTypeSwitch isOn]) {
        [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
            [self.imgViewYesCircle setCenter:CGPointMake(13, self.imgViewYesCircle.center.y)];
            [self.userTypeSwitch setOn:NO];
            [self userTypeSwitchValueChanged:self.userTypeSwitch];
            [self.customSwitchYesButton setHiddenAnimated:YES];
            [self.customSwitchNoButton setHiddenAnimated:NO];
            [self.imgViewYesCircle setImage:[UIImage imageNamed:@"toggle_graycircle"]];
            [self.imgViewFBParentSwitchBG setImage:[UIImage imageNamed:@"toggle_graybg"]];
        }];
    }else{
        [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
            [self.imgViewYesCircle setCenter:CGPointMake(self.customSwitchFBParent.frame.size.width-13, self.imgViewYesCircle.center.y)];
            [self.userTypeSwitch setOn:YES];
            [self userTypeSwitchValueChanged:self.userTypeSwitch];
            [self.customSwitchYesButton setHiddenAnimated:NO];
            [self.customSwitchNoButton setHiddenAnimated:YES];
            [self.imgViewYesCircle setImage:[UIImage imageNamed:@"toggle_yellowcircle"]];
            [self.imgViewFBParentSwitchBG setImage:[UIImage imageNamed:@"toggle_greenBG"]];
            
        }];
    }
}


- (IBAction)registerButtonPressed:(id)sender
{
    STRegisterStepOneViewController *testVC = [[STRegisterStepOneViewController alloc] initWithNibName:@"STRegisterStepOneViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:testVC animated:YES];
}

- (IBAction)logInButtonPressed:(id)sender
{


}

- (IBAction)logInWithFacebookButtonPressed:(id)sender
{
    [self.userTypeContainerView setHiddenAnimated:NO];
    [self.overlayView setHiddenAnimated:NO];
    [[STUserIdentity sharedInstance] setUserIdentity:PARENTUSER];
}

- (IBAction)userTypeSwitchValueChanged:(id)sender
{
    UISwitch *thisSwitch = (UISwitch*)sender;
    if (thisSwitch) {
        if ([thisSwitch isOn]) {
            [[STUserIdentity sharedInstance] setUserIdentity:PARENTUSER];
        }
        else {
            [[STUserIdentity sharedInstance] setUserIdentity:CHILDUSER];
        }
    }
}

- (IBAction)userTypeContainerDoneButtonPressed:(id)sender
{
    [self.userTypeContainerView setHiddenAnimated:YES];
    [self.overlayView setHiddenAnimated:YES];
    [[STLogInManager sharedInstance] setDelegate:self];
    [[STLogInManager sharedInstance] openSessionWithAllowLoginUI:self];
}

- (IBAction)userTypeContainerCancelButtonPressed:(id)sender
{
    [self.userTypeContainerView setHidden:YES];
    [self.overlayView setHiddenAnimated:YES];
}

- (IBAction)customSwitchYesButtonPressed:(id)sender
{
    [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
        [self.imgViewGreenCustomSwitch setCenter:self.buttonSwitchYes.center];
        [self.userTypeSwitch setOn:YES];
        [self userTypeSwitchValueChanged:self.userTypeSwitch];
    }];
}

- (IBAction)customSwitchNoButtonPressed:(id)sender
{
    [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
        [self.imgViewGreenCustomSwitch setCenter:self.buttonSwitchNo.center];
        [self.userTypeSwitch setOn:NO];
        [self userTypeSwitchValueChanged:self.userTypeSwitch];
    }];
}

#pragma mark ----- Scrollview Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentIndex = (int) (self.tutorialsScrollview.contentOffset.x / self.tutorialsScrollview.frame.size.width) ;
    [self.pageControl setCurrentPage:currentIndex];
}

#pragma mark ----- custom methods

- (void) launchUserBaseTabsScreen
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STBaseTabBarController *baseTabBarController = [storyboard instantiateViewControllerWithIdentifier:@"STBaseTabBarController"];
    [self.navigationController pushViewController:baseTabBarController animated:YES];
}


- (void) setUpTutorialsScrollView
{
    //[self.pageControl setHidden:YES];
    
    CGRect tutViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.tutorialsScrollview.frame.size.height);
    for (int c = 1; c < 5; c++) {
        UIView *tutView = [[UIView alloc] initWithFrame:tutViewFrame];
        [tutView setBackgroundColor:[UIColor clearColor]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 180.0f, 40.0f)];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont FontGothamRoundedBoldWithSize:12.0f]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setNumberOfLines:0];
        [label setTextAlignment:NSTextAlignmentCenter];
        
                
        UIImageView *tutImageView;
        if (isiPhone4s) {
            tutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,175, 245)];
            [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2, 20.0f, tutImageView.frame.size.width, tutImageView.frame.size.height)];
             [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, 200,label.frame.size.width, label.frame.size.height)];
        }
        else{
            tutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,151, 196)];
            if (IS_STANDARD_IPHONE_6) {
                 [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,62, tutImageView.frame.size.width, tutImageView.frame.size.height)];
            }else if (IS_STANDARD_IPHONE_6_PLUS) {
                 [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,86, tutImageView.frame.size.width, tutImageView.frame.size.height)];
            }else{
                 [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,40, tutImageView.frame.size.width, tutImageView.frame.size.height)];
            }
        }
        
        switch (c) {
            case 1:
                [label setText:[NSString stringWithFormat:@"%@",@"Ditch The Piggy Bank. Upgrade to Stasher."]];
                
                if (IS_STANDARD_IPHONE_6) {
                    [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, tutView.frame.size.height -  2.5*label.frame.size.height,label.frame.size.width, label.frame.size.height)];
                    
                }else if (IS_STANDARD_IPHONE_6_PLUS) {
                    [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, tutView.frame.size.height - 3 * label.frame.size.height,label.frame.size.width, label.frame.size.height)];
                    
                }else{
                    [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, tutView.frame.size.height - 1.5 * label.frame.size.height,label.frame.size.width, label.frame.size.height)];
                    
                }
                break;
            case 2:
                [label setText:[NSString stringWithFormat:@"%@",@"Secret Agents complete missions to earn real cash from their commanders!"]];
                if (IS_STANDARD_IPHONE_6) {
                    [label setFrame:CGRectMake(0,0, 300.0f, 80.0f)];
                    [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, tutView.frame.size.height -  1.5*label.frame.size.height,label.frame.size.width, label.frame.size.height)];
                    
                }else if (IS_STANDARD_IPHONE_6_PLUS) {
                    [label setFrame:CGRectMake(0,0, 250.0f, 100.0f)];
                    [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, tutView.frame.size.height - 1.5 * label.frame.size.height,label.frame.size.width, label.frame.size.height)];
                    
                }else{
                    [label setFrame:CGRectMake(0,0, 250.0f, 80.0f)];
                    [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, tutView.frame.size.height - 1.05 * label.frame.size.height,label.frame.size.width, label.frame.size.height)];
                }
                break;
            case 3:
                [label setText:[NSString stringWithFormat:@"%@",@"Parents transfer money securely to kids saving account using Knox Payments 128-bit encryption technology"]];
                if (IS_STANDARD_IPHONE_6) {
                    [label setFrame:CGRectMake(0,0, 330.0f, 80.0f)];
                    [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, tutView.frame.size.height -  1.5*label.frame.size.height,label.frame.size.width, label.frame.size.height)];
                    
                }else if (IS_STANDARD_IPHONE_6_PLUS) {
                    [label setFrame:CGRectMake(0,0, 280.0f, 100.0f)];
                    [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, tutView.frame.size.height - 1.5 * label.frame.size.height,label.frame.size.width, label.frame.size.height)];
                    
                }else{
                    [label setFrame:CGRectMake(0,0, 250.0f, 80.0f)];
                    [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, tutView.frame.size.height - 1.05 * label.frame.size.height,label.frame.size.width, label.frame.size.height)];
                }
                break;
            case 4:
                [label setText:[NSString stringWithFormat:@"%@",@"Track savings from your mobile device on-the-go"]];
                if (IS_STANDARD_IPHONE_6) {
                    [label setFrame:CGRectMake(0,0, 300.0f, 80.0f)];
                    [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, tutView.frame.size.height -  1.5*label.frame.size.height,label.frame.size.width, label.frame.size.height)];
                    
                }else if (IS_STANDARD_IPHONE_6_PLUS) {
                    [label setFrame:CGRectMake(0,0, 250.0f, 100.0f)];
                    [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, tutView.frame.size.height - 1.5 * label.frame.size.height,label.frame.size.width, label.frame.size.height)];
                    
                }else{
                    [label setFrame:CGRectMake(0,0, 250.0f, 80.0f)];
                    [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, tutView.frame.size.height - 1.05 * label.frame.size.height,label.frame.size.width, label.frame.size.height)];
                }
                break;
            default:
                break;
        }
        /*
        //[tutImageView setImage:[UIImage imageNamed:@"Bear1"]];
        NSArray *imageNames = @[@"Bear1.png", @"Bear2.png", @"Bear3.png", @"Bear4.png",
                                @"Bear5.png", @"Bear6.png", @"Bear7.png", @"Bear8.png",
                                @"Bear9.png", @"Bear10.png"];
        
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (int i = 0; i < imageNames.count; i++) {
            [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
        }
        tutImageView.animationImages = images;
        tutImageView.animationDuration = kBearAnimationDuration;
         */
        CGRect tutImgRect = tutImageView.frame;
        switch (c) {
            case 1:
                tutImgRect = CGRectMake(tutImageView.frame.origin.x, tutImageView.frame.origin.y, 158,225);
                if (isiPhone4s) {
                }
                else{
                    if (IS_STANDARD_IPHONE_6) {
                    }else if (IS_STANDARD_IPHONE_6_PLUS) {
                    }else{
                        tutImgRect = CGRectMake(tutImageView.frame.origin.x, tutImageView.frame.origin.y, 130,200);
                    }
                }
                [tutImageView setImage:[UIImage imageNamed:@"tut_page01"]];
                break;
            case 2:
                tutImgRect = CGRectMake(tutImageView.frame.origin.x, tutImageView.frame.origin.y, 121,230);
                [tutImageView setImage:[UIImage imageNamed:@"tut_page02"]];
                if (isiPhone4s) {
                }
                else{
                    if (IS_STANDARD_IPHONE_6) {
                    }else if (IS_STANDARD_IPHONE_6_PLUS) {
                    }else{
                        tutImgRect = CGRectMake(tutImageView.frame.origin.x, tutImageView.frame.origin.y, 100,200);
                    }
                }

                break;
            case 3:
                tutImgRect = CGRectMake(tutImageView.frame.origin.x, tutImageView.frame.origin.y, 256,214);
                [tutImageView setImage:[UIImage imageNamed:@"tut_page03"]];
                if (isiPhone4s) {
                }
                else{
                    if (IS_STANDARD_IPHONE_6) {
                    }else if (IS_STANDARD_IPHONE_6_PLUS) {
                    }else{
                        tutImgRect = CGRectMake(tutImageView.frame.origin.x, tutImageView.frame.origin.y, 230,190);
                    }
                }
                break;
            case 4:
                tutImgRect = CGRectMake(tutImageView.frame.origin.x, tutImageView.frame.origin.y, 247,207);
                [tutImageView setImage:[UIImage imageNamed:@"tut_page04"]];
                if (isiPhone4s) {
                }
                else{
                    if (IS_STANDARD_IPHONE_6) {
                    }else if (IS_STANDARD_IPHONE_6_PLUS) {
                    }else{
                        tutImgRect = CGRectMake(tutImageView.frame.origin.x, tutImageView.frame.origin.y, 220,180);
                    }
                }
                break;
            default:
                break;
        }
        
        [tutImageView setFrame:tutImgRect];
        [tutView addSubview:tutImageView];
        //[tutImageView startAnimating];
        
        CGRect stasherLogotextImgViewFrame = CGRectMake(0, 0, 175, 30);
        UIImageView *stasherLogoImgView = [[UIImageView alloc] initWithFrame:stasherLogotextImgViewFrame];
        [stasherLogoImgView setImage:[UIImage imageNamed:@"stasher_logo_text"]];
        [stasherLogoImgView setCenter:CGPointMake(self.view.center.x, tutImageView.frame.origin.y - 20)];
        [tutView addSubview:stasherLogoImgView];
        
        [tutView addSubview:label];
        [self.tutorialsScrollview addSubview:tutView];
        tutViewFrame.origin.x += tutView.frame.size.width;
        [label setCenter:CGPointMake(self.tutorialsScrollview.center.x, label.center.y)];
        [tutImageView setCenter:CGPointMake(self.tutorialsScrollview.center.x, tutImageView.center.y)];
        
    }
    CGSize contentSize = self.tutorialsScrollview.frame.size;
    contentSize.width = tutViewFrame.origin.x;
    contentSize.height = self.tutorialsScrollview.frame.size.height;
    [self.tutorialsScrollview setContentSize:contentSize];
    [self.pageControl setNumberOfPages:4];
    
}


- (void) launchStepThreeRegistration
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    STRegisterStepThreeViewController *registerStepthreeVC = [storyboard instantiateViewControllerWithIdentifier:@"RegisterStepThreeViewController"];
    [self.navigationController pushViewController:registerStepthreeVC animated:YES];
}

#pragma mark ----- LogInManagerDelegate

- (void)facebookLogInSuccessfulWithUserDictionary:(NSDictionary *)userInfoDict
{
    NSLog(@"facebooklogIn Dict %@",userInfoDict);
    
    if (userInfoDict != nil) {
        NSMutableDictionary* localUserInfoDict = [[NSMutableDictionary alloc] init];
        [localUserInfoDict setObject:[userInfoDict objectForKey:@"first_name"] forKey:kParamKeyFirstname];
         [localUserInfoDict setObject:[userInfoDict objectForKey:@"last_name"] forKey:kParamKeyLastname];
         [localUserInfoDict setObject:[userInfoDict objectForKey:@"gender"] forKey:kParamKeyGender];
        [localUserInfoDict setObject:[userInfoDict objectForKey:@"email"] forKey:kParamKeyEmail];
        //[localUserInfoDict setObject:[[userInfoDict objectForKey:@"location"] objectForKey:@"name"] forKey:kParamKeyCountry];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
        NSDate *theDate = [dateFormat dateFromString:[userInfoDict objectForKey:@"birthday"]];
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
        if ([dateFormat2 stringFromDate:theDate])
            [localUserInfoDict setObject:[dateFormat2 stringFromDate:theDate] forKey:kParamKeyDateOfBirth];
        if ([[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture",[userInfoDict objectForKey:@"id"]]]] base64EncodedStringWithOptions:0] != nil) {
            [localUserInfoDict setObject:[[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture",[userInfoDict objectForKey:@"id"]]]] base64EncodedStringWithOptions:0]  forKey:kParamKeyAvatar];
        }
        if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
            [localUserInfoDict setObject:[NSString stringWithFormat:@"%@",@"yes"] forKey:kParamKeyIsParent];
        }
        if ([[STUserIdentity sharedInstance] userIdentity] == CHILDUSER) {
            [localUserInfoDict setObject:[NSString stringWithFormat:@"%@",@"no"] forKey:kParamKeyIsParent];
        }
        if (httpReq) {
            httpReq.delegate = nil;
            httpReq = nil;
        }
        httpReq = [[BOABHttpReq alloc] initBoabReqWithDelegate:self shouldShowActivityIndicatorView:YES];
        [localUserInfoDict setObject:kAPIActionFaceBookRegister forKey:kParamKeyAction];
        [httpReq sendAsyncPostRequest:STASHER_BASE_URL params:localUserInfoDict json:YES];
    }
}

# pragma mark ----- BOABHttpReq Delegate

- (void)BOABHttpReqFinishedWithResponse:(NSData*)resonseData andConnection:(BOABURLConnection*)conn
{
    if (resonseData) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:resonseData options:kNilOptions error:nil];
        if (responseDictionary!=nil) {
            if ([responseDictionary objectForKey:@"success"] != nil) {
                if ([responseDictionary objectForKey:@"success"] ) {
                    if ([responseDictionary objectForKey:@"usedetails"] && [[responseDictionary objectForKey:@"usedetails"] isKindOfClass:[NSDictionary class]]) {
                        [[STUserIdentity sharedInstance] setUserInformationDictionary:[[responseDictionary objectForKey:@"usedetails"] mutableCopy]];
                        NSMutableDictionary *logInInfoDictionary = [[responseDictionary objectForKey:@"usedetails"] mutableCopy];
                        [logInInfoDictionary setObject:[NSNumber numberWithInt:1] forKey:kUserDefaultsIsUserLoggedIn];
                        [[STLogInManager sharedInstance] updateUserDefaultsInLogInManagerWithDictionary:logInInfoDictionary];
                    }
                    
                    [UIAlertView showWithTitle:@""
                                       message:[[responseDictionary objectForKey:@"success"] objectForKey:@"message"]
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          if (buttonIndex == [alertView cancelButtonIndex]) {
                                              if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
                                                  [self launchStepThreeRegistration];
                                              }
                                              else{
                                                  UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                  STBaseTabBarController *baseTabBarController = [storyboard instantiateViewControllerWithIdentifier:@"STBaseTabBarController"];
                                                  [self.navigationController pushViewController:baseTabBarController animated:YES];
                                              }
                                          }
                                      }];
                }
            }
            else if ([responseDictionary objectForKey:@"error"] != nil)
            {
                if ([responseDictionary objectForKey:@"error"]) {
                    [UIAlertView showWithTitle:@""
                                       message:[[responseDictionary objectForKey:@"error"] objectForKey:@"message"]
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil
                                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                          if (buttonIndex == [alertView cancelButtonIndex]) {
                                              [self.navigationController popViewControllerAnimated:YES];
                                          }
                                      }];
                }
            }
            else if ([responseDictionary objectForKey:@"usedetails"] && [[responseDictionary objectForKey:@"usedetails"] isKindOfClass:[NSDictionary class]]) {
                [[STUserIdentity sharedInstance] setUserInformationDictionary:[[responseDictionary objectForKey:@"usedetails"] mutableCopy]];
                NSMutableDictionary *logInInfoDictionary = [[responseDictionary objectForKey:@"usedetails"] mutableCopy];
                [logInInfoDictionary setObject:[NSNumber numberWithInt:1] forKey:kUserDefaultsIsUserLoggedIn];
                [[STLogInManager sharedInstance] updateUserDefaultsInLogInManagerWithDictionary:logInInfoDictionary];
                
                if ([[STUserIdentity sharedInstance] userIdentity] == PARENTUSER) {
                    [self launchStepThreeRegistration];
                }
                else{
                    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    STBaseTabBarController *baseTabBarController = [storyboard instantiateViewControllerWithIdentifier:@"STBaseTabBarController"];
                    [self.navigationController pushViewController:baseTabBarController animated:YES];
                }
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
