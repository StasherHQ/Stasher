//
//  STBearPopUpViewController.m
//  Stasher
//
//  Created by Bhushan on 25/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import "STBearPopUpViewController.h"

@interface STBearPopUpViewController ()

@end

@implementation STBearPopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.rectangularView.clipsToBounds = YES;
    self.rectangularView.layer.cornerRadius = 10.0f;
    self.rectangularView.layer.borderColor=[UIColor clearColor].CGColor;
    self.rectangularView.layer.borderWidth=2.0f;
    [self.buttonPopUp.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.buttonLater.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    [self.buttonSetUp.titleLabel setFont:[UIFont FontForButtonsWithSize:11.0f]];
    
    [self.labelPopUpText setFont:[UIFont FontGothamRoundedBookWithSize:11.0f]];
    [self.labelPopUpText setTextColor:[UIColor stasherTextColor]];
    NSArray *imageNames = @[@"Bear1.png", @"Bear2.png", @"Bear3.png", @"Bear4.png",
                            @"Bear5.png", @"Bear6.png", @"Bear7.png", @"Bear8.png",
                            @"Bear9.png", @"Bear10.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    self.imgViewBear.animationImages = images;
    self.imgViewBear.animationDuration = kBearAnimationDuration;
    [self.imgViewBear startAnimating];
    [self.rectangularView setBackgroundColor:[UIColor stasherPopUpBGColor]];
    [self.buttonPopUp setHidden:NO];
    [self.buttonLater setHidden:YES];
    [self.buttonSetUp setHidden:YES];
    if (self.BearPopUpKind == ADDPARENTBEARPOPUP) {
        [self.buttonPopUp setTitle:@"ADD PARENT" forState:UIControlStateNormal];
        [self.labelPopUpText setText:@"To use Stasher, You need to add a parent."];
    }else if (self.BearPopUpKind == THANKSFORADDINGPARENTBEARPOPUP){
        [self.buttonPopUp setTitle:@"Done, Let’s go" forState:UIControlStateNormal];
        [self.labelPopUpText setText:@"Thanks for adding a parent!"];
    }else if (self.BearPopUpKind == ADDCHILDBEARPOPUP){
        [self.buttonPopUp setTitle:@"ADD CHILD" forState:UIControlStateNormal];
        [self.labelPopUpText setText:@"Let's start by addding a child."];
    }else if (self.BearPopUpKind == THANKSFORADDINGACHILDBEARPOPUP){
        [self.buttonPopUp setHidden:YES];
        [self.buttonLater setHidden:NO];
        [self.buttonSetUp setHidden:NO];
        [self.labelPopUpText setText:@"Thanks for adding a child, to use Stasher you have to set up your Bank Details."];
    }else if (self.BearPopUpKind == BANKACCOUNTLATERBEARPOPUP){
        [self.buttonPopUp setTitle:@"OK" forState:UIControlStateNormal];
        [self.labelPopUpText setText:@"No that's OK, we can do it later."];
    }else if (self.BearPopUpKind == BANKACCOUNTDONEBEARPOPUP){
        [self.buttonPopUp setTitle:@"OK" forState:UIControlStateNormal];
        [self.labelPopUpText setText:@"Cool, we never share this information to anyone."];
    }else if (self.BearPopUpKind == THANKSFORADDINGACHILDNOBANKBEARPOPUP){
        [self.buttonPopUp setTitle:@"OK" forState:UIControlStateNormal];
        [self.labelPopUpText setText:@"Thanks for adding a child."];
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

- (IBAction)popUpGreenButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(bearPopUpButtonPressedWithPopUpKind:)]) {
        [self.delegate bearPopUpButtonPressedWithPopUpKind:self.BearPopUpKind];
    }
}

- (IBAction)laterButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(bearPopUpLaterButtonPressed)]) {
        [self.delegate bearPopUpLaterButtonPressed];
    }
}

- (IBAction)setUpButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(bearPopUpSetUpButtonPressed)]) {
        [self.delegate bearPopUpSetUpButtonPressed];
    }
}


@end
