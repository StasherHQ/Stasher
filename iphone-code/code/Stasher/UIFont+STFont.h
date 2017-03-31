//
//  UIFont+STFont.h
//  Stasher
//
//  Created by bhushan on 10/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (STFont)
{

}

+ (UIFont*)FontGothamRoundedWithSize:(CGFloat)size;
+ (UIFont*)FontGothamRoundedBookWithSize:(CGFloat)size;
+ (UIFont*)FontGothamRoundedBoldWithSize:(CGFloat)size;
+ (UIFont*)FontGothamRoundedMediumWithSize:(CGFloat)size;
+ (UIFont*)FontForHeader;
+ (UIFont*)FontForTextFields;
+ (UIFont*)FontForButtonsWithSize:(CGFloat)size;
+ (UIFont*)FontForHeaderNoBold;
+ (UIFont*)FontForGothamLightItalic:(CGFloat)size;
+ (UIFont*)FontForAddMissionTitles:(CGFloat)size;
@end
