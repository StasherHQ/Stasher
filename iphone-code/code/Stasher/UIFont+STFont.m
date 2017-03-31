//
//  UIFont+STFont.m
//  Stasher
//
//  Created by bhushan on 10/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "UIFont+STFont.h"

@implementation UIFont (STFont)

/****************************************************
 Family name: Gotham Rounded
 Font name: GothamRounded-BookItalic
 Font name: GothamRounded-MediumItalic
 Font name: GothamRounded-BoldItalic
 Font name: GothamRounded-Light
 Font name: GothamRounded-Medium
 Font name: GothamRounded-Bold
 Font name: GothamRounded-LightItalic
 Font name: GothamRounded-Book
 ***************************************************/

+ (UIFont*)FontGothamRoundedWithSize:(CGFloat)size
{
    if (IS_STANDARD_IPHONE_6) {
        return [UIFont fontWithName:@"Gotham Rounded" size:size+4];
    }
    return [UIFont fontWithName:@"Gotham Rounded" size:size+2];
}

+ (UIFont*)FontGothamRoundedBookWithSize:(CGFloat)size
{
    if (IS_STANDARD_IPHONE_6) {
        return [UIFont fontWithName:@"GothamRounded-Book" size:size+4];
    }
    return [UIFont fontWithName:@"GothamRounded-Book" size:size+2];
    
}

+ (UIFont*)FontGothamRoundedBoldWithSize:(CGFloat)size
{
    if (IS_STANDARD_IPHONE_6) {
        return [UIFont fontWithName:@"GothamRounded-Bold" size:size+4];
    }
    return [UIFont fontWithName:@"GothamRounded-Bold" size:size+2];
}

+ (UIFont*)FontGothamRoundedMediumWithSize:(CGFloat)size
{
    if (IS_STANDARD_IPHONE_6) {
        return [UIFont fontWithName:@"GothamRounded-Medium" size:size+4];
    }
    return [UIFont fontWithName:@"GothamRounded-Medium" size:size+2];
}

+ (UIFont*)FontForHeader
{
    return [UIFont fontWithName:@"GothamRounded-Medium" size:18.0f];
}

+ (UIFont*)FontForHeaderNoBold
{
    return [UIFont fontWithName:@"GothamRounded-Book" size:18.0f];
}

+ (UIFont*)FontForTextFields
{
    if (IS_STANDARD_IPHONE_6) {
        return [UIFont fontWithName:@"GothamRounded-Medium" size:10.0f+4.0f];
    }
    return [UIFont fontWithName:@"GothamRounded-Medium" size:10.0f+2.0f];
}

+ (UIFont*)FontForButtonsWithSize:(CGFloat)size
{
    if (IS_STANDARD_IPHONE_6) {
        return [UIFont fontWithName:@"GothamRounded-Medium" size:size+4];
    }
    return [UIFont fontWithName:@"GothamRounded-Medium" size:size+2];
}

+ (UIFont*)FontForGothamLightItalic:(CGFloat)size
{
    if (IS_STANDARD_IPHONE_6) {
        return [UIFont fontWithName:@"GothamRounded-LightItalic" size:size+4];
    }
    return [UIFont fontWithName:@"GothamRounded-LightItalic" size:size+2];
}

+ (UIFont*)FontForAddMissionTitles:(CGFloat)size
{
    if (IS_STANDARD_IPHONE_6) {
        return [UIFont fontWithName:@"GothamRounded-Book" size:size+4];
    }
    return [UIFont fontWithName:@"GothamRounded-Book" size:size+2];
}

@end
