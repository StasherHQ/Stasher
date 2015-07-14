//
//  STChildAccountParentDetailsViewController.h
//  Stasher
//
//  Created by bhushan on 03/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STChildAccountParentDetailsViewController : UIViewController <STSharedCustomsDelegate>
{

}
@property (nonatomic, strong) NSMutableDictionary *parentDetailsDictionary;
@property (nonatomic, strong) IBOutlet UILabel *labelUsername;
@property (nonatomic, strong) IBOutlet UILabel *labelCompleteName;
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UIImageView *parentProfilePictureImgView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andParentDetailsDictionary:(NSDictionary*)thisDetailsDict;
@end
