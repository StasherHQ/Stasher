//
//  STNoInternetView.m
//  Stasher
//
//  Created by Bhushan on 23/03/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import "STNoInternetView.h"

@implementation STNoInternetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithDefaultSizeandSuperView:(UIView*)thisSuperView
{
    self = [super initWithFrame:CGRectMake(0.0f, thisSuperView.frame.size.height - 30.0f, thisSuperView.frame.size.width, 30.0f)];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        UILabel *labl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, thisSuperView.frame.size.width, 30.0f)];
        [labl setTextAlignment:NSTextAlignmentCenter];
        [labl setText:@"No Internet Connection"];
        [labl setTextColor:[UIColor whiteColor]];
        [labl setFont:[UIFont FontGothamRoundedBookWithSize:9.0f]];
        [self addSubview:labl];
        [thisSuperView addSubview:self withAnimation:YES];
        [self performSelector:@selector(removeSelfFromSuperView) withObject:nil afterDelay:1.5f];
        self.alpha = 0.7;
    }
    return self;
}

- (void)removeSelfFromSuperView
{
    [self removeFromSuperviewwithAnimation:YES];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

@end
