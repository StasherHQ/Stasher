//
//  STGraphView.h
//  Stasher
//
//  Created by bhushan on 01/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STGraphView : UIView
// Block definition for getting a label for a set index (use case: date, units,...)
typedef NSString *(^FSLabelForIndexGetter)(NSUInteger index);

// Same as above, but for the value (for adding a currency, or a unit symbol for example)
typedef NSString *(^FSLabelForValueGetter)(CGFloat value);

// Number of visible step in the chart
@property (nonatomic, readwrite) int gridStep;

// Margin of the chart
@property (nonatomic, readwrite) CGFloat margin;

@property (nonatomic, readonly) CGFloat axisWidth;
@property (nonatomic, readonly) CGFloat axisHeight;

// Decoration parameters, let you pick the color of the line as well as the color of the axis
@property (nonatomic, readwrite) UIColor* axisColor;
@property (nonatomic, readwrite) UIColor* color;

@property (copy) FSLabelForIndexGetter labelForIndex;
@property (copy) FSLabelForValueGetter labelForValue;

// Set the actual data for the chart, and then render it to the view.
- (void)setChartData:(NSArray *)chartData;

@end
