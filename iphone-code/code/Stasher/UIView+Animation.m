//
//  UIView+Animation.m
//  Stasher
//
//  Created by bhushan on 12/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) addSubview:(UIView *)view withAnimation:(BOOL)shouldAnimate
{
    [self addSubview:view];
    if (shouldAnimate) {
        [view setAlpha:0.0f];
        [UIView animateWithDuration:kAddSubviewAnimationDuration animations:^{
            [view setAlpha:1.0f];
        }];
    }
}

- (void) removeFromSuperviewwithAnimation:(BOOL)shouldAnimate
{
    if (shouldAnimate) {
        [self setAlpha:1.0f];
        [UIView animateWithDuration:kRemoveSubviewAnimationDuration animations:^{
            [self setAlpha:0.0f];
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
            }
        }];
    }
    else{
        
        [self removeFromSuperview];
    }
}

-(void)setHiddenAnimated:(BOOL)hide
{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
         if (hide)
             self.alpha=0;
         else
         {
             self.hidden= NO;
             self.alpha=1;
         }
     }
                     completion:^(BOOL b)
     {
         if (hide)
             self.hidden= YES;
     }
     ];
}

- (void) addPopUpOnKeyWindow
{
    [self setFrame:[[[UIApplication sharedApplication] keyWindow] frame]];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self withAnimation:YES];
}

- (void) removePopUpOnKeyWindow
{
    [self removeFromSuperviewwithAnimation:YES];
}

@end
