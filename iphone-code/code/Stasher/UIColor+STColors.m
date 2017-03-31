//
//  UIColor+STColors.m
//  Stasher
//
//  Created by bhushan on 08/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "UIColor+STColors.h"

@implementation UIColor (STColors)

+ (UIColor *) colorFromHexString:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+(NSString *)hexValuesFromUIColor:(UIColor *)color {
    
    if (!color) {
        return nil;
    }
    
    if (color == [UIColor whiteColor]) {
        // Special case, as white doesn't fall into the RGB color space
        return @"ffffff";
    }
    
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;
    
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    int redDec = (int)(red * 255);
    int greenDec = (int)(green * 255);
    int blueDec = (int)(blue * 255);
    
    NSString *returnString = [NSString stringWithFormat:@"%02x%02x%02x", (unsigned int)redDec, (unsigned int)greenDec, (unsigned int)blueDec];
    
    return returnString;
}


+(UIColor *)stasherTextColor
{
    return [UIColor colorWithRed:52.0f/255 green:52.0f/255 blue:52.0f/255 alpha:1.0f];
}

+(UIColor *)stasherTextFieldPlaceHolderColor
{
    return [UIColor colorWithRed:125.0f/255 green:125.0f/255 blue:125.0f/255 alpha:1.0f];
}

+(UIColor *)stasherPopUpBGColor
{
    return [UIColor colorWithRed:230.0f/255 green:230.0f/255 blue:230.0f/255 alpha:1.0f];
}

+(UIColor *)stasherAccountTableRowTextColor
{
    //return [UIColor colorWithRed:231.0f/255 green:230.0f/255 blue:231.0f/255 alpha:1.0f];
    return [UIColor colorWithRed:125.0f/255 green:125.0f/255 blue:125.0f/255 alpha:1.0f];
}

+ (UIColor *)stasherMissionDueProgressColor
{
    return [UIColor colorWithRed:245.0f/255.0f green:204.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
}

@end
