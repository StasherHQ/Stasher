//
//  NSString1.m
//  Stasher
//
//  Created by bhushan on 12/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL)validateNotEmpty
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    return ([[self stringByTrimmingCharactersInSet:characterSet] length] != 0);
}

//--------------------------------------------------------------
- (BOOL)validateMinimumLength:(NSInteger)length
{
    return ([self length] >= length);
}

//--------------------------------------------------------------
- (BOOL)validateMaximumLength:(NSInteger)length
{
    return ([self length] <= length);
}

//--------------------------------------------------------------
- (BOOL)validateMatchesConfirmation:(NSString *)confirmation
{
    return [self isEqualToString:confirmation];
}

//--------------------------------------------------------------
- (BOOL)validateInCharacterSet:(NSMutableCharacterSet *)characterSet
{
    return ([self rangeOfCharacterFromSet:[characterSet invertedSet]].location == NSNotFound);
}

//--------------------------------------------------------------
- (BOOL)validateAlpha
{
    return [self validateInCharacterSet:[NSMutableCharacterSet letterCharacterSet]];
}

//--------------------------------------------------------------
- (BOOL)validateAlphanumeric
{
    return [self validateInCharacterSet:[NSMutableCharacterSet alphanumericCharacterSet]];
}

//--------------------------------------------------------------
- (BOOL)validateNumeric
{
    return [self validateInCharacterSet:[NSMutableCharacterSet decimalDigitCharacterSet]];
}

//--------------------------------------------------------------
- (BOOL)validateAlphaSpace
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet letterCharacterSet];
    [characterSet addCharactersInString:@" "];
    return [self validateInCharacterSet:characterSet];
}

//--------------------------------------------------------------
- (BOOL)validateAlphanumericSpace
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [characterSet addCharactersInString:@" "];
    return [self validateInCharacterSet:characterSet];
}

- (BOOL)validateAlphanumericSpaceAndAt
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [characterSet addCharactersInString:@" "];
    [characterSet addCharactersInString:@"@"];
    return [self validateInCharacterSet:characterSet];
}


//--------------------------------------------------------------
// Alphanumeric characters, underscore (_), and period (.)
- (BOOL)validateUsername
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [characterSet addCharactersInString:@"'_."];
    return [self validateInCharacterSet:characterSet];
}

//--------------------------------------------------------------
// http://stackoverflow.com/questions/3139619/check-that-an-email-address-is-valid-on-ios
// http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
- (BOOL)validateEmail
{
    NSString *regex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate * regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regextest evaluateWithObject:self];
}

//--------------------------------------------------------------
- (BOOL)validatePhoneNumber
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet decimalDigitCharacterSet];
    [characterSet addCharactersInString:@"'-*+#,;. "];
    return [self validateInCharacterSet:characterSet];
}

@end
