//
//  ViewController.m
//  Stasher
//
//  Created by bhushan on 10/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "ViewController.h"
#import "STEntryViewController.h"
#import "STBaseTabBarController.h"
#import "STLogInManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor colorFromHexString:@"#3ab1f6"]];
    [self performSelector:@selector(setUpTutorialsScrollView) withObject:nil afterDelay:0.1];
    [self.pageControl setNumberOfPages:5];
    [self.nextButton.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    if ([[STLogInManager sharedInstance] isUserLoggedIn]) {
        [self presentBaseTabScreen];
    }
    else{
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}

#pragma mark ---------- Custom Methods

- (void)presentStasherEntry
{
    STEntryViewController *stEntryVC = [[STEntryViewController alloc] init];
    [self.navigationController pushViewController:stEntryVC animated:YES];
}

- (void)presentBaseTabScreen
{
    STBaseTabBarController *baseTabVC = [[STBaseTabBarController alloc] init];
    [self.navigationController pushViewController:baseTabVC animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUpTutorialsScrollView
{
    
    CGRect tutViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.tutorialsScrollview.frame.size.height);
    for (int c = 1; c < 6; c++) {
        UIView *tutView = [[UIView alloc] initWithFrame:tutViewFrame];
        [tutView setBackgroundColor:[UIColor clearColor]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 180.0f, 40.0f)];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont FontGothamRoundedBoldWithSize:12.0f]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setNumberOfLines:0];
        [label setTextAlignment:NSTextAlignmentCenter];
        
        UIImageView *tutImageView;
        CGRect tutImgRect;
         switch (c) {
            case 1:
                [label setText:[NSString stringWithFormat:@"%@",@"Ditch The Piggy Bank. Upgrade to Stasher."]];
                tutImgRect = CGRectMake(0, 0, 158,225);
                 
                 if (isiPhone4s) {
                     tutImageView = [[UIImageView alloc] initWithFrame:tutImgRect];
                     [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2, 20.0f, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, 200,label.frame.size.width, label.frame.size.height)];
                 }
                 else{
                     tutImageView = [[UIImageView alloc] initWithFrame:tutImgRect];
                     if (IS_STANDARD_IPHONE_6) {
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,62, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }else if (IS_STANDARD_IPHONE_6_PLUS) {
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,86, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }else{
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,40, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }
                 }
                 
                [tutImageView setImage:[UIImage imageNamed:@"tut_page01"]];
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
                tutImgRect = CGRectMake(0, 0, 141,230);
                 
                 if (isiPhone4s) {
                     tutImageView = [[UIImageView alloc] initWithFrame:tutImgRect];
                     [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2, 20.0f, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, 200,label.frame.size.width, label.frame.size.height)];
                 }
                 else{
                     tutImageView = [[UIImageView alloc] initWithFrame:tutImgRect];
                     if (IS_STANDARD_IPHONE_6) {
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,62, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }else if (IS_STANDARD_IPHONE_6_PLUS) {
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,86, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }else{
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,40, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }
                 }
                 
                [tutImageView setImage:[UIImage imageNamed:@"tut_page02"]];
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
                [label setText:[NSString stringWithFormat:@"%@",@"Parents transfer money securely to kids’ savings accounts using 128-bit encryption technology"]];
                tutImgRect = CGRectMake(0, 0, 256,214);
                 
                 if (isiPhone4s) {
                     tutImageView = [[UIImageView alloc] initWithFrame:tutImgRect];
                     [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2, 20.0f, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, 200,label.frame.size.width, label.frame.size.height)];
                 }
                 else{
                     tutImageView = [[UIImageView alloc] initWithFrame:tutImgRect];
                     if (IS_STANDARD_IPHONE_6) {
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,62, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }else if (IS_STANDARD_IPHONE_6_PLUS) {
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,86, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }else{
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,40, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }
                 }
                 
                [tutImageView setImage:[UIImage imageNamed:@"tut_page03"]];
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
                tutImgRect = CGRectMake(0, 0, 247,207);
                 
                 if (isiPhone4s) {
                     tutImageView = [[UIImageView alloc] initWithFrame:tutImgRect];
                     [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2, 20.0f, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, 200,label.frame.size.width, label.frame.size.height)];
                 }
                 else{
                     tutImageView = [[UIImageView alloc] initWithFrame:tutImgRect];
                     if (IS_STANDARD_IPHONE_6) {
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,62, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }else if (IS_STANDARD_IPHONE_6_PLUS) {
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,86, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }else{
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,40, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }
                 }
                 
                [tutImageView setImage:[UIImage imageNamed:@"tut_page04"]];
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
            case 5:
                [label setText:[NSString stringWithFormat:@"%@",@"Got it? Cool. Go ahead and register now."]];
                tutImgRect = CGRectMake(0, 0, 193,238);
                 
                 if (isiPhone4s) {
                     tutImageView = [[UIImageView alloc] initWithFrame:tutImgRect];
                     [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2, 20.0f, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     [label setFrame:CGRectMake(tutImageView.center.x - label.frame.size.width/2, 200,label.frame.size.width, label.frame.size.height)];
                 }
                 else{
                     tutImageView = [[UIImageView alloc] initWithFrame:tutImgRect];
                     if (IS_STANDARD_IPHONE_6) {
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,62, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }else if (IS_STANDARD_IPHONE_6_PLUS) {
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,86, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }else{
                         [tutImageView setFrame:CGRectMake(tutViewFrame.size.width/2 - tutImageView.frame.size.width/2,40, tutImageView.frame.size.width, tutImageView.frame.size.height)];
                     }
                 }
                 
                [tutImageView setImage:[UIImage imageNamed:@"tut_page05"]];
                if (IS_STANDARD_IPHONE_6) {
                    [label setFrame:CGRectMake(0,0, 200.0f, 80.0f)];
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
        
        [tutView addSubview:tutImageView];
        
        CGRect stasherLogotextImgViewFrame = CGRectMake(0, 0, 175, 30);
        UIImageView *stasherLogoImgView = [[UIImageView alloc] initWithFrame:stasherLogotextImgViewFrame];
        [stasherLogoImgView setImage:[UIImage imageNamed:@"stasher_logo_text"]];
        [stasherLogoImgView setCenter:CGPointMake(tutImageView.center.x, tutImageView.frame.origin.y + tutImageView.frame.size.height + 50)];
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
    [self.pageControl setNumberOfPages:5];
    
}


#pragma mark ----- Scrollview Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentIndex = (int) (self.tutorialsScrollview.contentOffset.x / self.tutorialsScrollview.frame.size.width) ;
    [self.pageControl setCurrentPage:currentIndex];
    
   if (self.pageControl.currentPage < 4)
    [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
  else
     [self.nextButton setTitle:@"OK" forState:UIControlStateNormal];
}

- (IBAction)nextButtonPressed:(id)sender
{
    [self performSelector:@selector(nextButtonMoveScroll) withObject:nil afterDelay:0.1];
}

- (void)nextButtonMoveScroll
{
    if (self.pageControl.currentPage == 3) {
        [self.nextButton setTitle:@"OK" forState:UIControlStateNormal];
    }
    if (self.pageControl.currentPage < 4) {
        [self.tutorialsScrollview setContentOffset:CGPointMake(self.tutorialsScrollview.contentOffset.x+self.tutorialsScrollview.frame.size.width, 0.0f) animated:YES];
    }
    else{
        //[self.tutorialsScrollview setContentOffset:CGPointMake(0.0f, 0.0f) animated:NO];
        [self presentStasherEntry];
    }
}


@end
