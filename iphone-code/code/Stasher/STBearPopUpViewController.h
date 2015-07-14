//
//  STBearPopUpViewController.h
//  Stasher
//
//  Created by Bhushan on 25/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BearPopUpDelegate <NSObject>

@optional

- (void)bearPopUpButtonPressedWithPopUpKind:(BearPopUpType)bearPopUpKind;
- (void)bearPopUpLaterButtonPressed;
- (void)bearPopUpSetUpButtonPressed;

@end

@interface STBearPopUpViewController : UIViewController
{

}

@property (weak) id <BearPopUpDelegate> delegate;
@property (nonatomic, strong)IBOutlet UIImageView *imgViewTransparentBG;
@property (nonatomic, strong)IBOutlet UIImageView *imgViewBear;
@property (nonatomic, strong)IBOutlet UIView *rectangularView;
@property (nonatomic, strong)IBOutlet UILabel *labelPopUpText;
@property (nonatomic, strong)IBOutlet UIButton *buttonPopUp;
@property (nonatomic, strong)IBOutlet UIButton *buttonLater;
@property (nonatomic, strong)IBOutlet UIButton *buttonSetUp;
@property (nonatomic, assign) BearPopUpType BearPopUpKind;

@end
