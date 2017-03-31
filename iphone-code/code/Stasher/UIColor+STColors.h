//
//  UIColor+STColors.h
//  Stasher
//
//  Created by bhushan on 08/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (STColors)

+(UIColor *) colorFromHexString:(NSString *)hexString;
+(NSString *)hexValuesFromUIColor:(UIColor *)color;
+(UIColor *)stasherTextColor;
+(UIColor *)stasherTextFieldPlaceHolderColor;
+(UIColor *)stasherPopUpBGColor;
+(UIColor *)stasherAccountTableRowTextColor;
+ (UIColor *)stasherMissionDueProgressColor;

@end
