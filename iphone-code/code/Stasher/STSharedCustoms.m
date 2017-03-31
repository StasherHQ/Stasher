//
//  NSObject+STSharedCustoms.m
//  Stasher
//
//  Created by bhushan on 15/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import "STSharedCustoms.h"

static STSharedCustoms* __instance = nil;

@implementation STSharedCustoms


+(STSharedCustoms*) sharedAddGestureInstanceWithDelegate:(id)delegate
{
    @synchronized(self) {
        if ( __instance == nil ) {
            __instance = [[STSharedCustoms alloc] init];
        }
    }
    __instance.delegate = delegate;
    return __instance;
}


- (void)setDelegate:(id<STSharedCustomsDelegate>)delegate
{
    _delegate = delegate;
}

- (void) addRightSwipeGestureRecognizerToMe
{
    UISwipeGestureRecognizer  *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipe:)];
    swipeLeft.numberOfTouchesRequired = 1;//give required num of touches here ..
    swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
    swipeLeft.delegate = (id)self;
    UIViewController *vc = (UIViewController*)__instance.delegate;
    [vc.view addGestureRecognizer:swipeLeft];
}

-(void)handleRightSwipe:(UISwipeGestureRecognizer *)recognizer{
    //Do ur code for Push/pop..
    if ([__instance.delegate respondsToSelector:@selector(rightGestureHandle)]) {
        [__instance.delegate rightGestureHandle];
    }
}


@end
