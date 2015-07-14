//
//  STActivityIndicatorView.h
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STActivityBGViewController.h"

@interface STActivityIndicatorView : UIView
{
    STActivityBGViewController *bgVC;
}
//default is 1.0f
@property (nonatomic, assign) CGFloat lineWidth;

//default is [UIColor lightGrayColor]
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, readonly) BOOL isAnimating;

//use this to init
- (id)initWithFrame:(CGRect)frame;

- (id)initWithDefaultSizeandSuperView:(UIView*)thisSuperView;

- (void)startAnimation;
- (void)stopAnimation;
@end
