//
//  STLogInViewController.h
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STForgotPasswordViewController.h"

@interface STLogInViewController : UIViewController <ForgotPasswordDelegate,STSharedCustomsDelegate,LogInManagerDelegate>
{
    BOABHttpReq *httpReq;
    STForgotPasswordViewController *forgotPasswordVC;
}

@property (nonatomic, strong) IBOutlet UIButton *logInButton;
@property (nonatomic, strong) IBOutlet UIButton *forgotPasswordButton;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldUsernameId;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldPassword;
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UIButton *logInViaFacebooButtonk;
@end
