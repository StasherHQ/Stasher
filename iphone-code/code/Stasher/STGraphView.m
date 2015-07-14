//
//  STGraphView.m
//  Stasher
//
//  Created by bhushan on 01/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STGraphView.h"

#define DisplaceMent 3.0f

@interface STGraphView ()

@property (nonatomic, strong) NSMutableArray* data;

@property (nonatomic) CGFloat min;
@property (nonatomic) CGFloat max;
@property (nonatomic) CGMutablePathRef initialPath;
@property (nonatomic) CGMutablePathRef newPath;

@end

@implementation STGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:231.0f/255 green:230.0f/255 blue:231.0f/255 alpha:1.0];
        [self setDefaultParameters];
    }
    return self;
}

- (void)setChartData:(NSArray *)chartData
{
    _data = [NSMutableArray arrayWithArray:chartData];
    _gridStep = (int)[_data count];
    _min = MAXFLOAT;
    _max = -MAXFLOAT;
    
    for(int i=0;i<_data.count;i++) {
        NSNumber* number = _data[i];
        if([number floatValue] < _min)
            _min = [number floatValue];
        
        if([number floatValue] > _max)
            _max = [number floatValue];
    }
    
    _max = [self getUpperRoundNumber:_max forGridStep:_gridStep];
    
    // No data
    if(isnan(_max)) {
        _max = 1;
    }
    
    [self strokeChart];
    
    if(_labelForValue) {
        for(int i=0;i<_gridStep;i++) {
            CGPoint p = CGPointMake(_margin , _axisHeight + _margin - (i + 1) * _axisHeight / _gridStep);
            
            NSString* text = _labelForValue(_max / _gridStep * (i + 1));
            CGRect rect = CGRectMake(_margin, p.y + 2, self.frame.size.width - _margin * 2 - 4.0f, 14);
            
            float width =
            [text
             boundingRectWithSize:rect.size
             options:NSStringDrawingUsesLineFragmentOrigin
             attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:12.0f] }
             context:nil]
            .size.width;
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - width - 6, p.y - 5, width + 2 + 5, 14)];
            label.text = [NSString stringWithFormat:@"$%@",text];
            label.font = [UIFont FontGothamRoundedBoldWithSize:5.95f];
            label.textColor = [UIColor colorWithRed:94.0f/255 green:94.0f/255 blue:94.0f/255 alpha:1.0];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            
            [self addSubview:label];
        }
    }
    
    if(_labelForIndex) {
        float scale = 1.0f;
        int q = (int)_data.count / _gridStep;
        scale = (CGFloat)(q * _gridStep) / (CGFloat)(_data.count - 1);
        
        for(int i=0;i<_gridStep-1 + 1;i++) {
            NSInteger itemIndex = q * i;
            if(itemIndex >= _data.count)
            {
                itemIndex = _data.count - 1;
            }
            
            NSString* text = _labelForIndex(itemIndex+1);
            CGPoint p = CGPointMake(_margin + i * (_axisWidth / _gridStep) * scale, _axisHeight + _margin);
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - 14.0f, p.y + 2, self.frame.size.width, 14)];
            label.text = [NSString stringWithFormat:@"Day %@",text];
            label.font = [UIFont FontGothamRoundedBoldWithSize:5.0f];
            label.textColor = [UIColor colorWithRed:130.0f/255 green:130.0f/255 blue:130.0f/255 alpha:1.0];
            [self addSubview:label];
        }
    }
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self drawGrid];
}

- (void)drawGrid
{
    _gridStep = (int)[_data count];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(ctx);
    CGContextSetLineWidth(ctx, 2);
    CGContextSetStrokeColorWithColor(ctx, [_axisColor CGColor]);
    
    // draw coordinate axis
    CGContextMoveToPoint(ctx, _margin + DisplaceMent, _margin);
    CGContextAddLineToPoint(ctx, _margin + DisplaceMent, _axisHeight + _margin + DisplaceMent);
    CGContextStrokePath(ctx);
    
    
    CGContextMoveToPoint(ctx, _margin + DisplaceMent, _axisHeight + _margin);
    CGContextAddLineToPoint(ctx, _axisWidth + _margin + DisplaceMent, _axisHeight + _margin);
    CGContextStrokePath(ctx);
    
    float scale = 1.0f;
    int q = (int)_data.count / _gridStep;
    scale = (CGFloat)(q * _gridStep) / (CGFloat)(_data.count - 1);
    
    
    // draw grid
    for(int i=0;i<_gridStep;i++) {
        CGContextSetLineWidth(ctx, 0.5);
        
        CGPoint point = CGPointMake((1 + i) * _axisWidth / _gridStep * scale + _margin, _margin);
        
        CGContextMoveToPoint(ctx, point.x, point.y);
        CGContextAddLineToPoint(ctx, point.x, 4);
        CGContextStrokePath(ctx);
        
        
        CGContextSetLineWidth(ctx, 2);
        CGContextMoveToPoint(ctx, point.x - 0.5f, _axisHeight + _margin);
        CGContextAddLineToPoint(ctx, point.x - 0.5f, _axisHeight + _margin + DisplaceMent);
        CGContextStrokePath(ctx);
    }
    
    for(int i=0;i<_gridStep;i++) {
        CGContextSetLineWidth(ctx, 0.5);
        
        CGPoint point = CGPointMake(_margin + 5, (i) * _axisHeight / _gridStep + _margin);
        
        CGContextMoveToPoint(ctx, point.x, point.y);
        CGContextAddLineToPoint(ctx, _axisWidth + _margin, point.y);
        CGContextStrokePath(ctx);
    }
    
}

