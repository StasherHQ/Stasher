//
//  STTermsAndConditionsViewController.h
//  Stasher
//
//  Created by bhushan on 17/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TermsAndConditionsDelegate <NSObject>

@optional

- (void)acceptButtonPressed;
- (void)cancelButtonPressed;

@end

@interface STTermsAndConditionsViewController : UIViewController<BOABHttpReqDelegate>
{
    BOABHttpReq *httpReq;
}
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andIsThroughSettings:(BOOL)isSettingsCall andIsPrivacyPolicy:(BOOL)isPolicy orIsUserAgreement:(BOOL)isUserAgreement;
@property (weak) id <TermsAndConditionsDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIWebView *policyWebView;
@property (nonatomic, strong) IBOutlet UITextView *policyTextView;
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) IBOutlet UIButton *acceptButton;
@property (nonatomic, strong) IBOutlet UIButton *backButton;
@property (nonatomic,assign) BOOL isSettings;
@property (nonatomic,assign) BOOL isUserAgrrement;
@property (nonatomic,assign) BOOL isPrevacyPolicy;
@end
