//
//  STForgotPasswordViewController.h
//  Stasher
//
//  Created by bhushan on 14/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ForgotPasswordDelegate <NSObject>

@optional

- (void) sendPaswordToEmailButtonPressed ;
- (void) forgetpasswordCanceled;
@end

@interface STForgotPasswordViewController : UIViewController
{

}

@property (weak) id <ForgotPasswordDelegate> delegate;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldusernameMailId;
@property (nonatomic, strong) IBOutlet UIView *popUpContainerView;
@property (nonatomic, strong) IBOutlet UIButton *okButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@end