- (void)strokeChart
{
    if([_data count] == 0) {
        NSLog(@"Warning: no data provided for the chart");
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    UIBezierPath *noPath = [UIBezierPath bezierPath];
    UIBezierPath* fill = [UIBezierPath bezierPath];
    UIBezierPath* noFill = [UIBezierPath bezierPath];
    
    CGFloat scale = _axisHeight / _max;
    NSNumber* first = _data[0];
    
    for(int i=1;i<_data.count;i++) {
        NSNumber* last = _data[i - 1];
        NSNumber* number = _data[i];
        
        CGPoint p1 = CGPointMake(_margin + (i - 1) * (_axisWidth / (_data.count - 1)), _axisHeight + _margin - [last floatValue] * scale);
        
        CGPoint p2 = CGPointMake(_margin + i * (_axisWidth / (_data.count - 1)), _axisHeight + _margin - [number floatValue] * scale);
        
        [fill moveToPoint:p1];
        [fill addLineToPoint:p2];
        [fill addLineToPoint:CGPointMake(p2.x, _axisHeight + _margin)];
        [fill addLineToPoint:CGPointMake(p1.x, _axisHeight + _margin)];
        
        [noFill moveToPoint:CGPointMake(p1.x, _axisHeight + _margin)];
        [noFill addLineToPoint:CGPointMake(p2.x, _axisHeight + _margin)];
        [noFill addLineToPoint:CGPointMake(p2.x, _axisHeight + _margin)];
        [noFill addLineToPoint:CGPointMake(p1.x, _axisHeight + _margin)];
    }
    
    
    [path moveToPoint:CGPointMake(DisplaceMent+2 +_margin, _axisHeight + _margin - [first floatValue] * scale)];
    [noPath moveToPoint:CGPointMake(_margin, _axisHeight + _margin)];
    
    for(int i=1;i<_data.count;i++) {
        NSNumber* number = _data[i];
        
        [path addLineToPoint:CGPointMake(_margin + i * (_axisWidth / (_data.count - 1)), _axisHeight + _margin - [number floatValue] * scale)];
        [noPath addLineToPoint:CGPointMake(_margin + i * (_axisWidth / (_data.count - 1)), _axisHeight + _margin)];
    }
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.frame = self.bounds;
    fillLayer.bounds = self.bounds;
    fillLayer.path = fill.CGPath;
    fillLayer.strokeColor = nil;
    fillLayer.fillColor = [UIColor clearColor].CGColor;//[_color colorWithAlphaComponent:0.25].CGColor;
    fillLayer.lineWidth = 0;
    fillLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:fillLayer];
    
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.bounds;
    pathLayer.bounds = self.bounds;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [_color CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 1.5;
    pathLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:pathLayer];
    
    CABasicAnimation *fillAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    fillAnimation.duration = 0.25;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.fromValue = (id)noFill.CGPath;
    fillAnimation.toValue = (id)fill.CGPath;
    [fillLayer addAnimation:fillAnimation forKey:@"path"];
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 1.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = (__bridge id)(noPath.CGPath);
    pathAnimation.toValue = (__bridge id)(path.CGPath);
    //[pathLayer addAnimation:pathAnimation forKey:@"path"];
    
    for(int i=0;i<_data.count;i++) {
        CGRect rect;
        NSNumber* number = _data[i];
        //
        if(i == 0)
            rect = CGRectMake(_margin+ 2*DisplaceMent + i * (_axisWidth / (_data.count - 1)) - 1.2 * _margin, _axisHeight + _margin - [number floatValue] * scale - _margin,10 ,10);
        else
            rect = CGRectMake(_margin + i * (_axisWidth / (_data.count - 1)) - 1.2 * _margin, _axisHeight + _margin - [number floatValue] * scale - _margin,10 ,10);
        
        UIView *circleView = [[UIView alloc] initWithFrame:rect];
        circleView.alpha = 1.0;
        circleView.layer.cornerRadius = 6;
        circleView.backgroundColor = [UIColor colorWithRed:247.0f/255 green:203.0f/255 blue:73.0/255 alpha:1.0];
        circleView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        circleView.layer.borderWidth=0.5f;
        [self addSubview:circleView];
        //
    }
}

- (void)setDefaultParameters
{
    _color = [UIColor colorWithRed:117.0f/255 green:185.0f/255 blue:220.0f/255 alpha:1.0];
    _gridStep = 3;
    _margin = 5.0f;
    _axisWidth = self.frame.size.width - 2 * _margin;
    _axisHeight = self.frame.size.height - 2 * _margin;
    _axisColor = [UIColor colorWithRed:209.0f/255 green:209.0f/255 blue:209.0f/255 alpha:1.0];
}

- (CGFloat)getUpperRoundNumber:(CGFloat)value forGridStep:(int)gridStep
{
    // We consider a round number the following by 0.5 step instead of true round number (with step of 1)
    CGFloat logValue = log10f(value);
    CGFloat scale = powf(10, floorf(logValue));
    CGFloat n = ceilf(value / scale * 2);
    
    int tmp = (int)(n) % gridStep;
    
    if(tmp != 0) {
        n += gridStep - tmp;
    }
    
    return n * scale / 2.0f;
}

@end
