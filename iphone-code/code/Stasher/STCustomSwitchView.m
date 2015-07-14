//
//  STCustomSwitchView.m
//  Stasher
//
//  Created by bhushan on 21/01/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import "STCustomSwitchView.h"

@implementation STCustomSwitchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)buttonFirstPressed:(id)sender
{
    [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
        [self.imgViewGreen setCenter:self.buttonFirst.center];
    }];
}

- (IBAction)buttonSecondPressed:(id)sender
{
    
    [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
        [self.imgViewGreen setCenter:self.buttonSecond.center];
    }];
}


@end
