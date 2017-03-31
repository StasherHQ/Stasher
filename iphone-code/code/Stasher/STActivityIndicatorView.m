//
//  STActivityIndicatorView.m
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STActivityIndicatorView.h"

#define ANGLE(a) 2*M_PI/360*a

@interface STActivityIndicatorView ()

//0.0 - 1.0
@property (nonatomic, assign) CGFloat anglePer;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation STActivityIndicatorView

- (id)initWithDefaultSizeandSuperView:(UIView*)thisSuperView
{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 35.0f, 35.0f)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.center = thisSuperView.center;
        bgVC = [[STActivityBGViewController alloc] initWithNibName:@"STActivityBGViewController" bundle:[NSBundle mainBundle]];
        [bgVC.view addSubview:self];
        [bgVC.view setFrame:[[[UIApplication sharedApplication] keyWindow] bounds]];
        [[[UIApplication sharedApplication] keyWindow] addSubview:bgVC.view];
        //[thisSuperView addSubview:bgVC];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setAnglePer:(CGFloat)anglePer
{
    _anglePer = anglePer;
    [self setNeedsDisplay];
}

- (void)startAnimation
{
    if (self.isAnimating) {
        [self stopAnimation];
        [self.layer removeAllAnimations];
    }
    _isAnimating = YES;
    
    self.anglePer = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02f
                                                  target:self
                                                selector:@selector(drawPathAnimation:)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopAnimation
{
    _isAnimating = NO;
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self stopRotateAnimation];
}

- (void)drawPathAnimation:(NSTimer *)timer
{
    self.anglePer += 0.03f;
    if (self.anglePer >= 1) {
        self.anglePer = 1;
        [timer invalidate];
        self.timer = nil;
        [self startRotateAnimation];
    }
}

- (void)startRotateAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(2*M_PI);
    animation.duration = 1.f;
    animation.repeatCount = INT_MAX;
    
    [self.layer addAnimation:animation forKey:@"keyFrameAnimation"];
}

- (void)stopRotateAnimation
{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.anglePer = 0;
        [self.layer removeAllAnimations];
        self.alpha = 1;
        [bgVC.view removeFromSuperviewwithAnimation:YES];
    }];
}

- (void)drawRect:(CGRect)rect
{
    if (self.anglePer <= 0) {
        _anglePer = 0;
    }
    
    CGFloat lineWidth = 1.5f;
    UIColor *lineColor = [UIColor colorWithRed:64.0/255.0
                                         green:178.0/255.0 blue:241.0/255.0 alpha:1.0]; //[UIColor cyanColor];
    if (self.lineWidth) {
        lineWidth = self.lineWidth;
    }
    if (self.lineColor) {
        lineColor = self.lineColor;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextAddArc(context,
                    CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds),
                    CGRectGetWidth(self.bounds)/2 - lineWidth,
                    ANGLE(120), ANGLE(120)+ANGLE(330)*self.anglePer,
                    0);
   
    CGContextStrokePath(context);
}


@end
