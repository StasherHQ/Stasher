//
//  STChangePasswordViewController.h
//  Stasher
//
//  Created by bhushan on 19/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangePasswordDelegate <NSObject>

@optional

- (void)passwordHasBeenChanged;

@end

@interface STChangePasswordViewController : UIViewController <STSharedCustomsDelegate>
{
    BOABHttpReq *httpReq;
}
@property (weak) id <ChangePasswordDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *changPasswordParamDictionary;
@property (nonatomic, strong) IBOutlet UIButton *savePasswordChangeButton;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldOldPassword;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldNewPassword;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldConfirmPassword;;
@property (nonatomic, strong) IBOutlet UILabel *headerlabel;
@property (nonatomic, strong) IBOutlet UIButton *buttonSave;
@end
