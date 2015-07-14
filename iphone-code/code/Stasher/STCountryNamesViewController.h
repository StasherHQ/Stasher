//
//  STCountryNamesViewController.h
//  Stasher
//
//  Created by bhushan on 22/12/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountryNamesViewDelegate <NSObject>

- (void) countryNamesViewCancelPressed;
- (void) countryNamesViewOkPressedWithCountryId:(int)selectedCountryIndex;

@end


@interface STCountryNamesViewController : UIViewController
{
    NSIndexPath *selectedIndexPath;
}
@property (weak) id <CountryNamesViewDelegate> delegate;
@property (nonatomic, strong) IBOutlet UITableView *countryNamesTableView;
@property (nonatomic, strong) NSMutableArray *countryNamesArray;
@property (nonatomic, strong) IBOutlet UIView *popUpContainerView;
@property (nonatomic, strong) IBOutlet UILabel *selectContryLabel;
@property (nonatomic, strong) IBOutlet UIButton *okButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;



- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andCountryArray:(NSMutableArray*)thisCountryArray;
@end
