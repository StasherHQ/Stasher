//
//  STAvatarsViewController.h
//  Stasher
//
//  Created by Bhushan on 30/04/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvatarCollectionViewCell.h"

@protocol AvatarVCDelegate <NSObject>

@optional

- (void)avatarSelectedWithImgName:(NSString*)imgNameStr;

@end

@interface STAvatarsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{

}

@property (weak) id <AvatarVCDelegate> delegate;
@property (nonatomic, strong) IBOutlet UICollectionView *avatarCollectionView;
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) NSArray *dataArray;
@end
