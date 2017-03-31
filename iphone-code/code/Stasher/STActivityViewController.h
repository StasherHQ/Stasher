//
//  STActivityViewController.h
//  Stasher
//
//  Created by bhushan on 13/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParentActivityViewController.h"
#import "STChildActivityViewController.h"
#import "STActivityDetailsViewController.h"

@interface STActivityViewController : UIViewController <ParentActivityDelegate,ChildActivityDelegate>
{
    STParentActivityViewController *parentActivityVC;
    STChildActivityViewController *childActivityVC;
    
}

@property (nonatomic, strong) IBOutlet UIView *containerView;


@end
