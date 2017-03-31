//
//  UIView+Animation.h
//  Stasher
//
//  Created by bhushan on 12/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (Animation)
{
    
}

- (void) addSubview:(UIView *)view withAnimation:(BOOL)shouldAnimate;
- (void) removeFromSuperviewwithAnimation:(BOOL)shouldAnimate;
- (void) setHiddenAnimated:(BOOL)hide;
- (void) addPopUpOnKeyWindow;
- (void) removePopUpOnKeyWindow;
@end


