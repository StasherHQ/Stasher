//
//  NSString1.h
//  Stasher
//
//  Created by bhushan on 12/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Validation)

- (BOOL)validateNotEmpty;
- (BOOL)validateMinimumLength:(NSInteger)length;
- (BOOL)validateMaximumLength:(NSInteger)length;

- (BOOL)validateMatchesConfirmation:(NSString *)confirmation;
- (BOOL)validateInCharacterSet:(NSMutableCharacterSet *)characterSet;

- (BOOL)validateAlpha;
- (BOOL)validateAlphanumeric;
- (BOOL)validateNumeric;
- (BOOL)validateAlphaSpace;
- (BOOL)validateAlphanumericSpace;
- (BOOL)validateAlphanumericSpaceAndAt;

- (BOOL)validateUsername;
- (BOOL)validateEmail;
- (BOOL)validatePhoneNumber;


@end
