//
//  NSObject+STSharedCustoms.h
//  Stasher
//
//  Created by bhushan on 15/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol STSharedCustomsDelegate <NSObject>

- (void)rightGestureHandle;

@end

@interface STSharedCustoms : NSObject
{

}

@property (nonatomic, weak) id <STSharedCustomsDelegate> delegate;

+ (STSharedCustoms*) sharedAddGestureInstanceWithDelegate:(id)delegate;
- (void) addRightSwipeGestureRecognizerToMe;
@end
